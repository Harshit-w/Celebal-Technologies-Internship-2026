USE shopping_data;

-- Classify products into price tiers

SELECT product_id, product_name, category, unit_price,
       CASE WHEN unit_price < 1000 THEN 'Budget'
            WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
            WHEN unit_price > 3000 THEN 'Premium'
            ELSE 'Unclassified' END AS Price_Tier
FROM products
ORDER BY unit_price DESC;


-- Count how many orders are 'Delivered' vs 'Not Delivered'

SELECT COUNT(*) AS Total_Orders,
       SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS Delivered_Count,
    SUM(CASE WHEN status != 'Delivered' THEN 1 ELSE 0 END) AS Not_Delivered_Count
FROM orders;

-- other status 

SELECT COUNT(*) AS Total_Orders,
       SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) AS Delivered,
       SUM(CASE WHEN status = 'Shipped' THEN 1 ELSE 0 END) AS Shipped,
       SUM(CASE WHEN status = 'Pending' THEN 1 ELSE 0 END) AS Pending,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS Cancelled
FROM orders;

-- ACID — full explanation
-- A — ATOMICITY
--   • Definition: A transaction is an indivisible unit: either ALL operations
--     succeed (COMMIT) or NONE do (ROLLBACK).
--   • Why it matters: Prevents partial updates that would leave data inconsistent
--     (e.g., money debited but not credited).
--   • DB mechanisms: Transaction logs, write-ahead logging (WAL), and rollback
--     ensure changes are undone on failure.

-- C — CONSISTENCY
--   • Definition: Transactions move the database from one valid state to another
--     while preserving constraints, triggers, and business rules.
--   • Why it matters: Ensures data integrity (FKs, CHECKs, UNIQUE, NOT NULL).
--   • DB mechanisms: Constraint enforcement and transactional checks ensure only
--     valid states are committed.

-- I — ISOLATION
--   • Definition: Concurrent transactions behave as if executed serially; one
--     transaction's intermediate results are not visible to others.
--   • Common anomalies prevented by stronger isolation: dirty reads,
--     non-repeatable reads, phantom reads.
--   • Isolation levels: READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ,
--     SERIALIZABLE (increasing strictness). MySQL default: REPEATABLE READ.

-- D — DURABILITY
--   • Definition: Once a transaction is committed, its effects persist even after
--     crashes, power loss, or restarts.
--   • Why it matters: Guarantees permanence of critical operations (orders,
--     payments) so business state isn't lost.
--   • DB mechanisms: Crash recovery, transaction logs, fsync to durable storage.

-- Example (bank transfer demonstrating all four):
--   1) BEGIN TRANSACTION
--   2) Debit A (balance -= amount)
--   3) Credit B (balance += amount)
--   4) If both succeed → COMMIT (durability); if any fails → ROLLBACK (atomicity)
--   5) Consistency enforced by constraints (balances non-negative). Isolation
--      prevents concurrent transfers from over-deducting the same balance.

-- Summary: ACID ensures correctness (Atomicity/Consistency), isolation from
-- concurrency effects (Isolation), and permanence (Durability) for reliable
-- transactional systems.

BEGIN TRANSACTION;

-- Insert  a new order order_id 1011 for customer_id 102.
INSERT INTO orders (order_id, customer_id, order_date, status, total_amount)
VALUES (1011, 102, CURDATE(), 'Pending', 1598.00);

-- Insert two order items 
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES (5016, 1011, 206, 1, 1299.00, 0);
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price, discount_pct)
VALUES (5017, 1011, 208, 1, 599.00, 15);

-- Update stock for  purchased products.
UPDATE products SET stock_qty = stock_qty - 1 WHERE product_id = 206;
UPDATE products SET stock_qty = stock_qty - 1 WHERE product_id = 208;