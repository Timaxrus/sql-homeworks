-- 🟢 Easy-Level Tasks (10)

-- 1. Write a query to find the minimum (MIN) price of a product in the Products table.

SELECT 
	MIN(Price) AS MinPrice                             -- Minimum price fo a product in the Products table.
FROM Products;


-- 2. Write a query to find the maximum (MAX) Salary from the Employees table.

SELECT 
	MAX(Price) AS MaxPrice                             -- Maximum price fo a product in the Products table.
FROM Products;


-- 3. Write a query to count the number of rows in the Customers table using COUNT(*).

SELECT 
	COUNT(*)                                          -- Count the number of all rows.
FROM Customers;


-- 4. Write a query to count the number of unique product categories (COUNT(DISTINCT Category)) from the Products table.

SELECT 
	COUNT(DISTINCT Category)                            -- Count the unique categories of the products.
FROM Products;


-- 5. Write a query to find the total (SUM) sales amount for the product with id 7 in the Sales table.

SELECT 
	SUM(SaleAmount) AS TotalSale                          -- Total sales amount of a sale with id number 7
FROM Sales
WHERE ProductID = 7;


-- 6. Write a query to calculate the average (AVG) age of employees in the Employees table.

SELECT 
	AVG(Age) AS AverageAge                                -- Average age of all the employees.
FROM Employees;


-- 7. Write a query that uses GROUP BY to count the number of employees in each department.

SELECT
	DepartmentName,
	COUNT(*) AS EmployeeNum                              -- Number of employees in each departnment.
FROM Employees
GROUP BY DepartmentName;


-- 8. Write a query to show the minimum and maximum Price of products grouped by Category. Use products table.

SELECT
	Category,
	MIN(Price) AS MinPrice,                           -- Minimum price by category.
	MAX(Price) AS MaxPrice                            -- Maximum price by category.
FROM Products
GROUP BY Category;


-- 9. Write a query to calculate the total (SUM) sales per Customer in the Sales table.

SELECT
	CustomerID,
	SUM(SaleAmount)                                    -- Total sales amount by customer ID.
FROM Sales
GROUP BY CustomerID;								   -- Group by customer id.


-- 10. Write a query to use HAVING to filter departments having more than 5 employees from the Employees table.(DeptID is enough, if you don't have DeptName).

SELECT
	DepartmentName,
	COUNT(*) AS Employee_Num
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;                                    -- Filter employee number where number more than 5


-- 🟠 Medium-Level Tasks (9)

-- 11. Write a query to calculate the total sales and average sales for each product from the Sales table.

SELECT
	ProductId,
	SUM(SaleAmount) AS TotalSales,                     -- Total sales amount by product
	AVG(SaleAmount) AS AverageSales					   -- Average sales amount by product
FROM Sales
GROUP BY ProductId;                                  


-- 12. Write a query that uses COUNT(columnname) to count the number of employees from the Department HR.

SELECT
	DepartmentName,
	COUNT(DepartmentName) AS Employee_Num               -- Count total number of employees whose departments are HR.
FROM Employees
GROUP BY DepartmentName
HAVING DepartmentName = 'HR';


-- 13. Write a query that finds the highest (MAX) and lowest (MIN) Salary by department in the Employees table.(DeptID is enough, if you don't have DeptName).

SELECT
	DepartmentName,
	MAX(Salary) AS MaxSalary,                         -- Maximum salary by department
	MIN(Salary) AS MinSalary						  -- Minimum salary by department
FROM Employees
GROUP BY DepartmentName


-- 14. Write a query that uses GROUP BY to calculate the average salary per Department.(DeptID is enough, if you don't have DeptName).

SELECT
	DepartmentName,
	AVG(Salary) AS AverageSalary                     -- Average salary by departments.
FROM Employees
GROUP BY DepartmentName;                             -- Group by department

-- 15. Write a query to show the AVG salary and COUNT(*) of employees working in each department.(DeptID is enough, if you don't have DeptName).

SELECT
	DepartmentName,
	COUNT(*) AS EmployeeNum,						  -- Count the number of employees in each department
	AVG(Salary) AS AverageSalary					  -- Average salary of employees in each department
FROM Employees
GROUP BY DepartmentName;							  -- Group by departments 


-- 16. Write a query that uses HAVING to filter product categories with an average price greater than 400.

SELECT 
	Category,
	AVG(Price) AS AveragePrice                         -- Average price of the product category
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;


-- 17. Write a query that calculates the total sales for each year in the Sales table, and use GROUP BY to group them.

SELECT
	YEAR(SaleDate) AS Year,
	SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);


-- 18. Write a query that uses COUNT to show the number of customers who placed at least 3 orders.

SELECT
	CustomerID,
	COUNT(*) AS CustomerNum                        -- Count the number of customers who placed at least 3 orders.
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;


-- 19. Write a query that applies the HAVING clause to filter out Departments with total salary expenses greater than 500,000.(DeptID is enough, if you don't have DeptName).

SELECT 
	DepartmentName,
	SUM(Salary) AS TotalSalary                            -- Total salary expanses by department that's more than 500,000
FROM Employees
GROUP BY DepartmentName
HAVING SUM(Salary) > 500000;


-- 🔴 Hard-Level Tasks (6)

-- 20. Write a query that shows the average (AVG) sales for each product category, and then uses HAVING to filter categories with an average sales amount greater than 200.

SELECT 
	p.Category,                                     -- Selecting category from products table as this does not exist in sales table.
	AVG(s.SaleAmount) AS AverageSales               -- Average sales amount by product category.
FROM Sales s
LEFT JOIN Products p                                -- Joining Sales table with Products table to return the Categor column from Products table.
ON s.ProductID = p.ProductID
GROUP BY p.Category
HAVING AVG(s.SaleAmount) > 200;                      -- Filterign average sales amount more than 200.


-- 21. Write a query to calculate the total (SUM) sales for each Customer, then filter the results using HAVING to include only Customers with total sales over 1500.

SELECT 
	CustomerID,
	SUM(SaleAmount) AS TotalSales                              -- Total sales amount by customer
FROM Sales
GROUP BY CustomerID 
HAVING SUM(SaleAmount) > 1500;								   -- Filter total sales amount that is more than 1500 by each customer.


-- 22. Write a query to find the total (SUM) and average (AVG) salary of employees grouped by department, and use HAVING to include only departments with an average salary greater than 65000.

SELECT 
	DepartmentName,
	AVG(Salary) AS AverageSalary,                          -- Average salary of the employees by department.
	SUM(Salary) AS TotalSalary                             -- Total salary of the employees by department.          
FROM Employees
GROUP BY DepartmentName                                     -- Groupping by department.
HAVING AVG(Salary) > 65000;                                 -- Filtering average salary by department that's more than 65,000


-- 23. Write a query that finds the maximum (MAX) and minimum (MIN) order value for each customer, and then applies HAVING to exclude customers with an order value less than 50.

SELECT
	CustomerID,
	MAX(TotalAmount) AS MaxOrderValue,                 -- Maximum order value by each customer.
	MIN(TotalAmount) AS MinOrderValue                  -- Minimum order value by each customer.
FROM Orders
GROUP BY CustomerID
HAVING MIN(TotalAmount) > 50;                          -- Filter out minimal order values that are less than 50.


-- 24. Write a query that calculates the total sales (SUM) and counts distinct products sold in each month, and then applies HAVING to filter the months with more than 8 products sold.

SELECT 
	MONTH(SaleDate) AS MonthOfSale,                          -- Extracting the month's order number from the date.
	FORMAT(SaleDate, 'MMMM') AS MonthName,                   -- Formatting the date to name the month.
	SUM(SaleAmount) AS TotalSale,                            -- Total sales by month.
	COUNT(DISTINCT ProductId) AS Product                     -- Counting the unique products sold by month
FROM Sales
GROUP BY MONTH(SaleDate), FORMAT(SaleDate, 'MMMM')            -- Group by months.
HAVING COUNT(DISTINCT ProductId) > 8;                         -- Filter the unique product numbers that are more than 8 sold monthly.


-- 25. Write a query to find the MIN and MAX order quantity per Year. From orders table. (Do some research)

SELECT
	YEAR(OrderDate) AS Year,                      -- Format the date to year to group the quantities by year.
	MIN(Quantity) AS MinQTY,                      -- Minimum qty sold yearly.
	MAX(Quantity) AS MaxQTY                       -- Maximum qty sold yearly.
FROM Orders
GROUP BY YEAR(OrderDate)                          -- Group by year.


