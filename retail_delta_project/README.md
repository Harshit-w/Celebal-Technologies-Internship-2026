# Retail Delta Engineering Project

A complete retail data engineering pipeline built with **Databricks, PySpark, Delta Lake, and Unity Catalog**. The project implements a layered **Bronze → Silver → Gold** architecture with batch ingestion, incremental/CDC processing, data quality handling, SCD Type 2 dimensions, point-in-time joins, Gold analytics, and Delta Lake feature demonstrations.

## Project Objective

Build a production-style retail data pipeline that:

- Ingests historical batch data and incremental/CDC data into Bronze.
- Cleans, casts, validates, deduplicates, and quarantines bad records in Silver.
- Maintains customer and product history using SCD Type 2.
- Resolves historical dimension versions using point-in-time joins.
- Produces a conformed Gold fact table and dashboard-ready analytics tables.
- Demonstrates Delta Lake Table History, Time Travel, and Schema Evolution.

The assignment guide specifies the `retail_demo` catalog with `raw`, `silver`, and `gold` schemas and requires the Bronze, Silver, and Gold deliverables used in this project.

## Architecture

```text
                ┌──────────────────────┐
                │   Batch CSV Data     │
                └──────────┬───────────┘
                           │
                ┌──────────▼───────────┐
                │ Incremental / CDC    │
                │       CSV Data       │
                └──────────┬───────────┘
                           │
                     BRONZE / RAW
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
     Customers          Products           Orders
        │                  │                  │
        └──────────────────┼──────────────────┘
                           ▼
                    SILVER STAGE 1
              Cleaning / Casting / Validation
                 Deduplication / Quarantine
                           │
                           ▼
                    SILVER STAGE 2
             Customer SCD2 / Product SCD2
                    Store Dimension
                           │
                 Point-in-Time Joins
                           │
                           ▼
                         GOLD
                           │
           ┌───────────────┼────────────────┐
           ▼               ▼                ▼
      fact_orders    Daily Sales      Category Sales
           │
           ├───────────────────────────────┐
           ▼                               ▼
      Segment Sales                   Region Sales
```

## Technology Stack

- **Databricks**
- **PySpark**
- **Delta Lake**
- **Unity Catalog**
- **Python**
- **Git / GitHub**

## Repository Structure

```text
retail-delta-engineering-project/
│
├── README.md
│
├── notebooks/
│   ├── 00_setup.ipynb
│   ├── 01_bronze_batch.ipynb
│   ├── 02_bronze_incremental.ipynb
│   ├── 03_silver_stage1_cleaning.ipynb
│   ├── 04_silver_stage2_scd2.ipynb
│   ├── 05_gold_layer.ipynb
│   └── 06_final_validation.ipynb
│
├── documentation/
│   └── Retail_Delta_Project_Final_Deliverables.pdf
│
└── datasets/
    ├── batch/
    └── incremental/
```

## Databricks Catalog Structure

All project tables are stored under the `retail_demo` catalog and organized by layer:

```text
retail_demo
├── raw
├── silver
└── gold
```

### Bronze / Raw

The implemented Bronze tables are:

```text
retail_demo.raw.customers_bronze
retail_demo.raw.orders_bronze
retail_demo.raw.products_bronze
retail_demo.raw.stores_bronze
retail_demo.raw.bronze_customers_incremental
retail_demo.raw.bronze_orders_incremental
retail_demo.raw.bronze_products_incremental
```

Bronze preserves source data and includes ingestion/audit information. Historical batch data and incremental/CDC feeds are maintained separately.

### Silver

```text
retail_demo.silver.silver1_customers_clean
retail_demo.silver.silver1_products_clean
retail_demo.silver.silver1_orders_clean
retail_demo.silver.silver1_stores_clean
retail_demo.silver.quarantine_orders
retail_demo.silver.dim_customer_scd2
retail_demo.silver.dim_product_scd2
retail_demo.silver.dim_store
```

### Gold

```text
retail_demo.gold.fact_orders
retail_demo.gold.gold_daily_sales
retail_demo.gold.gold_category_sales
retail_demo.gold.gold_segment_sales
retail_demo.gold.gold_region_sales
```

## Bronze Layer

The Bronze layer acts as the raw landing and historical archive. It ingests both batch and incremental/CDC files while retaining the source information required for traceability.

### Bronze validation results

| Table | Rows |
|---|---:|
| customers_bronze | 2,560 |
| orders_bronze | 12,180 |
| products_bronze | 830 |
| stores_bronze | 80 |
| bronze_customers_incremental | 630 |
| bronze_orders_incremental | 6,135 |
| bronze_products_incremental | 180 |

## Silver Stage 1

Silver Stage 1 performs data cleaning, type casting, business validation, deduplication, and bad-record quarantine.

### Validation results

| Table | Rows |
|---|---:|
| silver1_customers_clean | 577 |
| silver1_products_clean | 166 |
| silver1_orders_clean | 5,716 |
| silver1_stores_clean | 75 |
| quarantine_orders | 284 |

## SCD Type 2 Dimensions

### Customer SCD2

The customer dimension preserves historical versions of changed customer records.

| Metric | Result |
|---|---:|
| Total rows | 3,067 |
| Distinct customers | 2,719 |
| Current rows | 2,719 |
| Historical rows | 348 |
| Null surrogate keys | 0 |
| Duplicate surrogate keys | 0 |
| Invalid date ranges | 0 |

### Product SCD2

| Metric | Result |
|---|---:|
| Total rows | 980 |
| Distinct products | 800 |
| Current rows | 800 |
| Historical rows | 180 |
| Null surrogate keys | 0 |
| Duplicate surrogate keys | 0 |
| Invalid date ranges | 0 |

### Store Dimension

| Metric | Result |
|---|---:|
| Total rows | 75 |
| Distinct stores | 75 |
| Null store IDs | 0 |
| Duplicate store IDs | 0 |

## Gold Layer

The Gold layer contains the conformed fact and analytics outputs.

### `fact_orders`

| Metric | Result |
|---|---:|
| Fact rows | 5,716 |
| Distinct orders | 5,716 |
| Duplicate order IDs | 0 |
| Total units | 19,864 |
| Total revenue | 803,347,391.80 |
| Null product_sk | 0 |
| Null store IDs | 0 |
| Null quantity | 0 |
| Null gross_amount | 0 |

### Gold analytics

| Table | Rows / Groups | Orders | Units | Revenue |
|---|---:|---:|---:|---:|
| gold_daily_sales | 24 days | 5,716 | 19,864 | 803,347,391.80 |
| gold_category_sales | 7 categories | 5,716 | 19,864 | 803,347,391.80 |
| gold_segment_sales | 5 segments | 5,716 | — | 803,347,391.80 |
| gold_region_sales | 5 regions | 5,716 | 19,864 | 803,347,391.80 |

## CDC and SCD2

**CDC (Change Data Capture)** identifies changed source records such as inserts and updates so that only changed data is processed downstream.

**SCD Type 2** stores the history of dimension changes by expiring the previous version and creating a new version with effective dates, a surrogate key, and an `is_current` flag.

In this project, CDC feeds the Customer and Product SCD2 processing.

## Point-in-Time Join

Gold facts resolve the appropriate dimension surrogate key using the business key together with the transaction date and the dimension's effective date range. This ensures historical orders reference the correct version of a customer or product.

## Delta Lake Features Demonstrated

### Table History

`DESCRIBE HISTORY` was used on the Gold fact table to inspect Delta transaction history.

### Time Travel

The Gold fact table was successfully queried using `VERSION AS OF 0` and reconciled to the current fact totals.

### Schema Evolution

A dedicated demonstration table was used to show Delta schema evolution with the `coupon_code` column using `mergeSchema = true`.

```text
Initial version : 100 rows, no coupon_code
Evolved version : 120 rows, coupon_code present
History         : 2 Delta versions
```

## Data Quality Finding

During the Customer SCD2 point-in-time join, **56 orders** could not be assigned a `customer_sk`, affecting **23 customer IDs**. These records were traced to invalid source historical customer dates. The project preserves the affected orders rather than inventing surrogate keys or fabricating historical dimension versions.

This issue is documented as a source-data quality exception and does not affect fact grain, product key resolution, store key resolution, or Gold aggregation reconciliation.

## Final Validation

The separate `06_final_validation.ipynb` notebook validates the completed project layer by layer.

Validated components:

```text
Bronze             ✅ PASS
Silver Stage 1     ✅ PASS
Customer SCD2      ✅ PASS
Product SCD2       ✅ PASS
Store Dimension    ✅ PASS
Gold Fact          ✅ PASS
Daily Sales        ✅ PASS
Category Sales     ✅ PASS
Segment Sales      ✅ PASS
Region Sales       ✅ PASS
Delta History      ✅ PASS
Delta Time Travel  ✅ PASS
Delta Schema Evol. ✅ PASS
```

## How to Run

1. Open the notebooks in Databricks.
2. Run `00_setup.ipynb` to configure the `retail_demo` catalog, schemas, volume/paths, and project settings.
3. Run the Bronze batch ingestion notebook.
4. Run the Bronze incremental/CDC notebook.
5. Run Silver Stage 1 cleaning and validation.
6. Run Silver Stage 2 SCD2 processing.
7. Run Gold fact and analytics creation.
8. Run `06_final_validation.ipynb` to verify the completed pipeline.

The project assumes a Databricks environment with Unity Catalog access and the required project datasets available to the configured paths.

## Documentation

The `documentation/` folder contains the final deliverables evidence document with screenshots of the required Databricks tables and validation outputs.

## Assignment Alignment

The implementation follows the assignment's required Bronze, Silver, and Gold architecture, including SCD Type 2, point-in-time dimension lookups, Gold analytics, Delta Table History, Time Travel, and Schema Evolution.

## Author

**Harshit Dani**

B.Tech – Computer Science and Engineering
Specialization: AI/ML and Robotics
