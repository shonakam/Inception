
-- Step 1: Create the WordPress database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS wordpress;

-- Step 2: Create a new database user with a specified password, allowing connections from any host
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY 'wp_pass';

-- Step 3: Grant all privileges on the 'wordpress' database to the new user
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';

-- Step 4: Reload the privilege tables to apply the changes immediately
FLUSH PRIVILEGES;
