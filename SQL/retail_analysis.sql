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
/*============================================================
OBSERVATION

The business generated ₹2,297,201.07 in total sales and
₹286,397.79 in total profit from 5,009 customer orders,
selling 37,873 units.

BUSINESS INSIGHT

The company is profitable overall with a healthy sales
volume. However, the overall profit margin is approximately
12.5%, indicating opportunities to improve profitability by
optimizing pricing, discounts, and product mix.

RECOMMENDATION

• Monitor profit margins monthly.
• Investigate low-margin products.
• Optimize pricing and discount strategies.
============================================================*/

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

/*============================================================
OBSERVATION
The West region generated the highest sales, 
while the South region generated the lowest.

BUSINESS INSIGHT

The West region appears to have the strongest
customer demand and revenue contribution. 
The South region may represent an opportunity 
for targeted business growth.

RECOMMENDATION
Prioritize inventory allocation for the West.
Investigate why South underperforms.
Evaluate regional marketing strategies.
============================================================*/

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

/*============================================================
OBSERVATION
The top five cities by sales are:

New York City
Los Angeles
Seattle
San Francisco
Philadelphia

BUSINESS INSIGHT

Revenue is concentrated in major metropolitan
areas, suggesting these cities are the
company's primary markets.

RECOMMENDATION
Focus premium inventory in top-performing cities.
Explore expansion strategies in nearby metropolitan regions.
Analyze lower-performing cities to identify barriers to growth.
============================================================*/

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

/*============================================================
OBSERVATION
Technology generated the highest profit, whereas Furniture
generated significantly lower profit despite being a major 
product category.

BUSINESS INSIGHT

Furniture may experience high operational costs,
shipping expenses, or aggressive discounting 
that reduces profitability.

RECOMMENDATION
Review Furniture pricing and discount strategies.
Identify low-margin furniture products.
Prioritize high-margin technology products.
============================================================*/

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

/*============================================================
OBSERVATION
The highest-profit sub-categories include:
Copiers
Phones
Accessories
Paper
Binders

BUSINESS INSIGHT

Technology-related products consistently 
outperform other product groups, indicating 
strong customer demand and profitability.

RECOMMENDATION
Increase marketing investment and inventory 
for high-performing technology products.
============================================================*/

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

/*============================================================
OBSERVATION
The Canon imageCLASS 2200 Advanced Copier generated 
the highest sales, followed by premium office equipment.

BUSINESS INSIGHT

High-ticket enterprise products contribute substantially 
to total revenue despite relatively low sales volume.

RECOMMENDATION
Maintain stock availability for premium products 
and develop upselling strategies targeting 
business customers.
============================================================*/
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

/*============================================================
OBSERVATION
Sean Miller is the highest revenue-generating customer 
with purchases exceeding ₹25,000.

BUSINESS INSIGHT

A small number of customers contribute 
disproportionately to overall revenue.

RECOMMENDATION
Implement customer loyalty programs and 
personalized promotions for high-value customers.
============================================================*/

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

/*============================================================
OBSERVATION
All three categories generated sales greater than ₹500,000.

BUSINESS INSIGHT

Revenue is diversified across all product categories, 
reducing dependence on a single category.

RECOMMENDATION
Continue balanced investment while focusing on improving 
profitability rather than only increasing sales.
============================================================*/
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

/*============================================================
OBSERVATION
Technology and Office Supplies achieved medium profitability, 
while Furniture remained in the low-profit category.

BUSINESS INSIGHT

Furniture requires immediate attention to improve margins.

RECOMMENDATION
Review supplier costs, shipping expenses, and 
discount policies for Furniture products.
/*============================================================

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

/*============================================================
OBSERVATION
Technology products dominate the highest-selling items 
within their category.

BUSINESS INSIGHT
Premium technology products consistently outperform 
furniture and office products in revenue generation.

RECOMMENDATION
Expand premium technology offerings while 
evaluating underperforming products.
/*============================================================
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
/*============================================================
OBSERVATION
Sales increased significantly during September to December, 
particularly in November and December, while January 
and February recorded comparatively lower sales.

BUSINESS INSIGHT
The business experiences strong seasonality, 
likely driven by holiday shopping, year-end 
promotions, and corporate purchasing cycles.

RECOMMENDATION
Increase inventory before Q4.
Launch promotional campaigns before peak months.
Prepare staffing and logistics for year-end demand.
/*============================================================

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

/*============================================================
OBSERVATION
Several premium products generated substantial sales but 
resulted in significant losses, particularly the Cubify 
CubeX 3D Printer models and certain conference tables.

BUSINESS INSIGHT
High sales do not necessarily translate into profitability. 
Excessive discounts, procurement costs, or 
shipping expenses may be eroding margins.

RECOMMENDATION
Review pricing strategies for loss-making products.
Limit discounts on expensive items.
Consider discontinuing consistently unprofitable products 
or renegotiating supplier contracts.
/*============================================================

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

/*============================================================
OBSERVATION

A total of XX orders had sales greater than the average order
value. These orders represent high-value transactions that
contributed significantly to the company's overall revenue.

BUSINESS INSIGHT

The business receives a relatively small number of high-value
orders that generate a substantial portion of total sales.
Understanding the products and customers associated with these
orders can help identify profitable customer segments and
successful sales strategies.

RECOMMENDATION

• Identify the customers placing these high-value orders.
• Analyze products commonly purchased in these orders.
• Develop loyalty programs targeting high-value customers.
• Ensure sufficient inventory for products frequently included
  in high-value transactions.
============================================================*/
