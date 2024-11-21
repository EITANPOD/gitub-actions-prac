-- Create the user only if it doesn't exist
DO
$$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'testuser') THEN
      CREATE ROLE testuser WITH LOGIN PASSWORD 'testpassword';
   END IF;
END
$$;

-- Create the database only if it doesn't exist
DO
$$
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'testdb') THEN
      CREATE DATABASE testdb;
   END IF;
END
$$;

-- Grant privileges to the user
GRANT ALL PRIVILEGES ON DATABASE testdb TO testuser;

-- Connect to the new database
\connect testdb;

-- Create the 'items' table if it doesn't exist
CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

-- Insert sample data into the 'items' table if it's empty
INSERT INTO items (name, description, price)
SELECT 'Item 1', 'Description for Item 1', 10.00
WHERE NOT EXISTS (SELECT 1 FROM items);
INSERT INTO items (name, description, price)
SELECT 'Item 2', 'Description for Item 2', 20.50
WHERE NOT EXISTS (SELECT 1 FROM items);
INSERT INTO items (name, description, price)
SELECT 'Item 3', 'Description for Item 3', 30.75
WHERE NOT EXISTS (SELECT 1 FROM items);
