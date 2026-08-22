# Retail Sales & Profitability Analysis — Sample Superstore

## Executive Summary

This project analyzes the Sample Superstore retail dataset to evaluate overall business performance, customer purchasing behavior, regional sales, product profitability, and sales trends. The objective is to identify growth opportunities, improve profitability, and support strategic business decisions through SQL-based analysis.

**Tools used:** SQL (MySQL) for querying · Python for data cleaning & EDA · Power BI for dashboarding

**Project files:**
- SQL queries: [`sql/retail_sales_analysis.sql`](./sql/retail_sales_analysis.sql)
- Python notebooks: [`python/`](./python)
- Dashboard: [`dashboard/`](./dashboard)

---

## Table of Contents

1. [Overall Business KPIs](#1-overall-business-kpis)
2. [Regional Sales Performance](#2-regional-sales-performance)
3. [Top Cities by Sales](#3-top-cities-by-sales)
4. [Profit by Category](#4-profit-by-category)
5. [Profit by Sub-Category](#5-profit-by-sub-category)
6. [Top 10 Products by Sales](#6-top-10-products-by-sales)
7. [Top 10 Customers by Sales](#7-top-10-customers-by-sales)
8. [Categories with Sales Greater Than $500,000](#8-categories-with-sales-greater-than-500000)
9. [Category Profit Classification](#9-category-profit-classification)
10. [Top 3 Products Within Each Category](#10-top-3-products-within-each-category)
11. [Monthly Sales Trend](#11-monthly-sales-trend)
12. [Loss-Making Products](#12-loss-making-products)
13. [Key Recommendations Summary](#key-recommendations-summary)

---

## 1. Overall Business KPIs
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 1*

**Business Objective:** Evaluate the company's overall performance using key business metrics.

**Result**

| KPI | Value |
|---|---|
| Total Sales | $2,297,201.07 |
| Total Profit | $286,397.79 |
| Total Quantity Sold | 37,873 |
| Total Orders | 5,009 |

**Observation:** The business generated $2.30M in sales across 5,009 customer orders, resulting in $286,397.79 profit and 37,873 units sold.

**Business Insight:** The company is profitable overall, indicating healthy operations. However, profit is only ~12.5% of total sales, suggesting room to improve margins by optimizing discounts, pricing, or product mix.

**Recommendation:**
- Monitor profit margin regularly
- Identify products with high sales but low profit
- Reduce unnecessary discounts on low-margin products

---

## 2. Regional Sales Performance
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 2*

**Result**

| Region | Total Sales |
|---|---|
| West | $725,457.93 |
| East | $678,781.36 |
| Central | $501,239.88 |
| South | $391,721.90 |

**Observation:** The West region generated the highest sales, while the South region generated the lowest.

**Business Insight:** The West region shows the strongest customer demand and revenue contribution. The South represents an opportunity for targeted growth.

**Recommendation:**
- Prioritize inventory allocation for the West
- Investigate why the South underperforms
- Evaluate regional marketing strategies

---

## 3. Top Cities by Sales
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 3*

**Observation:** The top five cities by sales are:

1. New York City
2. Los Angeles
3. Seattle
4. San Francisco
5. Philadelphia

**Business Insight:** Revenue is concentrated in major metropolitan areas, suggesting these cities are the company's primary markets.

**Recommendation:**
- Focus premium inventory in top-performing cities
- Explore expansion strategies in nearby metropolitan regions
- Analyze lower-performing cities to identify barriers to growth

---

## 4. Profit by Category
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 4*

**Result**

| Category | Total Profit |
|---|---|
| Technology | $145,455.66 |
| Office Supplies | $122,490.88 |
| Furniture | $18,451.25 |

**Observation:** Technology generated the highest profit, while Furniture generated significantly lower profit despite being a major product category.

**Business Insight:** Furniture may carry high operational costs, shipping expenses, or aggressive discounting that erodes profitability.

**Recommendation:**
- Review Furniture pricing and discount strategies
- Identify low-margin furniture products
- Prioritize high-margin technology products

---

## 5. Profit by Sub-Category
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 5*

**Observation:** The highest-profit sub-categories include:

1. Copiers
2. Phones
3. Accessories
4. Paper
5. Binders

**Business Insight:** Technology-related products consistently outperform other product groups, indicating strong customer demand and profitability.

**Recommendation:**
- Increase marketing investment and inventory for high-performing technology sub-categories

---

## 6. Top 10 Products by Sales
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 6*

**Observation:** The Canon imageCLASS 2200 Advanced Copier generated the highest sales, followed by other premium office equipment.

**Business Insight:** High-ticket enterprise products contribute substantially to total revenue despite relatively low sales volume.

**Recommendation:**
- Maintain stock availability for premium products
- Develop upselling strategies targeting business customers

---

## 7. Top 10 Customers by Sales
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 7*

**Observation:** Sean Miller is the highest revenue-generating customer, with purchases exceeding $25,000.

**Business Insight:** A small number of customers contribute disproportionately to overall revenue.

**Recommendation:**
- Implement customer loyalty programs and personalized promotions for high-value customers

---

## 8. Categories with Sales Greater Than $500,000
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 8*

**Observation:** All three categories generated sales greater than $500,000.

**Business Insight:** Revenue is diversified across all product categories, reducing dependence on any single category.

**Recommendation:**
- Continue balanced investment while focusing on improving profitability rather than only increasing sales

---

## 9. Category Profit Classification
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 9*

**Observation:** Technology and Office Supplies achieved medium-to-high profitability, while Furniture remained in the low-profit category.

**Business Insight:** Furniture requires immediate attention to improve margins.

**Recommendation:**
- Review supplier costs, shipping expenses, and discount policies for Furniture products

---

## 10. Top 3 Products Within Each Category
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 10*

**Observation:** Technology products dominate the highest-selling items within their category.

**Business Insight:** Premium technology products consistently outperform furniture and office products in revenue generation.

**Recommendation:**
- Expand premium technology offerings while evaluating underperforming products

---

## 11. Monthly Sales Trend
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 11*

**Observation:** Sales increased significantly from September through December, particularly in November and December, while January and February recorded comparatively lower sales.

**Business Insight:** The business experiences strong seasonality, likely driven by holiday shopping, year-end promotions, and corporate purchasing cycles.

**Recommendation:**
- Increase inventory before Q4
- Launch promotional campaigns before peak months
- Prepare staffing and logistics for year-end demand

---

## 12. Loss-Making Products
*SQL reference: `sql/retail_sales_analysis.sql` — Business Question 12*

**Observation:** Several premium products generated substantial sales but resulted in significant losses, particularly the Cubify CubeX 3D Printer models and certain conference tables.

**Business Insight:** High sales do not necessarily translate into profitability. Excessive discounts, procurement costs, or shipping expenses may be eroding margins on these items.

**Recommendation:**
- Review pricing strategies for loss-making products
- Limit discounts on expensive items
- Consider discontinuing consistently unprofitable products or renegotiating supplier contracts

---

*Additional analysis — including above-average customer sales/profit, order-value benchmarking, and high-frequency customer identification — is available in the SQL file (`sql/retail_sales_analysis.sql`, Business Questions 13–18).*

---

## Key Recommendations Summary

| Area | Recommendation |
|---|---|
| Profitability | Reduce unnecessary discounts on low-margin products; monitor margin, not just revenue |
| Regional Strategy | Prioritize West region inventory; investigate South region underperformance |
| Product Strategy | Review Furniture pricing/discounting; expand high-margin Technology offerings |
| Customer Strategy | Build a loyalty program around top revenue-generating customers |
| Seasonality | Plan inventory, staffing, and promotions around the Sep–Dec demand surge |
| Risk Management | Audit and address consistently loss-making products (e.g. 3D printers, conference tables) |

---

*Dashboard: see [`/dashboard`](./dashboard) for the interactive Power BI report and screenshots.*
*Python analysis: see [`/python`](./python) for data cleaning and EDA notebooks.*
