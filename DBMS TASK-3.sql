CREATE DATABASE SellerInventoryDB;
USE SellerInventoryDB;

CREATE TABLE Seller (
    seller_id INT PRIMARY KEY,
    seller_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    seller_id INT,
    product_id INT,
    stock_quantity INT,
    status VARCHAR(20),

    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Seller VALUES
(101, 'Rahul', '9876543210', 'rahul@gmail.com'),
(102, 'Priya', '9876543211', 'priya@gmail.com'),
(103, 'Arun', '9876543212', 'arun@gmail.com');

INSERT INTO Product VALUES
(201, 'Laptop', 'Electronics', 55000.00),
(202, 'Mobile Phone', 'Electronics', 20000.00),
(203, 'Headphones', 'Accessories', 1500.00),
(204, 'Keyboard', 'Accessories', 800.00),
(205, 'Mouse', 'Accessories', 500.00);

INSERT INTO Inventory VALUES
(1, 101, 201, 10, 'Available'),
(2, 101, 203, 0, 'Unavailable'),
(3, 102, 202, 15, 'Available'),
(4, 102, 204, 5, 'Available'),
(5, 103, 205, 0, 'Unavailable');

SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Inventory;
SELECT 
    p.product_id,
    p.product_name,
    s.seller_name,
    i.stock_quantity,
    i.status
FROM Inventory i

SELECT 
    p.product_id,
    p.product_name,
    s.seller_name,
    i.stock_quantity,
    i.status
FROM Inventory i
JOIN Seller s
ON i.seller_id = s.seller_id
JOIN Product p
ON i.product_id = p.product_id
WHERE i.stock_quantity = 0;
UPDATE Inventory
SET stock_quantity = 10,
    status = 'Available'
WHERE inventory_id = 5;

SELECT 
    s.seller_name,
    p.product_name,
    p.category,
    p.price,
    i.stock_quantity,
    i.status
FROM Inventory i
JOIN Seller s
ON i.seller_id = s.seller_id
JOIN Product p
ON i.product_id = p.product_id
ORDER BY s.seller_name;

SELECT 
    p.product_name,
    SUM(i.stock_quantity) AS total_stock
FROM Inventory i
JOIN Product p
ON i.product_id = p.product_id
GROUP BY p.product_name;