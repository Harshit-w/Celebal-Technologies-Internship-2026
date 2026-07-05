-- step 1  LOAD DATA 

CREATE DATABASE superstore_db;
USE superstore_db;
 -- Table data  has been imported using " TABLE DATA IMPORT WIZARD "
 
 -- checking all 9994 rows has been imported successfully
SELECT COUNT(*) FROM superstore_raw;

-- create customers table 
CREATE TABLE customers (customer_id VARCHAR(20) PRIMARY KEY, customer_name VARCHAR(100), segment VARCHAR(30));

-- insert data in customers table 
INSERT INTO customers SELECT DISTINCT customer_id, customer_name, segment FROM superstore_raw;

-- create orders table 
CREATE TABLE orders (row_id INT PRIMARY KEY, order_id VARCHAR(30), order_date DATE, ship_date DATE,
	ship_mode VARCHAR(50), customer_id VARCHAR(20), product_id VARCHAR(30), country VARCHAR(50), city VARCHAR(50), state VARCHAR(50),
    postal_code INT, region VARCHAR(30), sales DECIMAL(10,2), quantity INT, discount DECIMAL(5,2), profit DECIMAL(10,4));
    
-- insert data in orders table 
INSERT INTO orders SELECT row_id, order_id, STR_TO_DATE(order_date,'%m/%d/%Y'), STR_TO_DATE(ship_date,'%m/%d/%Y'), 
ship_mode, customer_id, product_id, country, city, state, postal_code, region, sales, quantity, discount, profit FROM superstore_raw;

-- create products table 
CREATE TABLE products (product_id VARCHAR(30) PRIMARY KEY, product_name VARCHAR(255), category VARCHAR(50), sub_category VARCHAR(50));

-- insert data in products table 
INSERT INTO products SELECT product_id, MIN(product_name), MIN(category), MIN(sub_category) FROM superstore_raw GROUP BY product_id;


-- step 2  PERFORM REQUIRED QUERIES 

-- orders where sales are greater than average sales
SELECT * FROM orders WHERE sales > (SELECT AVG(sales) FROM orders);

-- Highest sales order for each customer
SELECT * FROM orders o WHERE sales = (SELECT MAX(sales) FROM orders WHERE customer_id = o.customer_id);

-- Total sales for each customer 
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) SELECT * FROM CustomerSales;

-- Customer Woods total sales are above average 
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) 
SELECT * FROM CustomerSales WHERE total_sales > (SELECT AVG(total_sales) FROM CustomerSales);

-- Ranking customers based on total sales 
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) 
SELECT customer_id, total_sales, RANK() OVER(ORDER BY total_sales DESC) AS customer_rank FROM CustomerSales;

-- Assign row numbers to each order within a customer 
SELECT customer_id, order_id, sales, ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS row_num FROM orders;

-- Top 3 customers based on total sales 
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) 
SELECT * FROM (SELECT customer_id, total_sales, RANK() OVER(ORDER BY total_sales DESC) AS customer_rank FROM CustomerSales) AS RankedCustomers WHERE customer_rank <= 3;


-- step 3 FINAL COMBINED QUERY 

-- Query that Customer name total sales and rank Using JOIN , CTE and window function
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) 
SELECT c.customer_name, cs.total_sales, RANK() OVER (ORDER BY cs.total_sales DESC) AS customer_rank FROM CustomerSales cs JOIN customers c ON cs.customer_id = c.customer_id 
ORDER BY customer_rank;


-- MINI PROJECT: CUSTOMER SALES INSIGHTS

-- Top 5 customers 
SELECT c.customer_name, SUM(o.sales) AS total_sales FROM orders o JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_id, c.customer_name ORDER BY total_sales DESC LIMIT 5;

-- Bottom 5 customers 
SELECT c.customer_name, SUM(o.sales) AS total_sales FROM orders o JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_id, c.customer_name ORDER BY total_sales ASC LIMIT 5;

-- Customers who made only one order 
SELECT c.customer_name, COUNT(DISTINCT o.order_id) AS total_orders FROM orders o JOIN customers c ON o.customer_id = c.customer_id GROUP BY c.customer_id, c.customer_name 
HAVING COUNT(DISTINCT o.order_id) = 1;

-- Customers have above average sales 
WITH CustomerSales AS (SELECT customer_id, SUM(sales) AS total_sales FROM orders GROUP BY customer_id) 
SELECT c.customer_name, cs.total_sales FROM CustomerSales cs JOIN customers c ON cs.customer_id = c.customer_id WHERE cs.total_sales > (SELECT AVG(total_sales) FROM CustomerSales) 
ORDER BY cs.total_sales DESC;

-- Highest order value per customer 
SELECT c.customer_name, MAX(o.sales) AS highest_order_value FROM orders o JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_id, c.customer_name ORDER BY highest_order_value DESC;

