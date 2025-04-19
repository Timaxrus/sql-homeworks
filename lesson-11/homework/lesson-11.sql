-- 🟢 Easy-Level Tasks (7)

-- 1. Return: OrderID, CustomerName, OrderDate
-- Task: Show all orders placed after 2022 along with the names of the customers who placed them.
-- Tables Used: Orders, Customers

SELECT
	o.OrderID,
    CONCAT_WS(' ', c.FirstName, c.LastName) AS CustomerName,
    o.OrderDate
FROM 
	Orders AS o 
JOIN 
	Customers AS c 
	ON o.CustomerID = c.CustomerID
WHERE 
	o.OrderDate > '2022-12-31';


-- 2. Return: EmployeeName, DepartmentName
-- Task: Display the names of employees who work in either the Sales or Marketing department.
-- Tables Used: Employees, Departments

SELECT
	e.Name AS EmployeeName,
    d.DepartmentName
FROM 
	Employees AS e 
JOIN 
	Departments AS d
    ON e.DepartmentID = d.DepartmentID
WHERE
	LOWER(d.DepartmentName) IN ('sales', 'marketing');


-- 3. Return: DepartmentName, TopEmployeeName, MaxSalary
-- Task: For each department, show the name of the employee who earns the highest salary.
-- Tables Used: Departments, Employees (as a derived table)

SELECT
	d.DepartmentName,
	e.Name AS TopEmployeeName,
	dt.MaxSalary
FROM 
	Departments d
JOIN
	(SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees GROUP BY DepartmentID) AS dt
	ON d.DepartmentID = dt.DepartmentID
JOIN 
	Employees e
	ON d.DepartmentID = e.DepartmentID
WHERE dt.MaxSalary = e.Salary


-- 4. Return: CustomerName, OrderID, OrderDate
-- Task: List all customers from the USA who placed orders in the year 2023.
-- Tables Used: Customers, Orders

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	o.OrderID,
	o.OrderDate
FROM	
	Orders AS o
JOIN
	Customers AS c
	ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2023-01-01'
    AND '2023-12-31' AND c.Country = 'USA';
	

-- 5. Return: CustomerName, TotalOrders
-- Task: Show how many orders each customer has placed.
-- Tables Used: Orders (as a derived table), Customers

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	dt.TotalOrders
FROM	
	Customers AS c
JOIN
	(SELECT 
		CustomerID, 
		COUNT(OrderID) AS TotalOrders 
	FROM Orders GROUP BY CustomerID) AS dt
	ON c.CustomerID = dt.CustomerID
		

-- 6. Return: ProductName, SupplierName
-- Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
-- Tables Used: Products, Suppliers

SELECT
	p.ProductName,
	s.SupplierName
FROM
	Products AS p
JOIN
	Suppliers AS s
	ON p.SupplierID = s.SupplierID
WHERE LOWER(s.SupplierName)
	IN ('gadget supplies', 'clothing mart');


-- 7. Return: CustomerName, MostRecentOrderDate, OrderID
-- Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
-- Tables Used: Customers, Orders (as a derived table)

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	dt.MostRecentOrderDate,
	dt.OrderID
FROM 
	Customers AS c
LEFT JOIN
	(SELECT
		OrderID,
		CustomerID,
		MAX(OrderDate) AS MostRecentOrderDate
	FROM 
		Orders
	GROUP BY OrderID, CustomerID) AS dt
	ON c.CustomerID = dt.CustomerID;

	
-- 🟠 Medium-Level Tasks (6)

-- 8. Return: CustomerName, OrderID, OrderTotal
-- Task: Show the customers who have placed an order where the total amount is greater than 500.
-- Tables Used: Orders, Customers

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	o.OrderID,
	o.TotalAmount AS Ordertotal
FROM 
	Customers AS c
JOIN
	Orders AS o
	ON c.CustomerID = o.CustomerID
WHERE
	o.TotalAmount > 500;


-- 9. Return: ProductName, SaleDate, SaleAmount
-- Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
-- Tables Used: Products, Sales

SELECT
	p.ProductName,
	s.SaleDate,
	s.SaleAmount
FROM 
	Products AS p
JOIN
	Sales AS s
	ON p.ProductID = s.ProductID
WHERE YEAR(s.SaleDate) = 2022
	OR s.SaleAmount > 400;


-- 10. Return: ProductName, TotalSalesAmount
-- Task: Display each product along with the total amount it has been sold for.
-- Tables Used: Sales (as a derived table), Products

SELECT
	p.ProductName,
	dt.TotalSalesAmount
FROM
	Products AS p
JOIN
	(SELECT
		ProductID,
		SUM(SaleAmount) AS TotalSalesAmount
	FROM Sales
	GROUP BY ProductID) AS dt
	ON p.ProductID = dt.ProductID;


-- 11. Return: EmployeeName, DepartmentName, Salary
-- Task: Show the employees who work in the HR department and earn a salary greater than 50000.
-- Tables Used: Employees, Departments

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.Salary
FROM
	Employees AS e
JOIN
	Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE LOWER(d.DepartmentName) = 'human resources'
	AND e.Salary > 50000;


-- 12. Return: ProductName, SaleDate, StockQuantity
-- Task: List the products that were sold in 2023 and had more than 50 units in stock at the time.
-- Tables Used: Products, Sales

SELECT
	p.ProductName,
	s.SaleDate,
	p.StockQuantity
FROM
	Products AS p
JOIN
	Sales AS s
	ON p.ProductID = s.ProductID
WHERE
	s.SaleDate BETWEEN '2023-01-01' AND '2023-12-31'
	AND	p.StockQuantity > 50;


-- 13. Return: EmployeeName, DepartmentName, HireDate
-- Task: Show employees who either work in the Sales department or were hired after 2020.
-- Tables Used: Employees, Departments

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.HireDate
FROM
	Employees AS e
JOIN
	Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE
	LOWER(d.DepartmentName) = 'sales'
	OR e.HireDate > '2020-12-31';


-- 🔴 Hard-Level Tasks (7)

-- 14. Return: CustomerName, OrderID, Address, OrderDate
-- Task: List all orders made by customers in the USA whose address starts with 4 digits.
-- Tables Used: Customers, Orders

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	o.OrderID,
	c.Address,
	o.OrderDate
FROM
	Customers AS c
JOIN
	Orders AS o
	ON c.CustomerID = o.CustomerID
WHERE 
	LOWER(c.Country) = 'usa'
	AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';
	

-- 15. Return: ProductName, Category, SaleAmount
-- Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
-- Tables Used: Products, Sales

SELECT
	p.ProductName,
	c.CategoryName AS Category,
	s.SaleAmount
FROM 
	Products AS p
JOIN
	Sales AS s
	ON p.ProductID = s.ProductID
JOIN
	Categories AS c
	ON p.Category = c.CategoryID
WHERE
	LOWER(c.CategoryName) = 'electronics'
	OR s.SaleAmount > 350;
	

-- 16. Return: CategoryName, ProductCount
-- Task: Show the number of products available in each category.
-- Tables Used: Products (as a derived table), Categories

SELECT
	c.CategoryName,
	dt.ProductCount
FROM
	Categories AS c
JOIN
	(SELECT
		Category,
		COUNT(ProductID) AS ProductCount
	FROM Products
	GROUP BY Category) AS dt
	ON c.CategoryID = dt.Category;


-- 17. Return: CustomerName, City, OrderID, Amount
-- Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
-- Tables Used: Customers, Orders

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	c.City,
	o.OrderID,
	o.TotalAmount AS Amount
FROM
	Customers AS c
JOIN
	Orders AS o
	ON c.CustomerID = o.CustomerID
WHERE
	Lower(c.City) = 'los angeles'
	AND o.TotalAmount > 300;


-- 18. Return: EmployeeName, DepartmentName
-- Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
-- Tables Used: Employees, Departments

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName
FROM
	Employees AS e
JOIN
	Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE
	LOWER(d.DepartmentName) IN ('human resources', 'finance')
	OR LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'a', '')) +
		LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'e', '')) +
		LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'i', '')) +
		LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'o', '')) +
		LEN(e.Name) - LEN(REPLACE(LOWER(e.Name), 'u', '')) >= 4;

-- 19. Return: ProductName, QuantitySold, Price
-- Task: List products that had a sales quantity above 100 and a price above 500.
-- Tables Used: Sales, Products

SELECT
	p.ProductName,
	SUM(o.Quantity) AS QuantitySold,
	p.Price
FROM
	Products AS p
JOIN
	Sales AS s
	ON p.ProductID = s.ProductID
JOIN
	Orders AS o
	ON p.ProductID = s.ProductID
GROUP BY
	p.ProductName, 
	p.Price
HAVING
	SUM(o.Quantity) > 100 AND p.Price >500;


-- 20. Return: EmployeeName, DepartmentName, Salary
-- Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
-- Tables Used: Employees, Departments

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName,
	e.Salary
FROM
	Employees AS e
JOIN
	Departments AS d
	ON e.DepartmentID = d.DepartmentID
WHERE
	LOWER(d.DepartmentName) IN ('sales', 'marketing')
	AND e.Salary > 60000;
