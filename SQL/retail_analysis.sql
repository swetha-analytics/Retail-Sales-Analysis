/*==========================================================
  Project       : Retail Sales Analysis
  Author        : Swetha Susan
  Database      : retail_sales_db
  Dataset       : Sample Superstore
  Description   : Business analysis using SQL to answer
                  key business questions on sales,
                  profitability, customers, products,
                  and monthly trends.
==========================================================*/

USE retail_sales_db;

-- ==========================================================
-- BUSINESS QUESTION 1: Overall Business KPIs
-- Objective:
-- Calculate the overall business performance.
-- ==========================================================

SELECT
    SUM(sales) AS Total_Sales,
    SUM(profit) AS Total_Profit,
    SUM(quantity) AS Total_Quantity,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM sample_superstore;


-- ==========================================================
-- BUSINESS QUESTION 2: Regional Sales Performance
-- Objective:
-- Identify which region generates the highest sales.
-- ==========================================================

SELECT
    region,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY region
ORDER BY Total_Sales DESC;


-- ==========================================================
-- BUSINESS QUESTION 3: Top Cities by Sales
-- Objective:
-- Find the highest revenue-generating cities.
-- ==========================================================

SELECT
    city,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY city
ORDER BY Total_Sales DESC;


-- ==========================================================
-- BUSINESS QUESTION 4: Profit by Category
-- Objective:
-- Determine which product categories generate
-- the highest profit.
-- ==========================================================

SELECT
    category,
    SUM(profit) AS Total_Profit
FROM sample_superstore
GROUP BY category
ORDER BY Total_Profit DESC;


-- ==========================================================
-- BUSINESS QUESTION 5: Profit by Sub-Category
-- Objective:
-- Identify the best-performing sub-categories.
-- ==========================================================

SELECT
    category,
    sub_category,
    SUM(profit) AS Total_Profit
FROM sample_superstore
GROUP BY category, sub_category
ORDER BY Total_Profit DESC;


-- ==========================================================
-- BUSINESS QUESTION 6: Top 10 Products by Sales
-- Objective:
-- Find the products generating the highest revenue.
-- ==========================================================

SELECT
    product_name,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY product_name
ORDER BY Total_Sales DESC
LIMIT 10;


-- ==========================================================
-- BUSINESS QUESTION 7: Top 10 Customers by Sales
-- Objective:
-- Identify the highest-value customers.
-- ==========================================================

SELECT
    customer_id,
    customer_name,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY customer_id, customer_name
ORDER BY Total_Sales DESC
LIMIT 10;


-- ==========================================================
-- BUSINESS QUESTION 8: Categories with Sales
-- Greater Than ₹500,000
-- ==========================================================

SELECT
    category,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY category
HAVING SUM(sales) > 500000;


-- ==========================================================
-- BUSINESS QUESTION 9: Category Profit Classification
-- Objective:
-- Classify categories based on total profit.
-- ==========================================================

SELECT
    category,
    SUM(profit) AS Total_Profit,

    CASE
        WHEN SUM(profit) > 200000 THEN 'High Profit'
        WHEN SUM(profit) BETWEEN 100000 AND 200000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS Profit_Level

FROM sample_superstore
GROUP BY category;


-- ==========================================================
-- BUSINESS QUESTION 10: Top 3 Products
-- Within Each Category
-- Objective:
-- Rank products by sales within every category.
-- ==========================================================

WITH ProductSales AS
(
    SELECT
        category,
        product_name,
        SUM(sales) AS Total_Sales,

        RANK() OVER
        (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS Rank_Number

    FROM sample_superstore
    GROUP BY category, product_name
)

SELECT
    category,
    product_name,
    Total_Sales
FROM ProductSales
WHERE Rank_Number <= 3;


-- ==========================================================
-- BUSINESS QUESTION 11: Monthly Sales Trend
-- Objective:
-- Analyze sales and profit across months.
-- ==========================================================

SELECT
    YEAR(STR_TO_DATE(order_date,'%d-%m-%Y')) AS Year,

    MONTH(STR_TO_DATE(order_date,'%d-%m-%Y')) AS Month,

    SUM(sales) AS Total_Sales,

    SUM(profit) AS Total_Profit

FROM sample_superstore

GROUP BY
    YEAR(STR_TO_DATE(order_date,'%d-%m-%Y')),
    MONTH(STR_TO_DATE(order_date,'%d-%m-%Y'))

ORDER BY
    Year,
    Month;


-- ==========================================================
-- BUSINESS QUESTION 12: Loss-Making Products
-- Objective:
-- Identify products generating an overall loss.
-- ==========================================================

SELECT
    product_name,
    SUM(sales) AS Total_Sales,
    SUM(profit) AS Total_Profit

FROM sample_superstore

GROUP BY product_name

HAVING SUM(profit) < 0

ORDER BY Total_Profit ASC;


-- ==========================================================
-- BUSINESS QUESTION 13: Orders Above Average Order Value
-- Objective:
-- Identify orders whose total sales are greater than
-- the average order value.
-- ==========================================================

SELECT
    order_id,
    Total_Sales

FROM
(
    SELECT
        order_id,
        SUM(sales) AS Total_Sales

    FROM sample_superstore

    GROUP BY order_id

) AS Order_Table

WHERE Total_Sales >
(
    SELECT AVG(Total_Sales)

    FROM
    (
        SELECT
            SUM(sales) AS Total_Sales

        FROM sample_superstore

        GROUP BY order_id

    ) AS Average_Order_Table
);

