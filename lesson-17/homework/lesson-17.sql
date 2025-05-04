-- 1.

SELECT 
	r2.Region, 
	r2.Distributor,
	COALESCE(r.Sales, 0)
FROM
	(SELECT DISTINCT r1.Region, t.Distributor FROM #RegionSales AS r1
	CROSS JOIN
	(SELECT DISTINCT Distributor FROM #RegionSales)AS t) AS r2
LEFT JOIN #RegionSales AS r
ON CONCAT(r2.Region, '', r2.Distributor) = CONCAT(r.Region, '', r.Distributor)

-- 2.

WITH CTE AS (
SELECT 
	m.id AS MangerID,
	m.name AS ManagerName,
	COUNT(e.id) AS NumOfEmployees
FROM Employee AS e
JOIN Employee AS m
	ON e.managerId = m.id
GROUP BY m.id, m.name)
SELECT
	ManagerName
FROM CTE
WHERE NumOfEmployees >= 5;

-- 3.

WITH SalesFeb AS (
SELECT
	product_id,
	unit,
	order_date
FROM Orders
WHERE order_date BETWEEN '2020-02-01' AND EOMONTH('2020-02-01'))

SELECT
	p.product_name,
	SUM(s.unit) AS Total_unit
FROM SalesFeb AS s
JOIN Products AS p
	ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.unit) >= 100;


-- 4.

WITH MaxOrder AS (
SELECT 
	CustomerID,
	SUM(Count) AS totalorder,
	Vendor
FROM Orders
GROUP BY CustomerID, Vendor)
, MaxCust AS (
SELECT 
	CustomerID,
	MAX(totalorder) AS TotalOrder
FROM MaxOrder
GROUP bY CustomerID
)
SELECT
	m.CustomerID,
	m.Vendor
FROM MaxOrder AS m
JOIN MaxCust AS c
	ON m.CustomerID = c.CustomerID AND m.totalorder = c.TotalOrder
ORDER BY CustomerID;

-- 5.

DECLARE @Check_Prime INT = 91;
DECLARE @IsPrime BIT = 1;
DECLARE @divider INT = 2;

BEGIN

	WHILE @divider <= SQRT(@Check_Prime)
	BEGIN 
		IF @Check_Prime % @divider = 0
		BEGIN
			SET @IsPrime = 0;
			BREAK;
		END
		SET @divider = @divider + 1
	END
END
IF @IsPrime = 1
BEGIN
	PRINT 'This number is prime';
END
ELSE
BEGIN
	PRINT 'This number is not prime';
END;

-- 6.

WITH MostSig AS (
SELECT
	Device_id,
	COUNT(*) AS NumOfSig,
	Locations
FROM Device
GROUP BY Device_id, Locations)
, MaxSigLoc AS (
SELECT
	Device_id,
	MAX(NumOfSig) AS MaxSig
FROM MostSig
GROUP BY Device_id)
, MaxSigDev AS (
SELECT
	Device_id,
	SUM(NumOfSig) AS TotalSig
FROM MostSig
GROUP BY Device_id)

SELECT
	ml.Device_id,
	(SELECT COUNT(*) FROM MaxSigLoc) AS no_of_locations,
	m.Locations AS max_sig_locations,
	md.TotalSig AS no_of_signals
FROM MaxSigLoc AS ml
JOIN MostSig AS m
	ON ml.Device_id = m.Device_id AND ml.MaxSig = m.NumOfSig
JOIN MaxSigDev AS md
	ON m.Device_id = md.Device_id;

-- 7.

WITH DepAvg AS (
SELECT
	DeptID,
	AVG(Salary) AS AvgSal
FROM Employee
GROUP BY DeptID)
SELECT
	e.EmpID,
	e.EmpName,
	e.Salary
FROM Employee AS e
JOIN DepAvg AS d
	ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSal;

-- 8.

WITH Checking AS (
SELECT 
	TicketID,
	Number
FROM Tickets
WHERE Number IN (25, 45, 78))
, Wincount AS (
SELECT
	TicketID,
	CASE WHEN COUNT(Number) = 3 THEN 100 
		ELSE 10 
	END AS WinMoney
FROM Checking
GROUP BY TicketID)
SELECT
	SUM(WinMoney) AS TotalWinMoney
FROM Wincount;

-- 9.

;WITH UserPlatforms AS (
    SELECT
        Spend_date,
		User_id,
		STRING_AGG(platform, ',') AS platforms,
		SUM(Amount) AS TotalSpent
    FROM Spending
    GROUP BY Spend_date, user_id
),
CategorizedUsers AS (
    SELECT
        Spend_date,
        user_id,
        CASE 
            WHEN Platforms = 'mobile' THEN 'Mobile Only'
            WHEN Platforms = 'desktop' THEN 'Desktop Only'
            WHEN Platforms = 'mobile,desktop' OR Platforms = 'desktop,mobile' THEN 'Both'
        END AS PlatformCategory,
        TotalSpent
    FROM UserPlatforms
)
SELECT
    Spend_date,
    PlatformCategory AS Platform,
    COUNT(user_id) AS User_num,
    SUM(TotalSpent) AS Total_amount
FROM CategorizedUsers
GROUP BY Spend_date, PlatformCategory
ORDER BY Spend_date, PlatformCategory;

-- 10.

WITH CTE AS (
SELECT
	Product,
	Quantity,
	1 AS Num
FROM tools
UNION ALL
SELECT
	Product,
	Quantity,
	Num + 1 AS Num
FROM CTE
WHERE Num + 1 <= Quantity)

SELECT Product, 1 AS Quantity FROM CTE ORDER BY Product;