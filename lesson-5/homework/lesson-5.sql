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
FROM Customers
  
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

Medium-Level Tasks

    Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
    Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
    Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
    Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
    Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5

Hard-Level Tasks

    Use INTERSECT to show products that are common between Products and Products_Discounted tables.
    Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
    Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
    Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show customerid, quantity and discount percentage. The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7%
