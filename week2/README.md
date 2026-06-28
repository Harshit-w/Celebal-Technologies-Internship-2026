## Project Overview

This SQL assignment focuses on building and querying an e-commerce database called **ShopEase**. The project contains a complete relational database schema with four interconnected tables (Customers, Products, Orders, Order Items) and 27 comprehensive SQL questions organized into 5 sections.

---

## Folder Structure

```
sql-assignment/
├── create_database.sql
│
├── Section_A/
│   └── basic_queries.sql              
│
├── Section_B/
│   └── filtering_queries.sql           
│
├── Section_C/
│   └── aggregation_queries.sql         
│
├── Section_D/
│   └── joins_queries.sql               
│
├── Section_E/
│   └── advanced_queries.sql            
│
└── README.md                           
```

---

##  Database Schema

### Tables and Relationships

```
customers
├─ customer_id (PK)
├─ first_name
├─ last_name
├─ email (UNIQUE)
├─ city (INDEX)
├─ state (INDEX)
├─ join_date
└─ is_premium

    ↓ 1:N ↓

orders
├─ order_id (PK)
├─ customer_id (FK → customers)
├─ order_date (INDEX)
├─ status (INDEX) [CHECK: Pending|Shipped|Delivered|Cancelled]
└─ total_amount

    ↓ 1:N ↓

order_items
├─ item_id (PK)
├─ order_id (FK → orders)
├─ product_id (FK → products)
├─ quantity (CHECK: > 0)
├─ unit_price (CHECK: > 0)
└─ discount_pct (CHECK: 0-100%)

products
├─ product_id (PK)
├─ product_name
├─ category (INDEX)
├─ brand
├─ unit_price (CHECK: > 0)
└─ stock_qty (CHECK: >= 0)
```

---

## Quick Start Guide

### Step 1: Create Database and Tables

```bash
# Using MySQL/PostgreSQL Command Line
mysql -u your_username -p < Setup/01_create_database.sql
```

### Execute Query Sections

```bash
# Section A: Basics
mysql -u your_username -p shopease_db < Section_A/basic_queries.sql

# Section B: Filtering
mysql -u your_username -p shopease_db < Section_B/filtering_queries.sql

# Section C: Aggregation
mysql -u your_username -p shopease_db < Section_C/aggregation_queries.sql

# Section D: Joins
mysql -u your_username -p shopease_db < Section_D/joins_queries.sql

# Section E: Advanced
mysql -u your_username -p shopease_db < Section_E/advanced_queries.sql
```

---

##  Section Breakdown

### Section A: SQL Basics 
**Topics**: SELECT, table structure, constraints, primary keys, unique constraints, CHECK constraints

**Files**: `Section_A/basic_queries.sql`

**Learning Outcomes**:
- Master basic SELECT queries
- Understand UNIQUE and NOT NULL constraints
- Learn CHECK constraints for data validation
- Recognize importance of primary keys

**Sample Questions**:
- Q1: Display all customers
- Q3: List unique product categories
- Q6: Test CHECK constraint on unit_price

---

### Section B: Filtering & Optimization 
**Topics**: WHERE clause, indexes, SARGABLE queries, query optimization

**Files**: `Section_B/filtering_queries.sql`

**Learning Outcomes**:
- Write effective WHERE conditions
- Understand database indexes and performance
- Learn SARGABLE queries (index-friendly)
- Optimize date-based filtering

**Sample Questions**:
- Q7: Filter orders by status
- Q11: Explain index benefits
- Q12: Rewrite non-SARGABLE query

---

### Section C: Aggregation 
**Topics**: GROUP BY, COUNT, SUM, AVG, MIN, MAX, HAVING

**Files**: `Section_C/aggregation_queries.sql`

**Learning Outcomes**:
- Summarize data with aggregate functions
- Group data and apply conditions with HAVING
- Calculate business metrics (revenue, averages)
- Create meaningful summaries

**Sample Questions**:
- Q13: Count total orders
- Q15: Average price by category
- Q18: Use HAVING clause for filtering groups

---

### Section D: Joins & Relationships 
**Topics**: INNER JOIN, LEFT JOIN, Foreign Keys, referential integrity

**Files**: `Section_D/joins_queries.sql`

**Learning Outcomes**:
- Combine data from multiple tables
- Understand relationship types
- Master INNER and LEFT JOINs
- Learn Foreign Key constraints

**Sample Questions**:
- Q19: INNER JOIN orders with customers
- Q20: LEFT JOIN all customers with orders
- Q23: Explain Foreign Key relationships

---

### Section E: Advanced Concepts
**Topics**: CASE statements, ACID properties, transactions, data integrity

**Files**: `Section_E/advanced_queries.sql`

**Learning Outcomes**:
- Use CASE for conditional logic
- Understand ACID properties (Atomicity, Consistency, Isolation, Durability)
- Write atomic transactions
- Implement rollback/commit strategies

**Sample Questions**:
- Q24: CASE for product price tiers
- Q26: Explain ACID with real-world examples
- Q27: Write complete transaction with rollback handling

---

## Key Concepts Covered

### Database Constraints
- ✅ PRIMARY KEY: Unique identifier for each record
- ✅ FOREIGN KEY: Reference to other table (referential integrity)
- ✅ UNIQUE: No duplicate values allowed
- ✅ NOT NULL: Value must be provided
- ✅ CHECK: Value must meet condition
- ✅ DEFAULT: Default value if not specified

### Query Types
- ✅ SELECT: Retrieve data
- ✅ WHERE: Filter rows before grouping
- ✅ GROUP BY: Aggregate data by category
- ✅ HAVING: Filter groups after aggregation
- ✅ ORDER BY: Sort results
- ✅ LIMIT/OFFSET: Pagination

### Join Types
- ✅ INNER JOIN: Only matching records
- ✅ LEFT JOIN: All left table + matching right
- ✅ RIGHT JOIN: All right table + matching left
- ✅ FULL OUTER JOIN: All records from both tables
- ✅ CROSS JOIN: Cartesian product

### Aggregate Functions
- ✅ COUNT(): Number of records
- ✅ SUM(): Total sum
- ✅ AVG(): Average value
- ✅ MIN(): Minimum value
- ✅ MAX(): Maximum value

### Advanced Features
- ✅ CASE: Conditional logic (IF/ELSE)
- ✅ Indexes: Performance optimization
- ✅ Transactions: ACID compliance
- ✅ COMMIT/ROLLBACK: Data integrity

---

##  Best Practices Demonstrated

### 1. Code Organization
- ✅ Queries grouped by concept (Sections A-E)
- ✅ Clear comments explaining each query
- ✅ Meaningful query aliases for readability
- ✅ Consistent indentation and formatting

### 2. Performance Optimization
- ✅ Indexes created for frequently filtered columns
- ✅ SARGABLE queries that utilize indexes
- ✅ Efficient JOIN conditions
- ✅ Aggregate functions grouped appropriately

### 3. Data Integrity
- ✅ Foreign key constraints enforce relationships
- ✅ CHECK constraints validate data
- ✅ Transactions ensure atomic operations
- ✅ UNIQUE constraints prevent duplicates

### 4. Documentation
- ✅ Purpose statement for each query
- ✅ Business context explanation
- ✅ Expected output description
- ✅ Inline comments for complex logic

---

##  Sample Data Overview

### Customers (8 records)
- Geographic distribution across India
- Mix of premium and regular members
- Join dates spanning January to August 2024

### Products (8 records)
- 3 categories: Electronics (4), Clothing (2), Home (2)
- Price range: ₹599 to ₹4599
- Brand diversity: BoAt, Levi's, Noise, Nike, JBL, Spaces, AmazonBasics, HomeCenter

### Orders (10 records)
- 4 statuses: Delivered (6), Shipped (2), Pending (1), Cancelled (1)
- Date range: August 1-28, 2024
- Order values: ₹799 to ₹7498

### Order Items (15 records)
- Multiple items per order (1-2 items)
- Discount percentages: 0%, 5%, 10%, 15%
- Real business transactions

---

##  Environment Requirements

### Minimum Requirements
- **Database**: MySQL 5.7+ OR PostgreSQL 10+ OR SQLite 3.30+
- **Client**: MySQL Workbench, pgAdmin, DBeaver, or command line
- **Storage**: ~10 MB (minimal)
- **Time**: ~2 hours to complete all sections

### Recommended Setup
- **MySQL 8.0+** (Best features and performance)
- **MySQL Workbench** (Visual query builder)
- **Windows/Mac/Linux** (Cross-platform support)

---

##  Expected Results

When you complete all sections, you'll have:

✅ 8 customer records with full details  
✅ 8 product records across 3 categories  
✅ 10 order records with different statuses  
✅ 15 order item records with discount info  
✅ 27 working queries demonstrating SQL concepts  
✅ Complete understanding of database relationships  

---
