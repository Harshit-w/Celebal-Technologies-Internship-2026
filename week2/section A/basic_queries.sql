USE shopping_data;

-- display all columns and rows from the customer's table.

SELECT * FROM customers;

-- Retrieve name and location of all customers

SELECT first_name, last_name, city FROM customers;

-- unique product categories

SELECT DISTINCT category FROM products
ORDER BY category ASC;

-- Primary Keys in the table
--    UNIQUE: Each record needs a distinct identifier to avoid duplicates
--    NOT NULL: Every row must have a value; NULL cannot identify a record

SELECT 'customers' AS Table_Name, 'customer_id' AS Primary_Key
UNION ALL
SELECT 'products', 'product_id'
UNION ALL
SELECT 'orders', 'order_id'
UNION ALL
SELECT 'order_items', 'item_id';

-- prevent insertion of duplicate email in table
--    What happens if duplicate email inserted:
--       MySQL Error Code 1062: Duplicate entry for key 'email'
--       The database REJECTS the INSERT operation

SELECT email, COUNT(*) AS Email_Count FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


-- Check for products which have negative unit prices 

SELECT product_id, product_name, unit_price FROM products
WHERE unit_price <= 0;