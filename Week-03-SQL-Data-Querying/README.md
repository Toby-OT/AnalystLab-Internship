# Week 3: SQL & Data Querying

**AnalystLab Africa — Data Analytics Internship**
Author: Tobiloba Osikoya

## Overview

This project covers SQL fundamentals through advanced querying, using PostgreSQL to extract, transform, and analyze structured data across two datasets:

- **Chinook Database** — a music store dataset (customers, invoices, tracks, albums, genres)
- **Sales Dataset** — an AdventureWorks-style B2B sales dataset (orders, product lines, deal sizes, customers)

## Objective

To develop SQL querying skills by:
- Extracting and transforming structured data
- Writing efficient queries
- Solving business-driven analytical questions

## Tools

- PostgreSQL 18
- pgAdmin 4

## Contents

```
Week3_SQL_Data_Querying/
├── sql/
│   └── week3_queries.sql      # Full commented SQL script (28 queries)
├── docs/
│   └── Week3_SQL_Insights.docx # Query explanations + key insights
└── README.md
```

## What's covered

1. **Core SQL** — SELECT, WHERE, ORDER BY
2. **Aggregate functions & grouping** — GROUP BY, HAVING, SUM/COUNT/AVG
3. **Joins** — INNER JOIN, LEFT JOIN across multi-table relationships
4. **Subqueries** — nested SELECTs and derived tables
5. **Window functions** — ROW_NUMBER, RANK, PARTITION BY
6. **Business problem solving** — top products/customers, revenue trends, purchasing behavior (run against both datasets)
7. **Query optimization** — indexing on frequently filtered/joined columns

## Key Insights

- Chinook customer spend is broad and evenly distributed — no single customer dominates revenue.
- The sales dataset is highly concentrated — the top account (Euro Shopping Channel) generates ~40% more than the #2 account.
- Classic Cars is the top-performing product line, generating more than double the next category.
- Medium-sized deals drive the most total revenue, but Large deals are disproportionately valuable per transaction.
- The USA accounts for roughly 3x the revenue of the next-best market (Spain).

Full explanations and figures are in [`docs/Week3_SQL_Insights.docx`](docs/Week3_SQL_Insights.docx).

## How to run

1. Install PostgreSQL and pgAdmin 4.
2. Create two databases: `chinook` and `sales_data`.
3. Import the [Chinook PostgreSQL dataset](https://github.com/lerocha/chinook-database) into `chinook`.
4. Import the [sales dataset](https://www.kaggle.com/datasets/kyanyoga/sample-sales-data) into a `sales` table in `sales_data`.
5. Run `sql/week3_queries.sql` against the appropriate database connection in pgAdmin's Query Tool.
