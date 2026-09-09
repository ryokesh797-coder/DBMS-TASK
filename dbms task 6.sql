 CREATE DATABASE ProductReviewDB;

USE ProductReviewDB;

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_name VARCHAR(100),
    review_text VARCHAR(500),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Product VALUES
(101, 'Laptop', 55000.00),
(102, 'Smartphone', 25000.00),
(103, 'Headphones', 3000.00),
(104, 'Smart Watch', 5000.00),
(105, 'Keyboard', 1500.00);

INSERT INTO Review VALUES
(1, 101, 'Arun', 'Very good laptop', 5, '2026-09-01'),
(2, 101, 'Kumar', 'Good performance', 4, '2026-09-02'),
(3, 102, 'Ravi', 'Excellent phone', 5, '2026-09-03'),
(4, 102, 'Vijay', 'Battery is good', 4, '2026-09-04'),
(5, 103, 'Siva', 'Good sound quality', 4, '2026-09-04'),
(6, 104, 'Ajay', 'Excellent watch', 5, '2026-09-05'),
(7, 105, 'Hari', 'Average keyboard', 3, '2026-09-05');

SELECT 
    p.product_name,
    r.customer_name,
    r.review_text,
    r.rating,
    r.review_date
FROM Product p
JOIN Review r
ON p.product_id = r.product_id;

SELECT 
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating
FROM Product p
JOIN Review r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;


SELECT 
    p.product_name,
    AVG(r.rating) AS average_rating
FROM Product p
JOIN Review r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) >= 4;

SELECT 
    p.product_name,
    COUNT(r.review_id) AS total_reviews
FROM Product p
LEFT JOIN Review r
ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name;

