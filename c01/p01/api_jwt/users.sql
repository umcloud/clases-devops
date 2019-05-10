CREATE TABLE IF NOT EXISTS users (username TEXT NOT NULL PRIMARY KEY, password TEXT, firstname TEXT, lastname TEXT, email TEXT);
DELETE FROM users;
INSERT INTO users (username, password, firstname, lastname, email) VALUES("testuser", "supersecret", "Test", "User","testuser@somedomain.com");
