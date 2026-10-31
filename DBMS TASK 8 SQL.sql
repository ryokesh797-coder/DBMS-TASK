CREATE database joins;
USE joins;
CREATE TABLE Customer (customer_id INT PRIMARY KEY,customer_name VARCHAR(50));
CREATE TABLE Product (product_id INT PRIMARY KEY,product_name VARCHAR(50),price DECIMAL(10,2));
CREATE TABLE Orders (order_id INT PRIMARY KEY,customer_id INT,product_id INT,quantity INT,
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),FOREIGN KEY (product_id) REFERENCES Product(product_id));
CREATE TABLE Payment (payment_id INT PRIMARY KEY,order_id INT,amount DECIMAL(10,2),payment_status VARCHAR(20),FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
INSERT INTO Customer VALUES(1, 'Ravi'), (2, 'Priya');
INSERT INTO Product VALUES(101, 'Laptop', 50000),(102, 'Mouse', 500);
INSERT INTO Orders VALUES(1, 1, 101, 1),(2, 2, 102, 2);
INSERT INTO Payment VALUES(1, 1, 50000, 'Paid'),(2, 2, 1000, 'Paid');
SELECT C.customer_name, P.product_name,
       O.quantity, Pay.amount, Pay.payment_status
FROM Customer C
INNER JOIN Orders O ON C.customer_id = O.customer_id
INNER JOIN Product P ON O.product_id = P.product_id
INNER JOIN Payment Pay ON O.order_id = Pay.order_id;
SELECT C.customer_name, O.order_id
FROM Customer C
LEFT JOIN Orders O
ON C.customer_id = O.customer_id;
SELECT C.customer_name, O.order_id
FROM Customer C
RIGHT JOIN Orders O
ON C.customer_id = O.customer_id;
SELECT C.customer_name, O.order_id,
       P.product_name, P.price,
       O.quantity, Pay.amount, Pay.payment_status
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Product P ON O.product_id = P.product_id
LEFT JOIN Payment Pay ON O.order_id = Pay.order_id;
SELECT C.customer_name, P.product_name,
       O.quantity, P.price
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Product P ON O.product_id = P.product_id
ORDER BY C.customer_name;
SELECT C.customer_name, O.order_id,
       P.product_name,
       (P.price * O.quantity) AS total_price,
       Pay.payment_status
FROM Customer C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Product P ON O.product_id = P.product_id
LEFT JOIN Payment Pay ON O.order_id = Pay.order_id;