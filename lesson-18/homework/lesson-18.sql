-- 1.
IF OBJECT_ID('tempdb..#MonthlySales') IS NOT NULL
BEGIN
    DROP TABLE #MonthlySales;
END;

WITH CurMonSale AS (
SELECT
	s.ProductID,
	s.Quantity,
	s.Quantity * p.Price AS TotalRevenue,
	s.SaleDate
FROM Sales AS s
JOIN Products AS p
	ON s.ProductID = p.ProductID
WHERE s.SaleDate BETWEEN DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
						AND EOMONTH(GETDATE())
)
SELECT
	ProductID,
	SUM(Quantity) AS TotalQuantity,
	SUM(TotalRevenue) AS TotalRevenue
INTO #MonthlySales
FROM CurMonSale
GROUP BY ProductID;

SELECT * FROM #MonthlySales;

-- 2.

CREATE VIEW vw_ProductSalesSummary AS
SELECT
	p.ProductID,
	p.ProductName,
	p.Category,
	SUM(s.Quantity) AS TotalQuantitySold
FROM Products AS p
JOIN Sales AS s
	ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

SELECT * FROM vw_ProductSalesSummary;

-- 3.

CREATE OR ALTER FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
	DECLARE @Result DECIMAL(18, 2);
	
	WITH TotalRev AS(
	SELECT
		p.ProductID,
		SUM(s.Quantity) * p.Price AS TotalRevenue
	FROM Products AS p
	JOIN Sales AS s
		ON p.ProductID = s.ProductID
	GROUP BY p.ProductID, p.Price)
	SELECT
		@Result = TotalRevenue
	FROM TotalRev
	WHERE ProductID = @ProductID;

	RETURN COALESCE(@Result, 0);

END;

SELECT dbo.fn_GetTotalRevenueForProduct(0) AS TotatRevenue;

-- 4.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
	(SELECT
		p.ProductName,
		SUM(s.Quantity) AS TotalQuantity,
		p.Price * SUM(s.Quantity) AS TotalRevenue
	FROM Products AS p
	JOIN Sales AS s
		ON p.ProductID = s.ProductID
	GROUP BY p.ProductName, p.Category, p.Price
	HAVING p.Category = @Category
	);

SELECT * FROM fn_GetSalesByCategory('Clothing')

-- 5.

CREATE OR ALTER function dbo.fn_IsPrime (@Number INT)
Returns VARCHAR(50)
AS
BEGIN
	DECLARE @Result VARCHAR(50);
	DECLARE @i INT = 2;
	DECLARE @IsPrime BIT = 1;
	
	IF @Number <= 1
	BEGIN
		SET @Result = 'No';
	END
	ELSE
	BEGIN

		WHILE @i <= SQRT(@Number)
		BEGIN
			IF @Number % @i = 0
			BEGIN
				SET @IsPrime = 0;
				BREAK;
			END
			SET @i = @i + 1;
		END
		IF @IsPrime = 1
			SET @Result = 'Yes';
		ELSE
			SET @Result = 'No';
	END
	RETURN @Result;

END;

SELECT dbo.fn_IsPrime(9) AS IsPrime;

-- 6.

Create function dbo.fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS TABLE
AS
RETURN 
	(
		WITH SeqNum AS (
			SELECT
				@Start AS Num
			UNION ALL
			SELECT
				Num + 1 AS Num
			FROM SeqNum
			WHERE Num + 1 <= @End
		)
			SELECT Num FROM SeqNum
	);

SELECT * FROM dbo.fn_GetNumbersBetween(2, 15);

-- 7.

CREATE OR ALTER FUNCTION dbo.udf_getHighestSalary(@rnk INT)
RETURNS TABLE
AS
RETURN
(
WITH RnkSal AS(
SELECT
	id,
	salary,
	ROW_NUMBER() OVER(ORDER BY salary DESC) AS RNK
FROM Employee
)
SELECT DISTINCT
	salary AS HighestNSalary
FROM RnkSal
WHERE RNK = @rnk
UNION ALL
SELECT
	NULL AS HighestNSalary
WHERE NOT EXISTS (SELECT 1 FROM RnkSal WHERE RNK = @rnk)
);

SELECT * FROM dbo.udf_getHighestSalary(5);


-- 8.

WITH TotalCount AS (
SELECT
	requester_id AS id,
	COUNT(*) Total
FROM Friends
GROUP BY requester_id
UNION
SELECT
	accepter_id AS id,
	COUNT(*)
FROM Friends
GROUP BY accepter_id)

SELECT TOP 1
	id,
	SUM(Total) AS num
FROM TotalCount
GROUP BY id
ORDER BY SUM(Total) DESC;

-- 9.

CREATE VIEW vw_CustomerOrderSummary AS
SELECT DISTINCT
	c.customer_id,
	c.name,
	COUNT(o.order_id) OVER(PARTITION BY c.customer_id) AS total_orders,
	SUM(o.amount) OVER(PARTITION BY c.customer_id) AS total_amount,
	LAST_VALUE(o.order_date) OVER(PARTITION BY c.customer_id ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order_date
FROM Customers AS c
JOIN Orders AS o
	ON c.customer_id = o.customer_id;

SELECT * FROM vw_CustomerOrderSummary;

-- 10.

SELECT
    RowNumber,
    MAX(Workflow) OVER (ORDER BY RowNumber ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Workflow
FROM TestTable;

