CREATE DATABASE OrderManagementDB;
USE OrderManagementDB;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

INSERT INTO Customer VALUES
(101, 'Rahul', '9876543210', 'rahul@gmail.com'),
(102, 'Priya', '9876543211', 'priya@gmail.com'),
(103, 'Arun', '9876543212', 'arun@gmail.com');

INSERT INTO Product VALUES
(201, 'Laptop', 55000.00),
(202, 'Mobile Phone', 20000.00),
(203, 'Headphones', 1500.00),
(204, 'Keyboard', 800.00),
(205, 'Mouse', 500.00);

INSERT INTO Orders VALUES
(1, 101, '2026-08-15', 56500.00),
(2, 102, '2026-08-16', 20800.00),
(3, 103, '2026-08-17', 2000.00);

INSERT INTO Order_Details VALUES
(1, 1, 201, 1, 55000.00),
(2, 1, 203, 1, 1500.00),
(3, 2, 202, 1, 20000.00),
(4, 2, 204, 1, 800.00),
(5, 3, 203, 1, 1500.00),
(6, 3, 205, 1, 500.00);

SELECT * FROM Customer;
SELECT * FROM Product;

SELECT * FROM Orders;

SELECT * FROM Order_Details;

UPDATE Orders
SET total_amount = 58000.00
WHERE order_id = 1;


-- 15. Modify Order Quantity
UPDATE Order_Details
SET quantity = 2
WHERE order_detail_id = 5;

SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    od.quantity,
    od.price,
    (od.quantity * od.price) AS item_total
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Product p
ON od.product_id = p.product_id
ORDER BY c.customer_name, o.order_date;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_amount_spent
FROM Customer c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount
FROM Orders o
JOIN Customer c
ON o.customer_id = c.customer_id
ORDER BY o.order_date;