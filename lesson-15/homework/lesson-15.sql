-- 1.

WITH Numbers AS 
(
SELECT 1 AS Number
UNION ALL
SELECT Number + 1
FROM Numbers
WHERE Number < 10
)
SELECT Number FROM Numbers;

-- 2. 

WITH CTE AS 
(
SELECT 1 AS Number
UNION ALL
SELECT Number + Number
FROM CTE
WHERE Number < 20
)
SELECT Number FROM CTE;

-- 3.

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

-- 4. 

WITH AvgSal AS (
SELECT
	AVG(Salary) AS AvgSalary
FROM Employees)
SELECT * FROM AvgSal;

-- 5. 

