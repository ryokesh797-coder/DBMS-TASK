CREATE DATABASE ProductCategoryDB;
USE ProductCategoryDB;
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2),
    stock INT,

    FOREIGN KEY (category_id)
    REFERENCES Category(category_id)
);

INSERT INTO Category VALUES
(1, 'Electronics'),
(2, 'Accessories'),
(3, 'Stationery'),
(4, 'Clothing');

INSERT INTO Product VALUES
(101, 'Laptop', 1, 55000.00, 10),
(102, 'Mobile Phone', 1, 20000.00, 15),
(103, 'Headphones', 2, 1500.00, 20),
(104, 'Keyboard', 2, 800.00, 12),
(105, 'Notebook', 3, 100.00, 50),
(106, 'Pen', 3, 20.00, 100),
(107, 'T-Shirt', 4, 700.00, 25);
SELECT * FROM Category;
SELECT * FROM Product;

UPDATE Product
SET price = 60000.00,
    stock = 12
WHERE product_id = 101;

DELETE FROM Product
WHERE product_id = 107;

SELECT * FROM Product;
SELECT
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name,
    p.price,
    p.stock
FROM Category c
JOIN Product p
ON c.category_id = p.category_id
ORDER BY c.category_name;

SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM Category c
LEFT JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;
SELECT
    c.category_name,
    SUM(p.stock) AS total_stock
FROM Category c
JOIN Product p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

SELECT
    p.product_id,
    p.product_name,
    p.stock,
    c.category_name
FROM Product p
JOIN Category c
ON p.category_id = c.category_id
WHERE p.stock < 15;