USE shopping_data;

--  count Total number of  orders

SELECT COUNT(*) AS Total_Orders,
       COUNT(DISTINCT customer_id) AS Unique_Customers,
       COUNT(DISTINCT status) AS Order_Statuses
FROM orders;


--  Total Revenue of delivered orders

SELECT COUNT(*) AS Delivered_Orders,
       SUM(total_amount) AS Total_Revenue,
       AVG(total_amount) AS Average_Order_Value,
       MIN(total_amount) AS Minimum_Order,
       MAX(total_amount) AS Maximum_Order
FROM orders
WHERE status = 'Delivered';


-- Average unit_price of each products grouped by category

SELECT category,
       COUNT(*) AS Product_Count,
       ROUND(AVG(unit_price), 2) AS Average_Price,
       MIN(unit_price) AS Cheapest,
       MAX(unit_price) AS Most_Expensive,
       SUM(stock_qty) AS Total_Stock
FROM products
GROUP BY category
ORDER BY Average_Price DESC;

--  Count total number of  Orders and total revenue  and sort  total revenue in descending order
SELECT status,
       COUNT(*) AS Order_Count,
       SUM(total_amount) AS Total_Revenue,
       ROUND(AVG(total_amount), 2) AS Average_Amount,
       ROUND(SUM(total_amount) * 100 / (SELECT SUM(total_amount) FROM orders), 2) AS Revenue_Percentage
FROM orders
GROUP BY status
ORDER BY Total_Revenue DESC, Order_Count DESC;


-- find the expensive and cheapest products in each category.
SELECT category,
       MAX(unit_price) AS Premium_Product_Price,
       (SELECT product_name FROM products p2 WHERE p2.category = p1.category ORDER BY p2.unit_price DESC LIMIT 1) AS Premium_Product_Name,
       MIN(unit_price) AS Budget_Product_Price,
       (SELECT product_name FROM products p2 WHERE p2.category = p1.category ORDER BY p2.unit_price ASC LIMIT 1) AS Budget_Product_Name,
       MAX(unit_price) - MIN(unit_price) AS Price_Range
FROM products p1
GROUP BY category
ORDER BY category;


--  Product Categories with average price > 2000
SELECT category,
       COUNT(*) AS Product_Count,
       ROUND(AVG(unit_price), 2) AS Average_Price,
       SUM(stock_qty) AS Total_Inventory_Units
FROM products
GROUP BY category
HAVING AVG(unit_price) > 2000
ORDER BY Average_Price DESC;