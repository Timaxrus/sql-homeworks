-- 1.

CREATE PROCEDURE dbo.udp_EmployeeBonus
AS
BEGIN
	
	CREATE TABLE #EmployeeBonus (
    	EmployeeID INT,
     	FullName VARCHAR(50),
      	Department VARCHAR(50),
      	Salary FLOAT,
      	BonusAmount DECIMAL(7,2));
  
  INSERT INTO #EmployeeBonus
  SELECT
      e.EmployeeID,
      CONCAT(e.FirstName,  ' ', e.LastName) AS FullName,
      e.Department,
      e.Salary,
      CAST(e.Salary * b.BonusPercentage / 100 AS DECIMAL(7,2)) as BonusAmount
  FROM Employees AS e
  JOIN DepartmentBonus AS b
      ON e.Department = b.Department;

	SELECT * FROM #EmployeeBonus;
END;

EXEC dbo.udp_EmployeeBonus;

-- 2.

CREATE OR ALTER PROCEDURE dbo.udp_UpdatedSalary @Dep VARCHAR(50), @bonus FLOAT
AS
BEGIN

	SELECT
    	CONCAT(FirstName, ' ', LastName) AS FullName,
        Department,
        Salary AS OldSalary,
        (Salary * @bonus / 100) + Salary AS NewSalary
    FROM Employees
    WHERE Department = @Dep;

END;

EXEC dbo.udp_UpdatedSalary @Dep ='HR', @bonus = 10;

-- 3.

MERGE INTO Products_Current AS TARGET
USING Products_New AS Source
	ON TARGET.ProductID = SOURCE.ProductID
WHEN MATCHED THEN
	UPDATE SEt TARGET.ProductName = SOURCE.ProductName,
    		   TARGET.Price = SOURCE.Price
WHEN NOT MATCHED BY TARGET THEN
	INSERT (ProductID, ProductName, Price)
    VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Price)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE;


SELECT * FROM Products_Current;

-- 4.

SELECT
	id,
    CASE WHEN p_id IS NULL THEN 'Root'
    	WHEN id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree;

-- 5.

WITH Confirm AS (
SELECT
	s.user_id,
    c.action,
    COUNT(action) AS byType
FROM Signups AS s
LEFT JOIN Confirmations AS c
	on s.user_id = c.user_id
Group by s.user_id, c.action
HAVING c.action = 'confirmed'
)
, OverAll AS (
SELECT
	s.user_id,
  	COUNT(c.action) AS Total
FROM Signups AS s
LEFT JOIN Confirmations AS c
	on s.user_id = c.user_id
Group by s.user_id
)
SELECT
	o.user_id,
    COALESCE(CAST(c.byType AS FLOAT) / NULLIF(CAST(o.Total AS FLOAT), 0), 0) AS rate
FROM Confirm AS c
RIGHT JOIN OverAll AS o
	on c.user_id = o.user_id;

-- 6. 

SELECT
	name,
    salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM Employees);

-- 7.

CREATE PROCEDURE dbo.udp_GetProductSalesSummary @ProdID INT
AS
BEGIN
  SELECT DISTINCT
      p.ProductName,
      SUM(s.Quantity)  OVER(PARTITION BY p.ProductName) AS TotalQuantity,
      SUM(s.Quantity) OVER(PARTITION BY p.ProductName) * p.Price AS TotalSalesAmount,
      FIRST_VALUE(s.SaleDate) OVER(PARTITION BY p.ProductName ORDER BY s.SaleDate) AS FirstSaleDate,
      LAST_VALUE(s.SaleDate) OVER(PARTITION BY p.ProductName ORDER BY s.SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FirstSaleDate
  FROM Products AS p
  LEFT JOIN Sales AS s
      ON p.ProductID = s.ProductID
  WHERE p.ProductID = @ProdID;
END;

EXEC dbo.udp_GetProductSalesSummary @ProdID = 1;
