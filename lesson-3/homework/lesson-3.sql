-- Easy-Level Tasks (10)

USE test

-- 1. Define and explain the purpose of BULK INSERT in SQL Server.

BULK INSERT is a T-SQL command used to efficiently import large volumes of data from a data file into a SQL Server table.
It is optimized for high-speed data loading and is commonly used in ETL (Extract, Transform, Load) processes,
data migrations, and batch operations.


--2. List four file formats that can be imported into SQL Server.

1. CSV (Comma-Separated Values)
Description: Plain text where values are separated by commas (,).

Best for: Tabular data exchange (e.g., Excel exports, log files).

2. TXT (Fixed-Width or Delimited Text)
Description: Plain text with fixed column widths or custom delimiters (e.g., |, tab).

Best for: Legacy systems or structured reports.

3. XML (Extensible Markup Language)
Description: Hierarchical data format with tags.

Best for: Nested or semi-structured data.

4. JSON (JavaScript Object Notation)
Description: Lightweight key-value pair format.

Best for: Web APIs and NoSQL data.

--3. Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL    -- Drop table Products if exists
    DROP TABLE dbo.Products;

CREATE TABLE Products 
	(ProductID INT PRIMARY KEY, 
	ProductName VARCHAR(50), 
	Price DECIMAL(10,2));

--4. Insert three records into the Products table using INSERT INTO.

TRUNCATE TABLE Products; -- Truncates table Products before inserting data


INSERT INTO Products VALUES    -- Inserting 3 rows into Products
	(1, 'bike', 15000),
	(2, 'helmet', 5000),
	(3, 'socks', 200);

-- 5. Explain the difference between NULL and NOT NULL with examples.

1. NULL represents missing/unknown data. NULL is not equal to NULL. Uses an extra byte (NULL bitmap)
NULL = NULL returns NULL (not TRUE). NULL values are generally excluded from indexes.
Default for columns if not specified. NULL values are ignored with aggregation functions.

CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), StartDate DATE, TerminationDate DATE);

INSERT INTO Employees VALUES 
	(1, 'Robert', '2020-10-13', '2023-05-23'),
	(2, 'Lucy', '2024-12-04', NULL),
	(3, 'Daniel', '2025-01-23', NULL);

-- NULL comparison returns UNKNOWN (not FALSE)
SELECT * FROM Employees WHERE TerminationDate = NULL; -- Returns 0 rows

-- Correct NULL check
SELECT * FROM Employees WHERE TerminationDate IS NULL;  -- Returns NULL values

2. NOT NULL specifies that a column must contain a value. No extra storage overhead. 
Normal comparison behavior. All values included in indexes. Must be explicitly declared.

TRUNCATE TABLE Employees;

ALTER TABLE Employees 
ADD Email VARCHAR(50) NOT NULL;     -- Email column should not be empty

INSERT INTO Employees VALUES 
	(1, 'Robert', '2020-10-13', '2023-05-23', 'robert@sample.com'),
	(2, 'Lucy', '2024-12-04', NULL, 'lucy@sample.com'),
	(3, 'Daniel', '2025-01-23', NULL, NULL);    -- Here beacuse of this part the query gives an error as the email column cannot be null.

INSERT INTO Employees VALUES 
	(1, 'Robert', '2020-10-13', '2023-05-23', 'robert@sample.com'),
	(2, 'Lucy', '2024-12-04', NULL, 'lucy@sample.com'),
	(3, 'Daniel', '2025-01-23', NULL, 'daniel@sample.com');   -- Now the insert the 3 rows are added.

SELECT 
	TABLE_NAME, 
	COLUMN_NAME, 
	DATA_TYPE, 
	IS_NULLABLE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employees' AND IS_NULLABLE = 'NO';        -- Query returns columns with NOT NULL constraint


-- 6. Add a UNIQUE constraint to the ProductName column in the Products table.

ALTER TABLE Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE (ProductName);  -- Added UNIQUE constraint "UQ_Products_ProductName" to ProductName column

-- 7. Write a comment in a SQL query explaining its purpose.

/*
Purpose: Identify the employees whose contracts terminated in 2023
*/

SELECT 
*                    -- Selects all the columns from Employees table
FROM Employees
WHERE YEAR(TerminationDate) = '2023';     -- Filter out TerminationDate column equal to 2023


-- 8. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.

CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50) UNIQUE)  -- Simple column-level UNIQUE constraint


-- 9. Explain the purpose of the IDENTITY column in SQL Server.

An IDENTITY column in SQL Server is an auto-incrementing numeric column that 
automatically generates sequential values when new rows are inserted. 
It is commonly used for primary keys and ensures unique values without manual input.

Key Features of IDENTITY Columns

1. Auto-Generated Values
	- SQL Server automatically assigns the next number in the sequence.
	- No need to manually specify values during INSERT.
2. Configurable Start & Increment
	- Defined as IDENTITY(seed, increment)
		- Seed = Starting value (default: 1)
		- Increment = Step size (default: 1)
3. Unique by Default
	- Typically used with PRIMARY KEY or UNIQUE constraints.

4. Not Nullable
	- An IDENTITY column cannot be NULL.


-- Medium-Level Tasks (10)

-- 10. Use BULK INSERT to import data from a text file into the Products table.

TRUNCATE TABLE Products

BULK INSERT Products
FROM 'D:\Data Analytics_BI analyst\Source files\Prod.txt'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,            -- Skip header
    FIELDTERMINATOR = ',',   -- Comma-delimited
    ROWTERMINATOR = '\n',    -- Linux line ending
    TABLOCK                -- Improves performance
    );

	SELECT * FROM Products         -- To confirm that all the rows imported correctly


-- 11. Create a FOREIGN KEY in the Products table that references the Categories table.

-- a. Add the CategoryID column to Products
ALTER TABLE Products
ADD CategoryID INT NULL;

-- b. Create the foreign key relationship
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);


-- 12. Explain the differences between PRIMARY KEY and UNIQUE KEY with examples.


Feature	             PRIMARY KEY	                   UNIQUE KEY
______________________________________________________________________________________________
Null Values	     | Does not allow NULL values        | Allows one NULL value (per column)
_________________|___________________________________|_________________________________________
Number per Table | Only one per table	             | Multiple allowed per table
_________________|___________________________________|_________________________________________
Purpose	         | Identifies each row uniquely      | Ensures no duplicate values
_________________|___________________________________|_________________________________________
Clustered Index	 | Creates clustered index by default| Creates non-clustered index by default
_________________|___________________________________|_________________________________________
Foreign Key      | Can be referenced by foreign keys | Can also be referenced by foreign keys
_________________|___________________________________|_________________________________________
Auto-increment	 | Often used with IDENTITY	         |Does not imply auto-increment
_________________|___________________________________|_________________________________________

SELECT * FROM Employees
-- 13. Add a CHECK constraint to the Products table ensuring Price > 0.
-- 14. Modify the Products table to add a column Stock (INT, NOT NULL).
-- 15. Use the ISNULL function to replace NULL values in a column with a default value.
-- 16. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
🔴 Hard-Level Tasks (10)
Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
Create a table with an IDENTITY column starting at 100 and incrementing by 10.
Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
Explain with examples the use of COALESCE and ISNULL functions for handling NULL values.
Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
