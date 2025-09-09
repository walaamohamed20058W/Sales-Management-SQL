CREATE DATABASE sales_db;
GO

USE sales_db;
GO



CREATE TABLE customers (
  customer_id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(100) NOT NULL,
  email NVARCHAR(150) UNIQUE NOT NULL,
  created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE products (
  product_id INT IDENTITY(1,1) PRIMARY KEY,
  name NVARCHAR(150) NOT NULL,
  category NVARCHAR(80),
  price DECIMAL(10,2) NOT NULL,
  stock INT DEFAULT 0
);


CREATE TABLE orders (
  order_id INT IDENTITY(1,1) PRIMARY KEY,
  customer_id INT FOREIGN KEY REFERENCES customers(customer_id),
  order_date DATETIME DEFAULT GETDATE(),
  total DECIMAL(12,2) DEFAULT 0,
  status NVARCHAR(20) DEFAULT 'pending'
);


CREATE TABLE order_items (
  item_id INT IDENTITY(1,1) PRIMARY KEY,
  order_id INT FOREIGN KEY REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id INT FOREIGN KEY REFERENCES products(product_id),
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL
);


INSERT INTO customers (name, email) VALUES
(N'Walaa Mohamed', 'walaa@example.com'),
(N'Ahmed Ali', 'ahmed@example.com'),
(N'Sara Hassan', 'sara@example.com');


INSERT INTO products (name, category, price, stock) VALUES
(N'Notebook', N'Stationery', 2.50, 200),
(N'Wireless Mouse', N'Electronics', 20.00, 50),
(N'USB Flash 32GB', N'Electronics', 10.00, 100),
(N'Pen', N'Stationery', 1.00, 500);




INSERT INTO orders (customer_id, total, status) VALUES (1, 45.00, N'completed');

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 2, 2, 20.00),  
(1, 4, 5, 1.00);   


SELECT TOP 5 p.name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_sold DESC;


SELECT FORMAT(order_date, 'yyyy-MM') AS month, SUM(total) AS revenue
FROM orders
WHERE status = N'completed'
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY month;

SELECT TOP 5 c.name, SUM(o.total) AS total_spent
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.status = N'completed'
GROUP BY c.name
ORDER BY total_spent DESC;


SELECT name, stock
FROM products
WHERE stock < 10;

