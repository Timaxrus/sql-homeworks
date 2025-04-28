
-- 1. Compute Running Total Sales per Customer

SELECT
	customer_id,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS RunTotalCustomer
FROM sales_data;


-- 2. Count the Number of Orders per Product Category

SELECT DISTINCT
	product_category,
    COUNT(sale_id) OVER(PARTITION BY product_category ORDER BY product_category) AS SaleCountPerCategory
FROM Sales_data;


-- 3. Find the Maximum Total Amount per Product Category

SELECT DISTINCT
	product_category,
    MAX(total_amount) OVER(PARTITION BY product_category) AS MaxTotalAmountCat
FROM sales_data;


-- 4. Find the Minimum Price of Products per Product Category

SELECT DISTINCT
	product_category,
    MIN(unit_price) OVER(PARTITION BY product_category) AS MinPriceProdCat
FROM sales_data;


-- 5. Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)

SELECT
	sale_id,
    total_amount,
    AVG(COALESCE(total_amount, 0)) OVER(ORDER BY (SELECT NULL) ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovAvg,
    order_date
FROM sales_data;


-- 6. Find the Total Sales per Region

SELECT DISTINCT
	region,
    SUM(total_amount) OVER(PARTITION BY region) AS TotalByRegion
FROM sales_data;


-- 7. Compute the Rank of Customers Based on Their Total Purchase Amount

WITH TotalCusPur AS (
SELECT DISTinct
	customer_id,
    SUM(total_amount) OVER(PARTITION BY customer_id) AS TotalPurchase
FROM sales_data)
SELECT
	customer_id,
    TotalPurchase,
    RANK() OVER(ORDER BY TotalPurchase DESC) AS RNK
FROM TotalCusPur;


-- 8. Calculate the Difference Between Current and Previous Sale Amount per Customer

SELECT
	customer_id,
    total_amount,
    COALESCE(LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date), 0) AS PrevSale,
    total_amount - COALESCE(LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date), 0) AS Diff
FROM sales_data;


-- 9. Find the Top 3 Most Expensive Products in Each Category

WITH RowNum AS (
SELECT
	product_category,
    product_name,
    unit_price,
    ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY unit_price DESC) AS TopExpenProd
FROM sales_data)
SELECT
	product_category,
    product_name,
    unit_price,
    TopExpenProd
FROM RowNum
WHERE TopExpenProd < 4;


-- 10. Compute the Cumulative Sum of Sales Per Region by Order Date

SELECT
	region,
    order_date,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY region ORDER BY order_date) AS CumTotal
FROM sales_data;

-- 11. Compute Cumulative Revenue per Product Category

SELECT
	product_category,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY product_category ORDER BY product_name, order_date) AS CumRevenue
FROM sales_data;

-- 12.

SELECT
	ID,
    SUM(COALESCE(LAG(ID)) OVER(ORDER BY ID), 0)
FROM (VALUES (1), (2), (3), (4), (5)) AS TestValue(ID)
