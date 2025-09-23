# Sales Management System (SQL Server)

## 📌 Project Overview
This project is a simple **Sales Management System** implemented using **SQL Server**.
It includes tables for **Customers, Products, Orders, and Order Items**, along with relationships and queries.

---

## 📂 Project Files
- `Sales_ERD.png` → ERD diagram of the database.  
- `Sales_Project.docx` → Report (Prepared by Walaa Mohamed).  

---

## 🚀 Example Query
```sql
-- Find the top 5 products by sales
SELECT TOP 5 p.name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;
