USE shopping_data;

--  retrieve Delivered orders

SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
WHERE status = 'Delivered'
ORDER BY order_date DESC;


-- Electronic products with unit price > 2000

SELECT product_id, product_name, category, brand, unit_price, stock_qty
FROM products
WHERE category = 'Electronics' AND unit_price > 2000
ORDER BY unit_price DESC;


-- Customers from Maharashtra who joined in the 2024

SELECT customer_id, first_name, last_name, state, join_date, is_premium
FROM customers
WHERE state = 'Maharashtra' AND YEAR(join_date) = 2024
ORDER BY join_date ASC;


-- Orders placed between 2024-08-10 and 2024-08-25, excluding Cancelled orders

SELECT order_id, customer_id, order_date, status, total_amount
FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
  AND status != 'Cancelled'
ORDER BY order_date ASC;


-- Examples using idx_orders_date (date-based queries)
SELECT order_id, order_date, status, total_amount
FROM orders
WHERE order_date >= '2024-08-01' AND order_date <= '2024-08-31'
ORDER BY order_date;

SELECT order_id, customer_id, order_date, total_amount
FROM orders
WHERE order_date > '2024-08-15'
ORDER BY order_date DESC;

SELECT order_id, order_date, total_amount
FROM orders
ORDER BY order_date;


-- Non-SARGABLE (avoids index):

SELECT customer_id, first_name, last_name, join_date
FROM customers
WHERE YEAR(join_date) = 2024;

-- SARGABLE (index-friendly):

SELECT customer_id, first_name, last_name, join_date
FROM customers
WHERE join_date >= '2024-01-01' AND join_date < '2025-01-01'
ORDER BY join_date;
