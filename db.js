require('dotenv').config();
const mysql = require('mysql2');

// Create MySQL connection using environment variables
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// Connect to MySQL
connection.connect((err) => {
    if (err) {
        console.error('MySQL connection error:', err);
        return;
    }
    console.log('Successfully connected to MySQL!');
});

// Example: get all users with isAdmin field
function getAllUsers(callback) {
    connection.query(
        'SELECT id, username, password, first_name, last_name, gender, birthdate, created_at, isAdmin FROM users',
        (err, results) => {
            callback(err, results);
        }
    );
}

// Export connection and functions
module.exports = { connection, getAllUsers };

// All queries use parameterized statements to prevent SQL injection
