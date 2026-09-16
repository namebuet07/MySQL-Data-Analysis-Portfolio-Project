# Customer, Sales & Payment Analysis Using SQL

## Project Overview

This project demonstrates practical SQL skills through the analysis of relational business data involving customers, products, invoices, payments, and payment methods. The project uses MySQL to organize, query, combine, and analyze multiple related datasets.

The goal is to demonstrate SQL techniques commonly used in data analysis and data science workflows, including data retrieval, filtering, joins, aggregation, subqueries, and window functions.

## Project Objectives

- Build and work with relational tables in MySQL.
- Explore customer, product, invoice, and payment data.
- Combine information from multiple tables using joins.
- Apply aggregate functions to summarize business data.
- Use subqueries to answer comparative analytical questions.
- Apply window functions for ranking and cumulative analysis.
- Translate transactional data into useful analytical information.

## Datasets

The project contains five datasets:

| Dataset | Description |
|---|---|
| `customers.csv` | Customer information, including location and loyalty points |
| `products.csv` | Product information, inventory quantities, and unit prices |
| `invoices.csv` | Invoice totals, payment totals, invoice dates, due dates, and payment dates |
| `payments.csv` | Individual customer payment transactions |
| `payment_methods.csv` | Reference information for available payment methods |

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- CSV
- Git & GitHub

## SQL Skills Demonstrated

- Database and table creation
- Data insertion and retrieval
- `SELECT` and `DISTINCT`
- `WHERE` filtering
- Logical conditions
- Calculated columns
- Aggregate functions
- `GROUP BY` and `HAVING`
- `INNER JOIN`
- `LEFT JOIN`
- Subqueries
- Window functions
- `RANK() OVER()`
- `PARTITION BY`
- Running totals with `SUM() OVER()`

## Analysis Workflow

### 1. Customer Analysis

Customer records are explored to examine geographic distribution, customer characteristics, and loyalty behavior. Queries include identifying unique customer locations and filtering customers using demographic and loyalty-point criteria.

### 2. Product Analysis

Product data are analyzed to examine pricing and inventory information. Calculated fields and subqueries are used to evaluate product prices and compare products against reference values.

### 3. Invoice Analysis

Invoice records are analyzed using invoice totals, payment totals, invoice dates, due dates, and payment dates. SQL queries are used to filter transactions and compare invoice activity among customers.

### 4. Payment Analysis

Payment transactions are combined with payment-method information to examine how transactions were completed and identify payments that satisfy selected analytical criteria.

### 5. Multi-Table Analysis

Relational joins connect customer, invoice, and payment information. `INNER JOIN` and `LEFT JOIN` queries are used to analyze relationships among tables and identify records with or without corresponding matches.

### 6. Advanced SQL Analysis

Subqueries and window functions are used for more advanced analytical tasks, including:

- Comparing customer loyalty points with the overall average.
- Comparing invoice values across customers.
- Ranking invoices within each customer.
- Calculating cumulative invoice totals.

## Example SQL Query

The following query demonstrates a window function for ranking invoices within each customer:

```sql
SELECT
    client_id,
    invoice_id,
    invoice_total,
    RANK() OVER (
        PARTITION BY client_id
        ORDER BY invoice_total DESC
    ) AS invoice_rank
FROM invoices;
```

## Repository Structure

```text
MySQL-Data-Analysis-Portfolio-Project/
├── README.md
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── invoices.csv
│   ├── payments.csv
│   └── payment_methods.csv
├── sql/
│   └── customer_sales_analysis.sql
└── results/
    └── analysis_summary.md
```

## Key Takeaways

This project demonstrates the ability to work with relational datasets and apply SQL to retrieve, transform, combine, and analyze structured business data. It highlights foundational and intermediate SQL techniques relevant to data analyst and data scientist roles.

## Author

**Ahammad Abdullah**

Ph.D. Researcher in Mechanical Engineering  
Interests: Data Science, Data Analysis, SQL, Python, MATLAB, Remote Sensing, and Scientific Data Analysis
