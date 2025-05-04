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