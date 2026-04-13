# Banking Analytics Pipeline

## Description
An end-to-end banking analytics pipeline built with Python, MySQL, and Power BI. Ingests and transforms 13.6M+ rows of loan and payment data, automates the full pipeline with logging, and delivers a 3-page interactive Power BI dashboard covering customer profiling, loan performance, and default risk analysis.

## 📋 Requirements

![Python](https://img.shields.io/badge/Python_3.x-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL_8.0+-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![ODBC](https://img.shields.io/badge/MySQL_ODBC_Connector-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI_Desktop-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Jupyter](https://img.shields.io/badge/Jupyter_Notebook-F37626?style=for-the-badge&logo=jupyter&logoColor=white)
![Git LFS](https://img.shields.io/badge/Git_LFS-F05032?style=for-the-badge&logo=git&logoColor=white)

## Tech Stack
- **Python** — Data ingestion, transformation, pipeline automation
- **MySQL** — Staging tables, star schema, stored transformations
- **Power BI** — Interactive 3-page dashboard with DAX measures
- **Jupyter Notebook** — Development and execution environment

## Dataset
[Home Credit Default Risk](https://www.kaggle.com/competitions/home-credit-default-risk/data) from Kaggle
- `application_train.csv` — 307,511 rows — customer and loan data
- `installments_payments.csv` — 13,605,401 rows — payment behavior

## Project Structure
```
banking_project/
├── data/                        # Raw CSV files
│   ├── application_train.csv
│   └── installments_payments.csv
├── notebooks/
│   └── pipeline.ipynb           # Main Jupyter notebook
├── logs/                        # Auto-generated pipeline logs
└── dashboard/
│    └── banking_dashboard.pbix   # Power BI dashboard file
└── SQL file/
    └── DB_file.sql   # SQL database file
```

## Database Schema

### Staging Tables
| Table | Rows | Description |
|---|---|---|
| stg_applications | 307,511 | Raw customer and loan data |
| stg_installments | 13,605,401 | Raw payment records |

### Star Schema
| Table | Type | Description |
|---|---|---|
| dim_customer | Dimension | Customer demographics |
| dim_loan | Dimension | Loan details and terms |
| dim_payment | Dimension | Individual payment records |
| fact_loan_performance | Fact | KPIs — default rate, repayment, debt burden |

## Pipeline Phases

**Phase 1 — Ingestion**
- Loads CSV files into MySQL staging tables
- Chunked loading (10,000 rows at a time) to handle large files
- Handles first load and incremental appends

**Phase 2 — Transformation**
- Builds star schema from staging tables
- Calculates key ratios: credit-to-income, debt burden, repayment ratio
- Chunked processing for large tables to avoid MySQL timeouts

**Phase 3 — Automation**
- Single pipeline function runs full ingestion and transformation
- Logs every run with timestamps, row counts, and errors
- Log files saved daily to /logs/ folder

**Phase 4 — Dashboard**
- 3-page Power BI dashboard connected to MySQL views
- DAX measures for Default Rate, High Risk Customers, Avg Repayment Ratio
- Slicers, cross filtering, and conditional formatting

## Key Insights
- **Working class** has the highest default volume at 9.6% — largest risk segment in the portfolio
- **90.48% of loans are cash loans** — significant portfolio concentration risk
- **Lower secondary education** carries the highest average debt burden ratio
- **35-44 age group** represents the largest borrower segment
- **81K high-risk customers** have credit-to-income ratio above 5

## DAX Measures
```
Default Rate = AVERAGE(fact_loan_performance[is_defaulted]) * 100

High Risk Customers = 
COUNTROWS(FILTER(fact_loan_performance, 
fact_loan_performance[credit_to_income_ratio] > 5))

Avg Repayment Ratio = AVERAGE(fact_loan_performance[repayment_ratio])
```

## How to Run

1. Install dependencies:
```bash
pip install pandas sqlalchemy pymysql
```

2. Set up MySQL database:
```sql
CREATE DATABASE banking_project;
```

3. Update DB_CONFIG in the notebook with your credentials

4. Run cells in order in `pipeline.ipynb`

5. Connect Power BI Desktop to MySQL using the MySQL ODBC Connector

## Requirements
- Python 3.x
- MySQL 8.0+
- MySQL ODBC Connector (for Power BI)
- Power BI Desktop
- Jupyter Notebook
