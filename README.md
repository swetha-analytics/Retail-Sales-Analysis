# Retail Sales & Profitability Analysis

End-to-end retail sales analysis using SQL and Power BI — from raw data to business recommendations.

## Project Overview

This project analyzes the Sample Superstore retail dataset to uncover insights on sales performance, profitability, customer behavior, product performance, and regional trends — and translates those findings into concrete business recommendations.

**Business questions this project answers:**
- Which region and cities generate the highest sales?
- Which categories and sub-categories are most/least profitable?
- Which products are generating losses despite high sales?
- Which customers drive the most revenue?
- How do sales trend month-over-month, and where's the seasonality?
- What does a "top-performing" product look like across categories?

## Tools Used

- **SQL (MySQL)** — data querying and business-question analysis (18 queries)
- **Python (Pandas)** — cross-validation of SQL findings, shipping/delivery time analysis, and 3-month sales forecasting (linear regression)
- **Power BI** — interactive dashboard and visualization
- **Excel** — initial data checks

## Key Findings

- Total sales of **$2.30M** across 5,009 orders, with a **12.5% profit margin**
- **West region** leads in sales ($725K); **South region** lags and represents a growth opportunity
- **Technology** is the most profitable category ($145K profit); **Furniture** significantly underperforms ($18K profit) despite comparable sales volume
- Sales show strong **seasonality**, peaking Sep–Dec, driven by holiday and year-end demand
- A small number of high-ticket products (e.g. Cubify CubeX 3D Printers) are consistently **loss-making** despite high sales — likely due to discounting or shipping costs
- **Standard Class shipping** is the slowest delivery mode across every region (~5 days avg) — a clear logistics bottleneck
- A 3-month sales forecast (linear regression) projects steady **~1.3% month-over-month growth**

📄 **Full analysis, findings, and recommendations for all 12 business questions:** [`REPORT.md`](./REPORT.md)

## Dashboard

Interactive Power BI dashboard covering:
- **Page 1 — Overview:** KPIs, sales trend by year, sales by category
- **Page 2 — Deep Dive:** Sales by region, profit by category, sales by segment

## Repository Structure

```
Retail-Sales-Analysis/
├── README.md
├── REPORT.md                              # Full business analysis write-up
├── data/
│   └── Sample-Superstore.csv
├── sql/
│   └── retail_sales_analysis.sql          # All 18 business-question queries
├── python/
│   └── analysis.ipynb                     # Cross-validation, shipping analysis, forecasting
├── dashboard/
│   └── Superstore_Sales_Dashboard.pbix
└── images/
    └── dashboard_screenshot.png
```

## How to Reproduce

1. Import `data/Sample-Superstore.csv` into MySQL as table `sample_superstore`
2. Run the queries in `sql/retail_sales_analysis.sql`
3. Open `dashboard/Superstore_Sales_Dashboard.pbix` in Power BI Desktop to explore interactively

## Author

**Swetha D**

