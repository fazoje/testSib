const express = require('express');
const bodyParser = require('body-parser');
const { connection } = require('./db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const app = express();
require('dotenv').config();

const JWT_SECRET = process.env.JWT_SECRET;

app.use(bodyParser.json());
app.use(express.static(__dirname + '/public'));

// Function to check allowed characters in username
function isSafeString(str) {
    // Only allow letters, numbers, _, -, . (can be extended)
    return /^[a-zA-Z0-9_.\-а-яА-Я]+$/.test(str);
}

// Registration route
app.post('/api/register', async (req, res) => {
    const { username, password, first_name, last_name, gender, birthdate } = req.body;
    if (!username || !password || !first_name || !last_name || !gender || !birthdate) {
        return res.status(400).json({ error: 'Please fill in all fields' });
    }
    if (!isSafeString(username)) {
        return res.status(400).json({ error: 'Invalid characters in username' });
    }

    connection.query(
        'SELECT id FROM users WHERE username = ?',
        [username],
        async (err, results) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            if (results.length > 0) return res.status(409).json({ error: 'User already exists' });

            const hashedPassword = await bcrypt.hash(password, 10);

            connection.query(
                'INSERT INTO users (username, password, first_name, last_name, gender, birthdate) VALUES (?, ?, ?, ?, ?, ?)',
                [username, hashedPassword, first_name, last_name, gender, birthdate],
                (err) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    res.json({ success: true });
                }
            );
        }
    );
});

// Login route
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    if (!username || !password) return res.status(400).json({ error: 'Please fill in all fields' });

    connection.query(
        'SELECT id, password FROM users WHERE username = ?',
        [username],
        async (err, results) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            if (results.length === 0) return res.status(401).json({ error: 'Invalid credentials' });

            const user = results[0];
            const match = await bcrypt.compare(password, user.password);
            if (!match) return res.status(401).json({ error: 'Invalid credentials' });

            const token = jwt.sign({ id: user.id, username }, JWT_SECRET, { expiresIn: '1h' });
            res.json({ success: true, token });
        }
    );
});

// JWT authentication middleware
function authMiddleware(req, res, next) {
    const auth = req.headers.authorization;
    if (!auth) return res.status(401).json({ error: 'No token provided' });
    const token = auth.split(' ')[1];
    try {
        req.user = jwt.verify(token, JWT_SECRET);
        next();
    } catch {
        res.status(401).json({ error: 'Invalid token' });
    }
}

// Middleware to check isAdmin
function adminMiddleware(req, res, next) {
    connection.query(
        'SELECT isAdmin FROM users WHERE id = ?',
        [req.user.id],
        (err, results) => {
            if (err || results.length === 0) return res.status(403).json({ error: 'Access denied' });
            if (!results[0].isAdmin) return res.status(403).json({ error: 'Access denied' });
            next();
        }
    );
}

// CSRF protection middleware: allow only requests from same origin
function csrfMiddleware(req, res, next) {
    const allowedOrigin = 'http://localhost:3000';
    const origin = req.headers.origin;
    const referer = req.headers.referer;
    if (
        (origin && origin !== allowedOrigin) ||
        (referer && !referer.startsWith(allowedOrigin))
    ) {
        return res.status(403).json({ error: 'CSRF protection: invalid origin' });
    }
    next();
}

// Apply CSRF middleware to all API routes except static files
app.use('/api', csrfMiddleware);

// Get user profile
app.get('/api/profile', authMiddleware, (req, res) => {
    connection.query(
        'SELECT username, first_name, last_name, gender, birthdate FROM users WHERE id = ?',
        [req.user.id],
        (err, results) => {
            if (err || results.length === 0) return res.status(500).json({ error: 'Server error' });
            const user = results[0];
            for (let k in user) user[k] = sanitize(user[k]);
            res.json(user);
        }
    );
});

// Update user profile
app.put('/api/profile', authMiddleware, (req, res) => {
    const { first_name, last_name, gender, birthdate } = req.body;
    if (!first_name || !last_name || !gender || !birthdate) {
        return res.status(400).json({ error: 'Please fill in all fields' });
    }
    connection.query(
        'UPDATE users SET first_name = ?, last_name = ?, gender = ?, birthdate = ? WHERE id = ?',
        [first_name, last_name, gender, birthdate, req.user.id],
        (err) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            res.json({ success: true });
        }
    );
});

// Change username route (with password confirmation)
app.put('/api/change-username', authMiddleware, (req, res) => {
    const { new_username, password } = req.body;
    if (!new_username || !password) return res.status(400).json({ error: 'Specify new username and confirm with password' });
    if (!isSafeString(new_username)) {
        return res.status(400).json({ error: 'Invalid characters in username' });
    }

    // Check the current user password
    connection.query(
        'SELECT password FROM users WHERE id = ?',
        [req.user.id],
        async (err, results) => {
            if (err || results.length === 0) return res.status(500).json({ error: 'Server error' });
            const user = results[0];
            const ok = await bcrypt.compare(password, user.password);
            if (!ok) return res.status(401).json({ error: 'Incorrect password' });

            // Check unique login
            connection.query(
                'SELECT id FROM users WHERE username = ? AND id != ?',
                [new_username, req.user.id],
                (err, results) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    if (results.length > 0) return res.status(409).json({ error: 'Username already taken' });

                    connection.query(
                        'UPDATE users SET username = ? WHERE id = ?',
                        [new_username, req.user.id],
                        (err) => {
                            if (err) return res.status(500).json({ error: 'Server error' });
                            res.json({ success: true, username: new_username });
                        }
                    );
                }
            );
        }
    );
});

// Change password route
app.put('/api/change-password', authMiddleware, async (req, res) => {
    const { old_password, new_password } = req.body;
    if (!old_password || !new_password) {
        return res.status(400).json({ error: 'Please fill in both fields' });
    }
    connection.query(
        'SELECT password FROM users WHERE id = ?',
        [req.user.id],
        async (err, results) => {
            if (err || results.length === 0) return res.status(500).json({ error: 'Server error' });
            const user = results[0];
            const match = await bcrypt.compare(old_password, user.password);
            if (!match) return res.status(401).json({ error: 'Old password is incorrect' });

            const hashedPassword = await bcrypt.hash(new_password, 10);
            connection.query(
                'UPDATE users SET password = ? WHERE id = ?',
                [hashedPassword, req.user.id],
                (err) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    res.json({ success: true });
                }
            );
        }
    );
});

// Get all users (admin only)
app.get('/api/admin/users', authMiddleware, adminMiddleware, (req, res) => {
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    const sortField = ['id', 'username', 'first_name', 'birthdate'].includes(req.query.sortField) ? req.query.sortField : 'id';
    const sortOrder = req.query.sortOrder === 'desc' ? 'DESC' : 'ASC';
    const offset = (page - 1) * pageSize;
    const search = req.query.search ? req.query.search.trim() : '';

    let where = '';
    let params = [];
    if (search) {
        where = 'WHERE username LIKE ? OR first_name LIKE ? OR last_name LIKE ?';
        params = [`%${search}%`, `%${search}%`, `%${search}%`];
    }

    // Get total number of users taking into account the search
    connection.query(
        `SELECT COUNT(*) as count FROM users ${where}`,
        params,
        (err, countResult) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            const total = countResult[0].count;

            // Get users with sorting, pagination, and search
            connection.query(
                `SELECT id, username, first_name, last_name, gender, birthdate, isAdmin, created_at
                 FROM users
                 ${where}
                 ORDER BY ${sortField} ${sortOrder}
                 LIMIT ? OFFSET ?`,
                [...params, pageSize, offset],
                (err, results) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    // Sanitize each user field
                    results.forEach(user => {
                        for (let k in user) user[k] = sanitize(user[k]);
                    });
                    res.json({ users: results, total });
                }
            );
        }
    );
});

// Update user data (admin only)
app.put('/api/admin/users/:id', authMiddleware, adminMiddleware, async (req, res) => {
    const { username, first_name, last_name, gender, birthdate, isAdmin, password } = req.body;
    const userId = req.params.id;
    if (!username || !first_name || !last_name || !gender || !birthdate) {
        return res.status(400).json({ error: 'Please fill in all fields' });
    }
    // Check unique login
    connection.query(
        'SELECT id FROM users WHERE username = ? AND id != ?',
        [username, userId],
        async (err, results) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            if (results.length > 0) return res.status(409).json({ error: 'Username already taken by another user' });

            let query, params;
            if (password) {
                const hashedPassword = await bcrypt.hash(password, 10);
                query = 'UPDATE users SET username = ?, first_name = ?, last_name = ?, gender = ?, birthdate = ?, isAdmin = ?, password = ? WHERE id = ?';
                params = [username, first_name, last_name, gender, birthdate, !!isAdmin, hashedPassword, userId];
            } else {
                query = 'UPDATE users SET username = ?, first_name = ?, last_name = ?, gender = ?, birthdate = ?, isAdmin = ? WHERE id = ?';
                params = [username, first_name, last_name, gender, birthdate, !!isAdmin, userId];
            }
            connection.query(
                query,
                params,
                (err) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    res.json({ success: true });
                }
            );
        }
    );
});

// Delete user (admin only)
app.delete('/api/admin/users/:id', authMiddleware, adminMiddleware, (req, res) => {
    const userId = req.params.id;
    // Prevent admin from deleting himself
    if (parseInt(userId) === req.user.id) {
        return res.status(400).json({ error: "Administrator cannot delete himself." });
    }
    connection.query(
        'DELETE FROM users WHERE id = ?',
        [userId],
        (err) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            res.json({ success: true });
        }
    );
});

// Check if current user is admin
app.get('/api/check-admin', authMiddleware, (req, res) => {
    connection.query(
        'SELECT isAdmin FROM users WHERE id = ?',
        [req.user.id],
        (err, results) => {
            if (err || results.length === 0) return res.status(500).json({ error: 'Server error' });
            res.json({ isAdmin: !!results[0].isAdmin });
        }
    );
});

// Create new user (admin only)
app.post('/api/admin/users', authMiddleware, adminMiddleware, async (req, res) => {
    const { username, password, first_name, last_name, gender, birthdate, isAdmin } = req.body;
    if (!username || !password || !first_name || !last_name || !gender || !birthdate) {
        return res.status(400).json({ error: 'Please fill in all fields' });
    }
    if (!isSafeString(username)) {
        return res.status(400).json({ error: 'Invalid characters in username' });
    }
    connection.query(
        'SELECT id FROM users WHERE username = ?',
        [username],
        async (err, results) => {
            if (err) return res.status(500).json({ error: 'Server error' });
            if (results.length > 0) return res.status(409).json({ error: 'User already exists' });

            const hashedPassword = await bcrypt.hash(password, 10);

            connection.query(
                'INSERT INTO users (username, password, first_name, last_name, gender, birthdate, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?)',
                [username, hashedPassword, first_name, last_name, gender, birthdate, !!isAdmin],
                (err) => {
                    if (err) return res.status(500).json({ error: 'Server error' });
                    res.json({ success: true });
                }
            );
        }
    );
});

// Example: sanitize output to prevent XSS (for profile and users list)
function sanitize(str) {
    if (typeof str !== 'string') return str;
    return str.replace(/[<>&"'`]/g, function (c) {
        return ({
            '<': '&lt;',
            '>': '&gt;',
            '&': '&amp;',
            '"': '&quot;',
            "'": '&#39;',
            '`': '&#96;'
        })[c];
    });
}

// Start server
app.listen(3000, () => {
    console.log('Server started at http://localhost:3000');
});
