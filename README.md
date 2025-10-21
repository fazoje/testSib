# Sibers Test Web Application

## Installation

1. **Clone the repository** (if needed) and navigate to the project directory.

2. **Install dependencies:**
   ```bash
   npm install
   ```

## Database Configuration

1. Edit the `.env` file in the project root:

   ```
   JWT_SECRET=your_jwt_secret_key
   DB_HOST=your_mysql_host
   DB_USER=your_mysql_user
   DB_PASSWORD=your_mysql_password
   DB_NAME=your_db_name
   ```

   Replace the data with your actual MySQL credentials and JWT token.

2. Make sure your MySQL server is running and the database `sibers_test` exists.

## Test Users

For quick testing, use these accounts:

- **Admin:**  
  Username: `admin`  
  Password: `admin`

- **User:**  
  Username: `user`  
  Password: `user`

If these users do not exist, you can add them manually to the `users` table or use a temporary route in the backend to create them.

## Running the Application

Start the web application with:

```bash
npm start
```

The server will run at [http://localhost:3000](http://localhost:3000).
