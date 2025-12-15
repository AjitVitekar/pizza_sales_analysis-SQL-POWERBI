/* ============================================================
   Project : Pizza Sales Analysis
   Author  : Ajit Vitekar
   Tech    : SQL (Data Analysis for Power BI Dashboard)
   Purpose : This file contains all SQL queries used to
             calculate KPIs, trends, and insights for the
             Pizza Sales Power BI Dashboard.
   ============================================================ */


/* ============================================================
   A. KEY PERFORMANCE INDICATORS (KPIs)
   ============================================================ */

-- 1. Total Revenue
SELECT 
    SUM(total_price) AS total_revenue
FROM pizza_sales;


-- 2. Average Order Value
SELECT 
    SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;


-- 3. Total Pizzas Sold
SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;


-- 4. Total Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;


-- 5. Average Pizzas Per Order
SELECT 
    CAST(SUM(quantity) AS DECIMAL(10,2)) /
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) 
    AS avg_pizzas_per_order
FROM pizza_sales;



/* ============================================================
   B. DAILY TREND FOR TOTAL ORDERS
   ============================================================ */

SELECT 
    DATENAME(WEEKDAY, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY total_orders DESC;



/* ============================================================
   C. MONTHLY TREND FOR TOTAL ORDERS
   ============================================================ */

SELECT 
    DATENAME(MONTH, order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC;



/* ============================================================
   D. PERCENTAGE OF SALES BY PIZZA CATEGORY
   ============================================================ */

SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales)
        AS DECIMAL(10,2)
    ) AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY revenue_percentage DESC;



/* ============================================================
   E. PERCENTAGE OF SALES BY PIZZA SIZE
   ============================================================ */

SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales)
        AS DECIMAL(10,2)
    ) AS revenue_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY revenue_percentage DESC;



/* ============================================================
   F. TOTAL PIZZAS SOLD BY PIZZA CATEGORY (MONTH-WISE)
   Example shown for February
   ============================================================ */

SELECT 
    pizza_category,
    SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;



/* ============================================================
   G. TOP 5 PIZZAS BY REVENUE
   ============================================================ */

SELECT TOP 5
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;



/* ============================================================
   H. BOTTOM 5 PIZZAS BY REVENUE
   ============================================================ */

SELECT TOP 5
    pizza_name,
    SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC;



/* ============================================================
   I. TOP 5 PIZZAS BY QUANTITY SOLD
   ============================================================ */

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC;



/* ============================================================
   J. BOTTOM 5 PIZZAS BY QUANTITY SOLD
   ============================================================ */

SELECT TOP 5
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC;



/* ============================================================
   K. TOP 5 PIZZAS BY TOTAL ORDERS
   ============================================================ */

SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC;



/* ============================================================
   L. BOTTOM 5 PIZZAS BY TOTAL ORDERS
   ============================================================ */

SELECT TOP 5
    pizza_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC;
