-- Easy Tasks

-- 1.

WITH Numbers AS 
(
SELECT 1 AS Number
UNION ALL
SELECT Number + 1
FROM Numbers
WHERE Number < 1000
)
SELECT Number FROM Numbers
OPTION (MAXRECURSION 1000) ;

-- 2. 

SELECT
	e.FirstName,
    e.LastName,
    s.totalSales
FROM Employees AS e
JOIN
(SELECT
	EmployeeID,
    SUM(SalesAmount) AS totalSales
FROM Sales
GROUP BY EmployeeID) AS s
	ON e.EmployeeID = s.EmployeeID;

-- 3.

WITH AvgSal AS (
SELECT
	AVG(Salary) AS AvgSalary
FROM Employees)
SELECT * FROM AvgSal;

-- 4. 

SELECT
	p.ProductName,
	s.HighestSales
FROM Products AS p
JOIN (SELECT 
		ProductID, 
		MAX(SalesAmount) AS HighestSales 
		FROM Sales 
		GROUP BY ProductID) AS s
	ON p.ProductID = s.ProductID;

-- 5. 

WITH doub AS (
SELECT
	1 AS Num
UNION ALL
	SELECT Num * 2 AS Num
FROM doub
WHERE Num * 2 < 1000000)
SELECT Num FROM doub;

-- 6. 

WITH SalesCNT AS (
SELECT
		EmployeeID,
		COUNT(SalesID) AS SalesCount
		FROM Sales
		GROUP BY EmployeeID)
SELECT
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	s.SalesCount
FROM SalesCNT AS s
JOIN Employees AS e
	ON s.EmployeeID = e.EmployeeID
WHERE s.SalesCount > 5;


-- 7.

WITH Saless AS (
SELECT
	ProductID,
	SalesAmount
FROM Sales
WHERE SalesAmount > 500)
SELECT
	p.ProductName,
	s.SalesAmount
FROM Products AS p
JOIN Saless AS s
	ON p.ProductID = s.ProductID;

-- 8. 

WITH EmpSal AS (
SELECT
	EmployeeID,
	CONCAT(FirstName, ' ', LastName) AS EmployeeName,
	Salary
FROM Employees) 
, AvgSal AS (
SELECT
	AVG(Salary) AS AvgSalary
FROM EmpSal)
SELECT
	e.EmployeeName,
	e.Salary,
	a.AvgSalary
FROM EmpSal AS e, AvgSal AS a
WHERE e.Salary > a.AvgSalary;


-- Medium Task

-- 1.

SELECT 
	p.ProductName,
	s.NumProd
FROM Products AS p
CROSS APPLY
	(SELECT
		COUNT(*) AS NumProd
	 FROM Sales AS s
	 WHERE p.ProductID = s.ProductID) AS s;

-- 10.

WITH Sellers AS (
SELECT
	EmployeeID,
	COUNT(*) AS SalesCount
FROM Sales
GROUP BY EmployeeID)
SELECT
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
FROM Employees AS e
LEFT JOIN Sellers AS s
ON e.EmployeeID = s.EmployeeID
WHERE s.EmployeeID IS NULL




-- 1.

SELECT TOP 5
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    s.NumOfOrders
FROM Employees AS e
JOIN (
    SELECT
        EmployeeID,
        COUNT(*) AS NumOfOrders
    FROM Sales
    GROUP BY EmployeeID
) AS s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.NumOfOrders DESC;




-- 2.

SELECT
	p.CategoryID,
	SUM(s.TotalSales) AS TotalSales
FROM Products AS p
JOIN (SELECT
		ProductID,
		SUM(SalesAmount) AS TotalSales
FROM Sales AS s
GROUP BY ProductID) AS s
	ON p.ProductID = s.ProductID
GROUP BY p.CategoryID;


-- 3.

WITH Factorial AS (
    SELECT
        Number,
		CAST(1 AS bigint) AS fact,
		1 AS curValue
	FROM Numbers1
    UNION ALL
    SELECT 
        f.Number,
		f.fact * (f.curValue + 1) AS fact,
        f.curValue + 1 AS curValue
    FROM Factorial AS f
    WHERE f.curValue < f.Number
)
SELECT 
    Number,
    MAX(fact) AS Factorial
FROM Factorial
GROUP BY Number
ORDER BY Number;

-- 4. 

WITH RecursiveStringSplit AS (
    
	SELECT 
		String,
		CAST(SUBSTRING(String, 1, 1) AS VARCHAR(MAX)) AS Character,
		CAST(SUBSTRING(String, 2, LEN(String) - 1) AS VARCHAR(MAX)) AS RemainingString 
	FROM Example
	WHERE LEN(String) > 0 
	UNION ALL
    
	SELECT 
		String,
		CAST(SUBSTRING(RemainingString, 1, 1) AS VARCHAR(MAX)) AS Character, 
		CAST(SUBSTRING(RemainingString, 2, LEN(RemainingString) - 1) AS VARCHAR(MAX)) AS RemainingString 
	FROM RecursiveStringSplit
	WHERE LEN(RemainingString) > 0 
)
SELECT 
	String,
	Character
FROM RecursiveStringSplit
ORDER BY String;


-- 5.

;WITH CTE AS (
SELECT
	s1.SaleDate,
	MAX(s2.SaleDate) AS PrevDate
FROM Sales s1
JOIN Sales s2
	ON s2.SaleDate < s1.SaleDate
GROUP BY s1.SaleDate)
, CTE2 AS (
SELECT 
	c.PrevDate,
	c.SaleDate,
	s.SalesAmount
FROM CTE AS c
JOIN Sales s
ON c.SaleDate = s.SaleDate)
SELECT
	c2.PrevDate,
	c2.SaleDate,
	c2.SalesAmount AS curSale,
	s.SalesAmount AS prevSale,
	c2.SalesAmount - s.SalesAmount AS Diff
FROM CTE2 AS c2
JOIN Sales AS s
	ON c2.PrevDate = s.SaleDate;


-- 6.


SELECT
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	s.Qtr,
	s.TotalSales
FROM Employees AS e
JOIN (
		SELECT 
			EmployeeID,
			CONCAT(YEAR(SaleDate), ' ', CONCAT('Q', '', DATEPART(QUARTER, SaleDate))) AS Qtr,
			SUM(SalesAMount) AS TotalSales
		FROM Sales
		GROUP BY EmployeeID, CONCAT(YEAR(SaleDate), ' ', CONCAT('Q', '', DATEPART(QUARTER, SaleDate)))
		) AS s
	ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 45000;


-- Difficult task

--1. 

WITH RecursiveFibonacci AS (
    SELECT 
        CAST(0 AS BIGINT) AS n,
        CAST(0 AS BIGINT) AS fib,
        CAST(1 AS BIGINT) AS next_fib
    UNION ALL
    SELECT 
        n + 1 AS n,
        next_fib AS fib,
        fib + next_fib AS next_fib
    FROM RecursiveFibonacci
    WHERE n < 20
)
SELECT 
    n,
    fib AS FibonacciNumber
FROM RecursiveFibonacci;

-- 2.

SELECT
	Id,
	Vals
FROM FindSameCharacters
WHERE LEN(REPLACE(Vals, SUBSTRING(Vals,1,1), '')) = 0
	AND LEN(Vals) > 1;


-- 3.
CREATE OR ALTER FUNCTION dbo.udf_numbers (
    @MyNum INT
)
RETURNS TABLE
AS
RETURN
( WITH CTE AS (
    SELECT 
		1 AS Number,
		CAST(1 AS VARCHAR(MAX)) AS SeqNum
	UNION ALL
	SELECT 
		Number + 1 AS Number,
		CAST(SeqNum + CAST(Number + 1 AS varchar(MAX)) AS varchar(MAX)) AS SeqNum
    FROM CTE
    WHERE Number < @MyNum
	)
	SELECT 
		Number, 
		SeqNum 
	FROM CTE 
);

SELECT * FROM dbo.udf_numbers(5);

-- 4.

SELECT TOP 3
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	s.TotalSales
FROM Employees AS e
JOIN
	(SELECT 
		EmployeeID,
		SUM(SalesAmount) AS TotalSales
	FROM Sales
	WHERE SaleDate > DATEADD(MONTH, -6, (SELECT MAX(SaleDate) FROM Sales))
	GROUP BY EmployeeID) AS s
	ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

-- 5. 


SELECT * FROM RemoveDuplicateIntsFromNames

WITH ProcessedNames AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        CAST(1 AS INT) AS Position,
        SUBSTRING(Pawan_slug_name, 1, 1) AS Character,
        LEN(Pawan_slug_name) AS Length
    FROM RemoveDuplicateIntsFromNames
    UNION ALL
    SELECT 
        PawanName,
        Pawan_slug_name,
        Position + 1,
        SUBSTRING(Pawan_slug_name, Position + 1, 1),
        Length
    FROM ProcessedNames
    WHERE Position < Length
),
FilteredCharacters AS (
    SELECT 
        PawanName,
        Pawan_slug_name,
        Character,
        ROW_NUMBER() OVER (PARTITION BY PawanName, Character ORDER BY Position) AS Occurrence,
        COUNT(*) OVER (PARTITION BY PawanName, Character) AS TotalOccurrences
    FROM ProcessedNames
    WHERE ISNUMERIC(Character) = 1
),
FinalString AS (
    SELECT 
     WITH ProcessedNames AS (
    -- Step 1: Split the string into individual characters
    SELECT 
        PawanName,
        Pawan_slug_name,
        CAST(1 AS INT) AS Position,
        SUBSTRING(Pawan_slug_name, 1, 1) AS Character,
        LEN(Pawan_slug_name) AS Length
    FROM RemoveDuplicateIntsFromNames
    UNION ALL
    SELECT 
        PawanName,
        Pawan_slug_name,
        Position + 1,
        SUBSTRING(Pawan_slug_name, Position + 1, 1),
        Length
    FROM ProcessedNames
    WHERE Position < Length
),
FilteredCharacters AS (
    -- Step 2: Filter out duplicate integers and single integers
    SELECT 
        PawanName,
        Pawan_slug_name,
        Character,
        ROW_NUMBER() OVER (PARTITION BY PawanName, Character ORDER BY Position) AS Occurrence,
        COUNT(*) OVER (PARTITION BY PawanName, Character) AS TotalOccurrences
    FROM ProcessedNames
    WHERE TRY_CAST(Character AS INT) IS NOT NULL -- Only consider numeric characters
),
FinalString AS (
    -- Step 3: Reconstruct the string without duplicate or single integers
    SELECT 
        p.PawanName,
        p.Pawan_slug_name,
        STRING_AGG(CASE 
                      WHEN f.Character IS NOT NULL THEN '' -- Exclude filtered characters
                      ELSE c.Character 
                   END, '') WITHIN GROUP (ORDER BY c.Position) AS CleanedName
    FROM ProcessedNames c
    LEFT JOIN FilteredCharacters f
        ON c.PawanName = f.PawanName AND c.Character = f.Character
    WHERE f.Occurrence > 1 OR f.TotalOccurrences = 1
    GROUP BY p.PawanName, p.Pawan_slug_name
)
-- Step 4: Display the cleaned names
SELECT 
    PawanName,
    CleanedName
FROM FinalString;