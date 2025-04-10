-- Easy-Level Tasks

-- 1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.

SELECT 
    ProductName AS Name                              -- ProductName column aliased as "Name".
FROM Products
ORDER BY Name;                                     -- Aliased column named reused in ORDER BY clause.


-- 2. Write a query that uses an alias to rename the Customers table as Client for easier reference.

SELECT 
    Client.FirstName,
    Client.LastName,
    Client.Email
FROM Customers AS Client;                                -- Customer table aliased as "Client".

  
-- 3. Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.

SELECT 
    ISNULL(ProductName, 'Unknown') AS ProductName, 'Regular' AS ProductType                          -- Selecting ProductName and handling NULL values if exist and aliasing them as ProductName, and 'Regular' as ProductType for products from Products table.
FROM Products
UNION                                                                                                -- UNION combines results from both tables, without handling duplicates.
SELECT 
    ISNULL(ProductName, 'Unknown'), 'Discounted'                                                     -- Selecting ProductName and handling NULL values if exist and aliasing them as ProductName, and 'Discounted' as ProductType for products from Products_Discounted table.
FROM Products_Discounted
ORDER BY ProductType, ProductName;                                                                   -- Sorting the products by product type first to see the border line for each table and product name 


-- 4. Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.

SELECT ProductID
FROM Products 
INTERSECT                                                                                              -- INTERSECT uses only matching columns, so the only column that matches is ProductID
SELECT ProductID
FROM Products_Discounted;

  
-- 5. Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.

SELECT DISTINCT                                                                                        -- Selecting unique customer names and country in combination, using CONCAT_WS for FirtName and LastName. By this we make sure no customer is dropped out by DISTINCT
   CONCAT_WS(' ', FirstName, LastName) AS FullName,
   Country
FROM Customers;
  
-- 6. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.

SELECT 
    ProductName,
    Price,
    CASE WHEN Price > 1000 THEN 'High'                                                                -- Set 'High' if the price is higher than 1000, else set 'Low'.
    	 ELSE 'Low'
    END AS PriceSegment                                                                               -- Name the CASE WHEN statement as 'PriceSegment'
FROM Products
ORDER BY Price DESC;                                                                                  -- Sort the products by their prices from higher to lower to see higher priced products on top.


-- 7. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).

SELECT
	ProductName,
	IIF(StockQuantity > 100, 'Yes', 'No') AS QTY_MoreThan100                                      -- Shorthand conditional checking if qty is more than 100 pcs. Assigning 'Yes', if yes, 'No', if no.
FROM Products_Discounted;

-- Medium-Level Tasks

-- 8. Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.

SELECT 
    ISNULL(ProductName, 'Unknown') AS ProductName, 'Regular' AS ProductType                          -- Selecting ProductName and handling NULL values if exist and aliasing them as ProductName, and 'Regular' as ProductType for products from Products table.
FROM Products
UNION                                                                                                -- UNION combines results from both tables, without handling duplicates.
SELECT 
    ISNULL(ProductName, 'Unknown'), 'OutOfStock'                                                     -- Selecting ProductName and handling NULL values if exist and aliasing them as ProductName, and 'OutOfStock' as ProductType for products from OutOfStock table.
FROM OutOfStock
ORDER BY ProductType, ProductName;  


-- 9. Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.

SELECT 
    ProductID,                                                                                     -- Selecting ProductID and ProdcutName that differs from the other table in combination.
    ISNULL(ProductName, 'Unknown') AS ProductName                                                  -- Handling the NULL value in ProductName and aliasing it.
FROM Products
EXCEPT                                                                                              -- Selecting the products from Products table that do not match with those from Products_Discounted table. Here we are focusing on matching rule of two columns in combination (ProductID, ProductName). 
SELECT 
    ProductID, 
    ISNULL(ProductName, 'Unknown') AS ProductName
FROM Products_Discounted;


-- 10. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.

SELECT 
    ProductName,
    Price,
    IIF(Price > 1000, 'Expensinve', 'Affordable') AS PriceSegment                                  -- Shorthand IIF for segmenting the price 'Expensive' if it is > 1000 else 'Affordable'.
FROM Products;


-- 11. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.

SELECT
    ISNULL(FirstName, 'Not given') AS FirstName,                                                 -- Selecting FirstName replacing NULL values to 'Not given'.
    ISNULL(LastName, 'Not given') AS LastName,                                                   -- Selecting LastName replacing NULL values to 'Not given'.
    DepartmentName,
    Age,
    Salary
FROM Employees
WHERE Age < 25 or Salary > 60000;                                                               -- Filtering employees who are older than 25 or have salary more than 60000.


-- 12. Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5

SELECT
    ISNULL(FirstName, 'Not given') AS FirstName,                                                 -- Selecting FirstName replacing NULL values to 'Not given'.
    ISNULL(LastName, 'Not given') AS LastName,                                                   -- Selecting LastName replacing NULL values to 'Not given'.
    DepartmentName,
    Age,
    Salary,
    CASE WHEN DepartmentName = 'HR' OR EmployeeID = 5 THEN Salary + Salary * 0.1                -- Giving condition of cases when department is HR or employee id is 5 then increase the salary to 10% and alias it as 'SalaryIncrease'.
         ELSE salary
    END AS SalaryIncrease
FROM Employees
WHERE DepartmentName = 'HR' OR EmployeeID = 5;                                                  -- Filtering the employees with salary increase only.

-- Hard-Level Tasks

-- 13. Use INTERSECT to show products that are common between Products and Products_Discounted tables.

WITH CommonIDs AS (                                                                             -- First we want to see the intersection between 2 tables using the ID column from both tables, other columns may not match. And we put them in a CTE later to be able to use for further analysis.
SELECT ProductID FROM Products
INTERSECT
SELECT ProductID FROM Products_Discounted)

SELECT                                                                                 
    c.ProductID,                                                                               -- Selecting the ProductID from Commons CTE.
    p.ProductName AS Product_Regular,                                                          -- Selecting product name from Products table. We want to see the how the product named in Products table
    d.ProductName AS Product_Discounted                                                        -- Selecting product nmae from Products_Discounted table. We want to see the how the product named in Products_Discounted table
FROM Commons c
INNER JOIN Products p                                                                          -- Joining the CTE with Products table. We want to know the names of the products from this table.
ON c.ProductID = p.ProductID                                                                   -- Joining them on ProductID that matches
INNER JOIN Products_Discounted d                                                               -- Joining the CTE with Products_Discounted table as well. We want to see the product names from this table as well.
ON c.ProductID = d.ProductID;         


-- 14. Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)

SELECT
    SaleID,                                                                                 -- When segmenting the sales amount, we want to see the sales ID, sales date and sales amount itself.
    SaleDate,
    SaleAmount,
    CASE WHEN SaleAmount > 500 THEN 'Top Tier'                                              -- Setting 'Top Tier' when the sales amount is more than 500.
         WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'                                -- Setting 'Mid Tier' when the sales amount is between 200 and 500.
         ELSE 'Low Tier'                                                                    -- Setting 'Low Tier' in all other cases.
    END AS SalesSegmentation                                                                -- Aliasing it as 'SalesSegmentation'.
FROM Sales;


-- 15. Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.

WITH OrderWithoutInvoice AS (                                                             -- First we want to see the difference of Orders table from Invoices table using the ID column from both tables, other columns may not match. And we put them in a CTE later to be able to use for further analysis.
SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID 
FROM Invoices)

SELECT                                                                                 -- We want to see the FirstName, LastName and the coutry of the customer using CTE left joining with Customers table on customer id.
    o.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country
FRoM OrderWithoutInvoice o 
LEFT JOIN Customers c 
ON o.CustomerID = c.CustomerID;


-- 16. Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%

SELECT 
    CustomerID, 
    Quantity,
    CASE WHEN Quantity = 1 THEN '3%'                                                   -- Conditional case 1 for setting 3% discount if the quantity ordered is eqaul to 1.
         WHEN Quantity IN (2,3) THEN '5%'                                              -- Conditional case 2 for setting 5% discount if the quantity ordered is either 2 or 3.
         ELSE '7%'                                                                     -- Conditional case 3 for setting 7% in all other cases.
    END AS DiscountPercentage
FROM Orders;
