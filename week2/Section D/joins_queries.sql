USE shopping_data;

-- Query to display each order along with the customer's first_name and last_name using INNER JOIN

SELECT o.order_id, o.order_date, c.first_name, c.last_name, c.city, o.status, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;


-- All customers with their orders using LEFT JOIN

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, c.state, c.is_premium, c.join_date,
       o.order_id, o.order_date, o.status, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


--Order details (orders → order_items → products)

SELECT o.order_id, o.order_date, oi.item_id, p.product_name, p.category, p.brand,
       oi.quantity, oi.unit_price, oi.discount_pct,
       ROUND(oi.quantity * oi.unit_price, 2) AS Line_Total_Before_Discount,
       ROUND(oi.quantity * oi.unit_price * (100 - oi.discount_pct) / 100, 2) AS Line_Total_After_Discount
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, oi.item_id;


-- LEFT JOIN to find customers without orders

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, o.order_id, o.order_date, o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- RIGHT JOIN to find orders without customers

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, o.order_id, o.order_date, o.status
FROM orders o
RIGHT JOIN customers c ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- FULL OUTER JOIN to find all customers and all orders Using UNION of LEFT JOIN and RIGHT JOIN

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, o.order_id, o.order_date, o.status, 'Active Customer' AS Join_Type
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
UNION
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, o.order_id, o.order_date, o.status, 'All Orders' AS Join_Type
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY customer_id, order_date;


-- Show all Foreign Key relationships
SELECT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'shopping_data' AND REFERENCED_TABLE_NAME IS NOT NULL;

-- What happens if you try to insert invalid FK (customer_id = 999 doesn't exist)
-- Uncomment to test:
-- INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
-- VALUES (9999, 999, '2024-09-01', 'Pending', 5000.00);
-- ERROR 1452: Cannot add or update a child row: foreign key constraint fails
-- Database protects data integrity by rejecting orphaned records