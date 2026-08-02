\# Delta Lake Incremental Data Processing using Databricks WEEK_7_ASSIGNMENT

\## Overview

This project demonstrates incremental data processing using \*\*Delta Lake\*\* in \*\*Databricks\*\*. The objective is to simulate real-world data warehouse operations by loading a master dataset, performing data cleaning, creating an incremental dataset, and applying the \*\*MERGE (UPSERT)\*\* operation to update existing records and insert new records into a Delta table.

\---

\## Objective

1. Load a CSV dataset into a Delta Table.
2. Perform basic data cleaning.
3. Create an incremental dataset.
4. Update existing records using Delta Lake MERGE.
5. Insert new records using Delta Lake MERGE.
6. Validate the final dataset after the merge.
7. Display final dataset.

\## Tech Stack

\- Databricks Community Edition

\- Apache Spark (PySpark)

\- Delta Lake

\- Python

\- CSV

\## Project Structure

delta-lake-assignment/

│

├── data/

│ ├── customer_master.csv

│ └── customer_incremental.csv

│

├── notebooks/

│ └── delta_scd_assignment.ipynb

│

├── screenshots/

│ ├── data_loading/

│ ├── data_cleaning/

│ ├── incremental_data/

│ ├── merge/

│ ├── validation/

│ └── final_output/

│

├── report/

│ └── assignment_summary.pdf (Optional)

│

└── README.md

\## Project Workflow

\### Step 1: Data Loading

\- Imported the customer dataset into Databricks.

\- Created a managed Delta Table.

\- Loaded the data into a Spark DataFrame.

\### Step 2: Data Cleaning

Performed the following preprocessing steps:

\- Removed null values using `dropna()`

\- Removed duplicate rows using `dropDuplicates()`

\- Verified schema and record count

\### Step 3: Create Incremental Dataset

Created an incremental dataset by:

\- Selecting a few existing records

\- Updating the \*\*Sales\*\* column to simulate modified transactions

\- Adding new customer records to simulate newly arriving data

\### Step 4: Delta Lake MERGE (UPSERT)

Applied the Delta Lake `MERGE` operation using \*\*Row ID\*\* as the unique key.

```python

WHEN MATCHED THEN UPDATE

WHEN NOT MATCHED THEN INSERT

This operation:

\- Updated existing records

\- Inserted new records

\- Preserved all other records



### Step 5: Validation


Validated the merge by checking:

\- Number of updated rows

\- Number of inserted rows

\- Final record count

\- Newly inserted records

\- Updated Sales values


\## Sample MERGE Output



| Metric | Value |

|---------|------:|

| Updated Rows | 5 |

| Inserted Rows | 1 |

| Deleted Rows | 0 |

| Total Affected Rows | 6|



\## Learning Outcomes



Through this project, I learned:



\- Working with Delta Tables

\- Data cleaning using PySpark

\- Creating incremental datasets

\- Delta Lake MERGE (UPSERT)

\- Spark DataFrames

\- Data validation after incremental processing

\- Managing data pipelines using Databricks



\## Screenshots



The repository contains screenshots for:


\## How to Run



1\. Open the notebook in Databricks.

2\. Upload the master dataset.

3\. Execute all notebook cells sequentially.

4\. Review the MERGE results.

5\. Validate the final Delta table.



\---



\## Repository

GitHub Repository:

<https://github.com/Harshit-w/Celebal-Technologies-Internship-2026/Week 7>


\## Author

\*\*Harshit Dani\*\*
B.Tech Computer Science Engineering (AI/ML \& Robotics)
DIT University



```
