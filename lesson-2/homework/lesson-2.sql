USE test

-- Basic-Level Tasks (10)

-- 1. Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).

CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2));


-- 2. Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).

-- =====> Single-row insert

INSERT INTO Employees VALUES
	(1, 'John', 20000000);

INSERT INTO Employees VALUES
	(2, 'Tom', 22000000);

INSERT INTO Employees VALUES
	(3, 'Bob', 26000000);

-- =====> Multiple-row insert

INSERT INTO Employees VALUES
	(1, 'John', 20000000),
	(2, 'Tom', 22000000),
	(3, 'Bob', 26000000);

-- 3. Update the Salary of an employee where EmpID = 1.


UPDATE Employees 
	SET Salary = 25000000
WHERE EmpID = 1;


-- 4. Delete a record from the Employees table where EmpID = 2.

DELETE FROM Employees
WHERE EmpID = 2;


-- 5. Demonstrate the difference between DELETE, TRUNCATE, and DROP commands on a test table.

--======================================================
-- Setp 1. Let's create a table called 'Test'

CREATE TABLE Test (TestID INT, TestDate DATE, Result VARCHAR(8))


-- Step 2. Let's insert 3 random rows into the table

INSERT INTO Test VALUES
	(1, '2025.02.24', 'Pass'),
	(2, '2025.03.01', 'Not Done'),
	(3, '2025.03.05', 'Fail');


-- Step 3. Use DELETE to remove a specific row or rows from Test table

DELETE FROM Test WHERE Result = 'Not Done';  -- Delete the row where the result is equal to 'Not done'


-- Step 4. Use TRUNCATE to remove all rows from a table without changing the structure of the table, this command cannot use WHERE clause

TRUNCATE TABLE Test   -- Now the table does not have any data inside, it is empty now, but it still exists


-- Step 5. Use DROP to completely remove a table (or other object) from the database

DROP TABLE Test   -- Test table is completely removed from the database, it does not exist, the space is freed up.

--=========================================================================

-- 6. Modify the Name column in the Employees table to VARCHAR(100).

ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100);


-- 7. Add a new column Department (VARCHAR(50)) to the Employees table.

ALTER TABLE Employees ADD Department VARCHAR(50);


-- 8. Change the data type of the Salary column to FLOAT.

ALTER TABLE Employees ALTER COLUMN Salary FLOAT;


-- 9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));


-- 10. Remove all records from the Employees table without deleting its structure.

TRUNCATE TABLE Employees;


-- Intermediate-Level Tasks (6)

-- 11. Insert five records into the Departments table using INSERT INTO SELECT from an existing table.

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 
	EmpId AS DepartmentId, 
	Department AS DepartmenName
FROM Employees;

SELECT * FROM Departments
-- 12. Update the Department of all employees where Salary > 5000 to 'Management'.

UPDATE Employees SET Department = 'Management'
WHERE Salary > 5000;


-- 13. Write a query that removes all employees but keeps the table structure intact.

TRUNCATE TABLE Employees;


-- 14. Drop the Department column from the Employees table.

ALTER TABLE Employees DROP COLUMN Department;


-- 15. Rename the Employees table to StaffMembers using SQL commands.

EXEC sp_rename 'Employees', 'StaffMembers';


-- 16. Write a query to completely remove the Departments table from the database.

DROP TABLE Departments;