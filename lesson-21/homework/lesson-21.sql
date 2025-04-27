-- 1. Write a query to assign a row number to each sale based on the SaleDate.

SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY SaleDate) AS RN
FROM ProductSales;

-- 2. Write a query to rank products based on the total quantity sold (use DENSE_RANK())

WITH TotalQuantity AS (
SELECT
	ProductName,
	SUM(ISNULL(Quantity, 0)) AS TotalQtySold
FROM ProductSales
GROUP BY ProductName)
SELECT
	ProductName,
	TotalQtySold,
	DENSE_RANK() OVER(ORDER BY TotalQtySold DESC) DR
FROM TotalQuantity;


-- 3. Write a query to identify the top sale for each customer based on the SaleAmount.

SELECT DISTINCT
	CustomerID,
	SaleAmount,
	MAX(SaleAmount) OVER(PARTITION BY CustomerID) AS TopSale
FROM ProductSales;


-- 4. Write a query to display each sale's amount along with the next sale amount in the order of SaleDate using the LEAD() function

SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	Quantity,
	LEAD(SaleAmount) OVER(ORDER BY SaleDate) AS NextSale
FROM ProductSales;

-- 5. Write a query to display each sale's amount along with the previous sale amount in the order of SaleDate using the LAG() function44

SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	Quantity,
	LAG(SaleAmount) OVER(ORDER BY SaleDate) AS NextSale
FROM ProductSales;


-- 6. Write a query to rank each sale amount within each product category.

SELECT
	*,
	RANK() OVER(PARTITION BY ProductName ORDER BY SaleAmount DESC, SaleDate) AS RNK
FROM ProductSales;

-- 7. Write a query to identify sales amounts that are greater than the previous sale's amount

WITH PrevSale AS(
SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	LAG(SaleAmount) OVER(ORDER BY SaleDate) AS PrevSales
FROM ProductSales)

SELECT
	*
FROM PrevSale
WHERE SaleAmount > PrevSales;


-- 8. Write a query to calculate the difference in sale amount from the previous sale for every product

SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	ISNULL(LAG(SaleAmount) OVER (ORDER BY SaleDate), 0) AS PrevSale,
	ISNULL(LAG(SaleAmount) OVER (ORDER BY SaleDate), 0) - ISNULL(SaleAmount, 0) AS Diff
FROM ProductSales;


-- 9. Write a query to compare the current sale amount with the next sale amount in terms of percentage change.

SELECT
	ProductName,
	SaleDate,
	SaleAmount AS CurrentSale,
	LEAD(SaleAmount) OVER(ORDER BY SaleDate) AS NextSale,
	CONCAT(CAST(SaleAmount / LEAD(SaleAmount) OVER(ORDER BY SaleDate)  * 100 AS DECIMAL(5,2)), '', '%') AS PercentChange
FROM ProductSales;

-- 10. Write a query to calculate the ratio of the current sale amount to the previous sale amount within the same product.

SELECT
	ProductName,
	SaleDate,
	SaleAmount AS CurrentSale,
	ISNULL(LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate), 0) AS PrevSale,
	CASE WHEN LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN '0.00%'
		ELSE CONCAT(CAST(SaleAmount / ISNULL(LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate), 0) * 100 AS DECIMAL(5,2)), '', '%')
		END AS Ratio
FROM ProductSales;

-- 11. Write a query to calculate the difference in sale amount from the very first sale of that product.

SELECT
	SaleID,
	ProductName,
	SaleDate,
	SaleAmount AS CurrentSale,
	FIRST_VALUE(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) AS FirstSale,
	FIRST_VALUE(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount AS Diff
FROM ProductSales;


-- 12. Write a query to find sales that have been increasing continuously for a product (i.e., each sale amount is greater than the previous sale amount for that product).

WITH PrevSale AS (
SELECT
	ProductName,
	LAG(SaleAmount) OVER(PARTITION BY ProductName ORDER BY SaleAmount) AS PrevSale,
	SaleAmount AS CurrentSale
FROM ProductSales)
SELECT
	ProductName,
	CurrentSale
FROM PrevSale
WHERE CurrentSale > PrevSale;

-- 13. Write a query to calculate a "closing balance" for sales amounts which adds the current sale amount to a running total of previous sales.

SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	SUM(SaleAmount) OVER(ORDER BY SaleDate) AS ClosingBalance
FROM ProductSales;

-- 14. Write a query to calculate the moving average of sales amounts over the last 3 sales.

SELECT
	ProductName,
	SaleAmount,
	SaleDate,
	AVG(SaleAmount) OVER(ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
FROM ProductSales;


-- 15. Write a query to show the difference between each sale amount and the average sale amount.

SELECT
	ProductName,
	SaleDate,
	SaleAmount,
	AVG(SaleAmount) OVER() AS AvgSale,
	SaleAmount - AVG(SaleAmount) OVER(ORDER BY SaleDate) AS Diff
FROM ProductSales;

-- 16. Find Employees Who Have the Same Salary Rank

WITH SalRank AS (
SELECT 
	EmployeeID,
	Name,
	Salary,
	DENSE_RANK() OVER(ORDER BY Salary DESC) AS RNK
FROM Employees1) 
SELECT
	sr1.Name,
	sr1.Salary,
	sr1.RNK
FROM SalRank AS sr1
JOIN
	(SELECT
		RNK
	FROM SalRank
	GROUP BY RNK
	HAVING COUNT(RNK) > 1) AS sr2
	ON sr1.RNK = sr2.RNK;


-- 17. Identify the Top 2 Highest Salaries in Each Department

WITH TOP2 AS(
SELECT
	Department,
	Salary,
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RNK
FROM Employees1)
SELECT
	*
FROM TOP2
WHERE RNK <= 2;


-- 18. Find the Lowest-Paid Employee in Each Department

WITH LowestPaid AS(
SELECT
	Name,
	Department,
	Salary,
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary ASC) AS RNK
FROM Employees1)
SELECT
	*
FROM LowestPaid
WHERE RNK = 1;



-- 19. Calculate the Running Total of Salaries in Each Department

SELECT
	Department,
	Salary,
	SUM(Salary) OVER(PARTITION BY Department ORDER BY Salary) AS RunTotal
FROM Employees1;


-- 20. Find the Total Salary of Each Department Without GROUP BY

SELECT DISTINCT
	Department,
	SUM(Salary) OVER(PARTITION BY Department) AS TotalSal
FROM Employees1;


-- 21. Calculate the Average Salary in Each Department Without GROUP BY

SELECT DISTINCT
	Department,
	AVG(Salary) OVER(PARTITION BY Department) AS AvgSal
FROM Employees1;


-- 22. Find the Difference Between an Employee’s Salary and Their Department’s Average

SELECT
	Name,
	Department,
	Salary,
	AVG(Salary) OVER(PARTITION BY Department) AS DepAvgSal,
	Salary - AVG(Salary) OVER(PARTITION BY Department) AS Diff
FROM Employees1;

-- 23. Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT
	Name,
	Salary,
	AVG(Salary) OVER(ORDER BY (SELECT NULL) ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovAvg3
FROM Employees1;

-- 24. Find the Sum of Salaries for the Last 3 Hired Employees

WITH TOP3 AS (
SELECT TOP 3
	Name,
	HireDate,
	Salary
FROM Employees1
ORDER BY HireDate DESC)

SELECT
	*,
	SUM(Salary) OVER() AS TotalSalLast3
FROM TOP3; 