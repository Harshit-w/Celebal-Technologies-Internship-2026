-- ============================================================================
-- CELEBAL SUMMER INTERNSHIP 2026 - WEEK 2 SQL TASK
-- Database: E-Commerce Sales Database (ShopEase)
-- ============================================================================

-- Create the database
CREATE DATABASE IF NOT EXISTS shopease_db;
USE shopease_db;

-- ============================================================================
-- TABLE 1: CUSTOMERS
-- ============================================================================
-- Stores customer information for ShopEase e-commerce platform
-- Primary Key: customer_id (unique identifier for each customer)
-- Constraints: Email must be unique, names are mandatory

CREATE TABLE IF NOT EXISTS customers (
    customer_id   INT           PRIMARY KEY,
    first_name    VARCHAR(50)   NOT NULL,
    last_name     VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  UNIQUE NOT NULL,
    city          VARCHAR(50)   NOT NULL,
    state         VARCHAR(50)   NOT NULL,
    join_date     DATE          NOT NULL,
    is_premium    BOOLEAN       DEFAULT FALSE
);

-- Create indexes for frequently filtered columns
CREATE INDEX idx_customers_city ON customers(city);
CREATE INDEX idx_customers_state ON customers(state);

-- ============================================================================
-- TABLE 2: PRODUCTS
-- ============================================================================
-- Stores product catalog information
-- Primary Key: product_id (unique identifier for each product)
-- Constraints: Price must be positive, stock cannot be negative

CREATE TABLE IF NOT EXISTS products (
    product_id    INT           PRIMARY KEY,
    product_name  VARCHAR(100)  NOT NULL,
    category      VARCHAR(50)   NOT NULL,
    brand         VARCHAR(50)   NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0),
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0)
);

-- Create index for category-based filtering
CREATE INDEX idx_products_category ON products(category);

-- ============================================================================
-- TABLE 3: ORDERS
-- ============================================================================
-- Stores order transaction records
-- Primary Key: order_id (unique identifier for each order)
-- Foreign Key: customer_id references customers table
-- Constraints: Status restricted to specific values, total_amount must be non-negative

CREATE TABLE IF NOT EXISTS orders (
    order_id      INT           PRIMARY KEY,
    customer_id   INT           NOT NULL,
    order_date    DATE          NOT NULL,
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending'
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0),
    
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create indexes for performance optimization
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_orders_status ON orders(status);

-- ============================================================================
-- TABLE 4: ORDER_ITEMS
-- ============================================================================
-- Stores individual line items within each order
-- Primary Key: item_id (unique identifier for each order item)
-- Foreign Keys: order_id and product_id reference respective tables
-- Constraints: Quantity must be positive, discount between 0-100%

CREATE TABLE IF NOT EXISTS order_items (
    item_id       INT           PRIMARY KEY,
    order_id      INT           NOT NULL,
    product_id    INT           NOT NULL,
    quantity      INT           NOT NULL  CHECK (quantity > 0),
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0),
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100),
    
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================================
-- ENTITY RELATIONSHIP DIAGRAM
-- ============================================================================
-- customers  ──(1:N)──▶  orders
-- orders     ──(1:N)──▶  order_items
-- products   ──(1:N)──▶  order_items
--
-- customers.customer_id  ◀──FK──  orders.customer_id
-- orders.order_id        ◀──FK──  order_items.order_id
-- products.product_id    ◀──FK──  order_items.product_id
-- ============================================================================

COMMIT;
