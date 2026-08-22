/*==========================================================
  Project       : Retail Sales Analysis
  Author        : Swetha D
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
-- ==========================================================

SELECT
    SUM(sales) AS Total_Sales,
    SUM(profit) AS Total_Profit,
    SUM(quantity) AS Total_Quantity,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM sample_superstore;


-- ==========================================================
-- BUSINESS QUESTION 2: Regional Sales Performance
-- ==========================================================

SELECT
    region,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY region
ORDER BY Total_Sales DESC;

-- ==========================================================
-- BUSINESS QUESTION 3: Top Cities by Sales
-- ==========================================================

SELECT
    city,
    SUM(sales) AS Total_Sales
FROM sample_superstore
GROUP BY city
ORDER BY Total_Sales DESC;


-- ==========================================================
-- BUSINESS QUESTION 4: Profit by Category
-- ==========================================================

SELECT
    category,
    SUM(profit) AS Total_Profit
FROM sample_superstore
GROUP BY category
ORDER BY Total_Profit DESC;

-- ==========================================================
-- BUSINESS QUESTION 5: Profit by Sub-Category
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
-- BUSINESS QUESTION 10: Top 3 Products Within Each Category
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

-- ==========================================================
-- BUSINESS QUESTION 14: Identify customers whose total sales 
-- are higher than the average total sales across all customers.
-- ==========================================================
SELECT customer_id,
SUM(sales) AS total_sales
FROM sample_superstore
GROUP BY customer_id
HAVING SUM(sales) >
(SELECT AVG(total_sales) 
FROM (SELECT customer_id,
SUM(sales) AS total_sales
FROM sample_superstore
GROUP BY customer_id)
AS sales_table);

SELECT 
(294 * 100/COUNT(DISTINCT customer_id)
)AS percentage
FROM sample_superstore;

-- ==========================================================
-- BUSINESS QUESTION 15: Which customers generated more total 
-- profit than the average customer profit?
-- ==========================================================

SELECT
    customer_id,
    SUM(profit) AS total_profit
FROM sample_superstore
GROUP BY customer_id
HAVING SUM(profit) >
(
    SELECT AVG(total_profit)
    FROM
    (
        SELECT
            customer_id,
            SUM(profit) AS total_profit
        FROM sample_superstore
        GROUP BY customer_id
    ) AS avg_profit_table);
    
-- ==========================================================
-- BUSINESS QUESTION 16: Identify customers whose total sales 
-- are higher than the average total sales across all customers.
-- ==========================================================
    
SELECT
    region,
    AVG(order_value) AS avg_order_value
FROM
(
    SELECT
        order_id,
        region,
        SUM(sales) AS order_value
    FROM sample_superstore
    GROUP BY order_id, region
) AS order_table
GROUP BY region
HAVING AVG(order_value) >
(
    SELECT AVG(overall_order_value)
    FROM
    (
        SELECT
            order_id,
            SUM(sales) AS overall_order_value
        FROM sample_superstore
        GROUP BY order_id
    ) AS avg_order_table
);

-- OR we can write with CTE too 

WITH order_table AS
(
    SELECT
        order_id,
        region,
        SUM(sales) AS order_value
    FROM sample_superstore
    GROUP BY order_id, region
)

SELECT
    region,
    AVG(order_value) AS avg_order_value
FROM order_table
GROUP BY region
HAVING AVG(order_value) >
(
    SELECT AVG(order_value)
    FROM order_table
);

-- ==========================================================
-- BUSINESS QUESTION 17: Identify customers who:
-- Have made more than 10 orders, AND
-- Generated total sales greater than the average customer total sales
-- ==========================================================

SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales) AS total_sales
FROM sample_superstore
GROUP BY customer_id
HAVING
    COUNT(DISTINCT order_id) > 10
    AND
    SUM(sales) >
    (
        SELECT AVG(total_sales)
        FROM
        (
            SELECT
                customer_id,
                SUM(sales) AS total_sales
            FROM sample_superstore
            GROUP BY customer_id
        ) AS sales_table
    );

-- ==========================================================
-- BUSINESS QUESTION 18: 
-- Identify the Top 10 customers by total sales.
-- ==========================================================

SELECT
    customer_id,
    SUM(sales) AS total_sales
FROM sample_superstore
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 10;
