
CREATE DATABASE RelationshipDB;
USE RelationshipDB;

-- 1. Customer Table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- 2. Product Table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

-- 3. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 4. Order Item Table
CREATE TABLE Order_Item (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- 5. Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_mode VARCHAR(30),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- 6. Insert Customer Details
INSERT INTO Customer VALUES
(1,'Arun','Chennai'),
(2,'Priya','Madurai'),
(3,'Karthik','Salem'),
(4,'Divya','Coimbatore');

-- 7. Insert Product Details
INSERT INTO Product VALUES
(101,'Laptop',50000),
(102,'Mouse',500),
(103,'Keyboard',1000),
(104,'Headphone',2000);

-- 8. Insert Order Details
INSERT INTO Orders VALUES
(1001,1,'2026-10-01'),
(1002,2,'2026-10-02'),
(1003,1,'2026-10-05'),
(1004,3,'2026-10-10');

-- 9. Insert Order Items
INSERT INTO Order_Item VALUES
(1,1001,101,1),
(2,1001,102,2),
(3,1002,103,1),
(4,1003,104,2),
(5,1004,102,3);

-- 10. Insert Payment Details
INSERT INTO Payment VALUES
(501,1001,51000,'UPI','Successful'),
(502,1002,1000,'Card','Successful'),
(503,1004,1500,'Cash','Pending');

-- 11. INNER JOIN
SELECT Customer.customer_name,
Orders.order_id, Product.product_name,
Order_Item.quantity
FROM Customer
INNER JOIN Orders
ON Customer.customer_id=Orders.customer_id
INNER JOIN Order_Item
ON Orders.order_id=Order_Item.order_id
INNER JOIN Product
ON Order_Item.product_id=Product.product_id;

-- 12. LEFT JOIN
SELECT Customer.customer_name,
Orders.order_id
FROM Customer
LEFT JOIN Orders
ON Customer.customer_id=Orders.customer_id;

-- 13. RIGHT JOIN
SELECT Product.product_name,
Order_Item.order_id
FROM Order_Item
RIGHT JOIN Product
ON Order_Item.product_id=Product.product_id;

-- 14. Complete Order Details
SELECT Customer.customer_name,
Orders.order_id, Product.product_name,
Order_Item.quantity, Payment.amount,
Payment.payment_mode,
Payment.payment_status
FROM Customer
INNER JOIN Orders
ON Customer.customer_id=Orders.customer_id
INNER JOIN Order_Item
ON Orders.order_id=Order_Item.order_id
INNER JOIN Product
ON Order_Item.product_id=Product.product_id
LEFT JOIN Payment
ON Orders.order_id=Payment.order_id;

-- 15. Customer Purchase History
SELECT Customer.customer_name,
Orders.order_date, Product.product_name,
Order_Item.quantity
FROM Customer
INNER JOIN Orders
ON Customer.customer_id=Orders.customer_id
INNER JOIN Order_Item
ON Orders.order_id=Order_Item.order_id
INNER JOIN Product
ON Order_Item.product_id=Product.product_id;

-- 16. Customer Purchase Report
SELECT Customer.customer_name,
COUNT(Orders.order_id) AS Total_Orders
FROM Customer
LEFT JOIN Orders
ON Customer.customer_id=Orders.customer_id
GROUP BY Customer.customer_id,
Customer.customer_name;

-- 17. Product Sales Report
SELECT Product.product_name,
SUM(Order_Item.quantity) AS Total_Sold
FROM Product
LEFT JOIN Order_Item
ON Product.product_id=Order_Item.product_id
GROUP BY Product.product_id,
Product.product_name;

-- 18. Payment Report
SELECT Orders.order_id,
Customer.customer_name,
Payment.amount, Payment.payment_status
FROM Orders
INNER JOIN Customer
ON Orders.customer_id=Customer.customer_id
LEFT JOIN Payment
ON Orders.order_id=Payment.order_id;

-- 19. Display All Customers
SELECT * FROM Customer;

-- 20. Display All Products
SELECT * FROM Product;
