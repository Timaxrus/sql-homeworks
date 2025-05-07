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
