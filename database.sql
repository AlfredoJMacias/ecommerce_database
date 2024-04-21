-- Create Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    stock INT,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create Order Details Table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Create Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10, 2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Create Reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    user_id INT,
    rating INT,
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Views for data security
CREATE VIEW ProductCatalog AS
SELECT product_id, name, description, price, stock
FROM products;

CREATE VIEW CustomerOrders AS
SELECT u.username, o.order_id, o.order_date, o.status, od.product_id, od.quantity, od.price
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id;

-- Triggers for data integrity
CREATE TRIGGER AfterOrderPlacement
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END;

CREATE TRIGGER LogOrderStatusChange
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO order_logs (order_id, previous_status, new_status, change_date)
        VALUES (NEW.order_id, OLD.status, NEW.status, NOW());
    END IF;
END;

-- Stored procedures for business operations
CREATE PROCEDURE AddNewOrder(IN user_id INT, IN status VARCHAR(50))
BEGIN
    INSERT INTO orders (user_id, status) VALUES (user_id, status);
END;

CREATE PROCEDURE ProcessPayment(IN order_id INT, IN amount DECIMAL(10, 2), IN method VARCHAR(50))
BEGIN
    INSERT INTO payments (order_id, amount, payment_method) VALUES (order_id, amount, method);
END;

-- Function to calculate total sales for a product
CREATE FUNCTION TotalSales(product_id INT) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(od.quantity * od.price) INTO total
    FROM order_details od
    WHERE od.product_id = product_id;
    RETURN total;
END;

-- Sample complex queries
-- Total sales by category
SELECT c.name AS Category, SUM(od.price * od.quantity) AS TotalSales
FROM categories c
JOIN products p ON c.category_id = p.category_id
JOIN order_details od ON p.product_id = od.product_id
GROUP BY c.name;

-- Users who have not made any orders
SELECT u.username
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;

-- Top 3 most reviewed products
SELECT p.name, COUNT(r.review_id) AS ReviewCount
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id
ORDER BY ReviewCount DESC
LIMIT 3;
