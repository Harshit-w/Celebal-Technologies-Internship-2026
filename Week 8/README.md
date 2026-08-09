# E-Commerce Analytics System

## Overview

This project is an end-to-end e-commerce analytics system built using
Python, SQL, SQLite, and Databricks.

The project covers:

-   Synthetic e-commerce data generation
-   Data cleaning and preparation
-   SQLite database creation and loading
-   SQL-based analytics
-   Aggregation and window-function analysis
-   Cohort analysis
-   Python + SQL integration
-   Edge-case testing
-   Sample report generation

------------------------------------------------------------------------

## Project Structure

``` text
WEEK 8/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers_clean.csv
│       ├── products_clean.csv
│       ├── orders_clean.csv
│       └── order_items_clean.csv
│
├── scripts/
│   ├── WEEK _8_ASSIGNMENT NOTEBOOK(generate.py + clean.py)
│   └── report_cli.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
└── README.md
```

------------------------------------------------------------------------

## Data

The project uses four main datasets:

### 1. Customers

Contains customer information such as:

-   `customer_id`
-   `customer_name`
-   `email`
-   `registration_date`
-   `customer_type`

### 2. Products

Contains product information such as:

-   `product_id`
-   `product_name`
-   `category`
-   `subcategory`
-   `cost_price`

### 3. Orders

Contains order-level information:

-   `order_id`
-   `customer_id`
-   `order_date`
-   `status`
-   `region_code`

The generated order data includes missing customer IDs and some
intentionally inconsistent date formats for cleaning and validation
exercises.

### 4. Order Items

Contains item-level order information:

-   `item_id`
-   `order_id`
-   `product_id`
-   `quantity`
-   `unit_price`
-   `discount_percent`

------------------------------------------------------------------------

## Data Cleaning

The cleaned datasets are stored in:

``` text
data/cleaned/
```

The four cleaned files are:

``` text
customers_clean.csv
products_clean.csv
orders_clean.csv
order_items_clean.csv
```

The cleaning stage prepares the raw data for database loading and
analysis.

------------------------------------------------------------------------

## SQL Analysis

The SQL analysis is organized into four scripts.

### `schema.sql`

Creates the SQLite database tables and their relationships.

### `aggregations.sql`

Contains aggregation-based analysis such as:

-   Total order value
-   Customer-level analysis
-   Product-level analysis
-   Monthly analysis
-   Revenue calculations
-   Other aggregate business metrics

### `window_functions.sql`

Contains window-function analysis including:

-   `LAG()`
-   `LEAD()`
-   Ranking
-   Running/partition-based calculations
-   Customer order-gap analysis

### `cohort_analysis.sql`

Contains customer cohort analysis based on customer activity and order
months.

------------------------------------------------------------------------

## SQLite Database

The project uses SQLite for the Python + SQL integration part.

The database file is:

``` text
ecommerce.db
```

The cleaned CSV files are loaded into the following tables:

``` text
customers
products
orders
order_items
```

SQLite is accessed from Python using the built-in `sqlite3` module.

No external Python libraries are required for the SQLite integration
apart from `sqlite3`.

------------------------------------------------------------------------

## Python + SQL Integration

The command-line report tool is located at:

``` text
scripts/report_cli.py
```

The tool:

1.  Takes a report type:

    -   Daily
    -   Weekly
    -   Monthly

2.  Takes a start date and end date.

3.  Connects to the SQLite database.

4.  Generates a summary containing:

    -   Total orders
    -   Total revenue
    -   Unique customers
    -   Top 3 products
    -   Comparison with the previous period
    -   Percentage change

### Running the report tool

From the project root:

``` bash
python scripts/report_cli.py
```

Example input:

``` text
Enter report type (daily/weekly/monthly): monthly
Enter start date (YYYY-MM-DD): 2026-01-01
Enter end date (YYYY-MM-DD): 2026-01-31
```

The generated report is displayed in the terminal.

------------------------------------------------------------------------

## Revenue Calculation

Revenue is calculated using:

``` text
quantity × unit_price × (1 - discount_percent / 100)
```

This calculation is used for the order and product revenue analysis.

------------------------------------------------------------------------

## Edge Case Testing

The project includes tests for the edge cases specified in the
assignment:

### 1. Invalid order ID

Checks what happens when an `order_items` record contains an `order_id`
that does not exist in `orders`.

### 2. Discount greater than 100%

Checks for records where:

``` text
discount_percent > 100
```

### 3. Quantity equal to zero

Checks for records where:

``` text
quantity = 0
```

### 4. Future order date

Checks whether any order has an `order_date` later than the current
date.

These tests are implemented as Python test functions.

------------------------------------------------------------------------

## Sample Reports

Example report output is stored under:

``` text
output/sample_reports/
```

The sample report demonstrates the output generated by the Python +
SQLite reporting tool.

------------------------------------------------------------------------

## Technologies Used

-   Python
-   SQL
-   SQLite
-   Databricks
-   CSV
-   GitHub

Python's built-in `sqlite3` module is used for SQLite database
connectivity.

------------------------------------------------------------------------

## How to Run the Project

### Step 1: Generate the data

Run:

``` bash
python scripts/generate_data.py
```

This generates the raw CSV files under:

``` text
data/raw/
```

### Step 2: Clean the data

Run:

``` bash
python scripts/clean_data.py
```

The cleaned CSV files are written to:

``` text
data/cleaned/
```

### Step 3: Create and load the SQLite database

Create the database schema using:

``` text
sql/schema.sql
```

Then load the cleaned CSV files into SQLite.

The resulting database is:

``` text
ecommerce.db
```

### Step 4: Run SQL analysis

The SQL analysis scripts are located in:

``` text
sql/
```

Run the required scripts in a SQLite-compatible environment.

### Step 5: Run the CLI report

Run:

``` bash
python scripts/report_cli.py
```

Enter the requested report type and date range.

------------------------------------------------------------------------

## Output

The system produces:

-   Cleaned datasets
-   SQLite database
-   SQL analysis results
-   Customer/product/order analytics
-   Cohort analysis
-   CLI summary reports
-   Edge-case validation results

------------------------------------------------------------------------

## Submission

The project is organized according to the required GitHub submission
structure, with separate folders for:

-   Raw and cleaned data
-   Python scripts
-   SQL scripts
-   Sample reports