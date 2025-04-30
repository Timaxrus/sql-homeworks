
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
	SUM(ID) OVER(ORDER BY (SELECT NULL) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS vrem
FROM (VALUES (1), (2), (3), (4), (5)) AS TestValue(ID)


-- 13.

SELECT
	Value,
	LAG(Value, 1, 0) OVER(ORDER BY (SELECT NULL)) + Value AS SumWithPreVal
FROM OneColumn;

-- 14. 

SELECT 
    Id,
    Vals,
    ROW_NUMBER() OVER (ORDER BY Id, Vals) AS BaseRowNum,
	CASE WHEN LAG(Id) OVER(ORDER BY Id) IS NULL THEN ROW_NUMBER() OVER (ORDER BY Id, Vals)
		WHEN Id = LAG(Id) OVER(ORDER BY Id) THEN ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1
		WHEN Id != LAG(Id) OVER(ORDER BY Id) AND (ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1) % 2 = 0
		THEN ROW_NUMBER() OVER (ORDER BY Id, Vals) + 2
		ELSE ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1 END AS Final
INTO #MyBurden
FROM Row_Nums
ORDER BY Id, Vals;

SELECT 
    Id,
    Vals,
    CASE 
        WHEN Id != LAG(Id) OVER(ORDER BY Id) AND Final = LAG(Final) OVER(ORDER BY Id) 
			 THEN Final + 2
        ELSE Final END AS Final
FROM #MyBurden;

-- 15. 

WITH CustProd AS (
SELECT
	customer_id,
    COUNT(product_category) OVER(PARTITION BY customer_id) AS prod_count
FROM Sales_data
)
SELECT
	customer_id,
    prod_count
FROM CustProd
WHERE prod_count > 1;

-- 16. 

WITH CustProd AS (
SELECT
	region,
  	customer_id,
  	total_amount,
    AVG(total_amount) OVER(PARTITION BY region) AS avg_spend_reg
FROM Sales_data
)
SELECT
	region,
	customer_id,
    total_amount AS spend_amount,
    avg_spend_reg
FROM CustProd
WHERE total_amount > avg_spend_reg;

-- 17. 

SELECT
	region,
    customer_id,
    total_amount,
    DENSE_RANK() OVER(PARTITION BY region ORDER BY total_amount DESC) AS DRNK
FROM sales_data;

-- 18. 

SELECT
	order_date,
    customer_id,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS Run_total
FROM sales_data;

-- 19.

WITH Sales_Growth AS (
SELECT DISTINCT
	DATEPART(MONTH, order_date) AS sale_month,
    DATEPART(YEAR, order_date) AS sale_year,
    SUM(total_amount) OVER(PARTITION BY DATEPART(MONTH, order_date) ORDER BY DATEPART(MONTH, order_date)) AS growth_rate_monthly
FROM sales_data
)

SELECT
	*,
    LAG(growth_rate_monthly, 1, 0) OVER(PARTITION BY sale_month ORDER BY sale_month) AS prev_month,
    growth_rate_monthly - LAG(growth_rate_monthly, 1, 0) OVER(PARTITION BY sale_month ORDER BY sale_month) AS Diff
FROM Sales_Growth;

-- 20. 

WITH CTE AS (
SELECT 
	customer_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER(PARTITION BY customer_id) AS total_purchase
FROM sales_data
)

SELECT
	customer_id,
    total_amount,
    total_purchase,
    order_date
FROM CTE
GROUP BY customer_id, total_amount, total_purchase, order_date
HAVING total_amount >= total_purchase AND order_date = MAX(order_date);

-- 21. 


with cte AS (
SELECT
  	product_name,
  	unit_price,
    AVG(unit_price) OVER() AS avg_prod_price
FROM sales_data)
SELECT
	product_name,
    unit_price,
    avg_prod_price
FROM cte
WHERE unit_price > avg_prod_price;

-- 22.

SELECT
	Id,
    Grp,
    Val1,
    Val2,
    CASE WHEN LAG(Grp) OVER(ORDER BY Grp) IS NULL OR Grp != LAG(Grp) OVER(ORDER BY Grp)
    	 THEN SUM(Val1) OVER(PARTITION BY Grp) + SUM(Val2) OVER(PARTITION BY Grp)
   	ELSE NULL
    END AS Total
FROM MyData;

-- 23.

SELECT DISTINCT
	ID,
    SUM(Cost) OVER(PARTITION BY ID ORDER BY ID) AS Cost,
    CASE WHEN Quantity = LEAD(Quantity) OVER(PARTITION BY ID ORDER BY ID) 
           AND LAG(Quantity) OVER(PARTITION BY ID ORDER BY ID) IS NULL
           OR Quantity = LAG(Quantity) OVER(PARTITION BY ID ORDER BY ID) 
           THEN Quantity
    	 ELSE SUM(Quantity) OVER(PARTITION BY ID ORDER BY ID)
    END AS Quantity
FROM TheSumPuzzle;

-- 24. 


WITH Problem1 AS (
    SELECT
        Level,
        TyZe,
        Result,
        SUM(CASE WHEN Result = 'X' THEN 1 ELSE 0 END)
            OVER (ORDER BY (SELECT NULL) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS GroupID,
  		ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS RowNum,
  		CASE WHEN Level = 1 AND LAG(Level) OVER(ORDER BY (SELECT NULL)) != 1 THEN 1 ELSE 0 END AS stupid
    FROM testSuXVI
), Problem2 AS (
SELECT
	Level,
    TyZe,
    Result,
    RowNum,
    SUM(stupid) OVER(ORDER BY RowNum) AS NewG
FROM Problem1
), Problem3 AS (
SELECT
	Level,
    TyZe,
    Result,
    NewG,
  	RowNum,
    CASE WHEN Result = 'Z' AND LAG(Result) OVER(ORDER BY RowNum) = 'Z' AND NewG = LAG(NewG) OVER(ORDER BY RowNum) THEN NewG + 1 ELSE NewG END AS NewG2
FROM Problem2)
, Problem4 AS (
SELECT
	Level,
    TyZe,
    Result,
    CASE WHEN NewG2 = 0 THEN 1
    	WHEN Result = 'Z' AND LAG(Result) OVER(ORDER BY RowNum) = 'Z' AND NewG2 = LAG(NewG2) OVER(ORDER BY RowNum) THEN NewG2 + 1 
        ELSE NewG2 
    END AS NewG2
 FROM Problem3
)
SELECT
	Level,
    TyZe,
    Result,
    NewG2,
    CASE WHEN Result = 'Z' THEN SUM(TyZe) OVER(PARTITION BY NewG2 ORDER BY NewG2) ELSE NULL END AS Groups
 FROM Problem4


-- 25. 

SELECT 
    Id,
    Vals,
    ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1 AS BaseRowNum,
	CASE WHEN LAG(Id) OVER(ORDER BY Id) IS NULL THEN ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1
		WHEN Id = LAG(Id) OVER(ORDER BY Id) THEN ROW_NUMBER() OVER (ORDER BY Id, Vals) + 2
		WHEN Id != LAG(Id) OVER(ORDER BY Id) AND (ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1) % 2 != 0
		THEN ROW_NUMBER() OVER (ORDER BY Id, Vals) + 2
		ELSE ROW_NUMBER() OVER (ORDER BY Id, Vals) + 1 END AS Final
INTO #SameBurden
FROM Row_Nums
ORDER BY Id, Vals;

WITH EvenNum AS (
SELECT 
    Id,
    Vals,
    CASE 
        WHEN Id != LAG(Id) OVER(ORDER BY Id) AND Final = LAG(Final) OVER(ORDER BY Id) 
			 THEN Final + 2
		WHEN Id != LAG(Id) OVER(ORDER BY Id) AND Final = Final + 2 THEN Final + 4 
        ELSE Final END AS Final
FROM #SameBurden
)
SELECT
	Id,
	Vals,
	CASE WHEN Id != LAG(Id) OVER(ORDER BY Id) AND Final = LAG(Final) OVER(ORDER BY Id) AND Final + 1 % 2 != 0 THEN Final + 2
		ELSE Final END AS Final
FROM EvenNum;