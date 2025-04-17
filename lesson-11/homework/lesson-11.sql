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



-- 4. Return: CustomerName, OrderID, OrderDate
-- Task: List all customers from the USA who placed orders in the year 2023.
-- Tables Used: Customers, Orders

-- 5. Return: CustomerName, TotalOrders
-- Task: Show how many orders each customer has placed.
-- Tables Used: Orders (as a derived table), Customers

-- 6. Return: ProductName, SupplierName
-- Task: Display the names of products that are supplied by either Gadget Supplies or Clothing Mart.
-- Tables Used: Products, Suppliers

-- 7. Return: CustomerName, MostRecentOrderDate, OrderID
-- Task: For each customer, show their most recent order. Include customers who haven't placed any orders.
-- Tables Used: Customers, Orders (as a derived table)

-- 🟠 Medium-Level Tasks (6)

    Return: CustomerName, OrderID, OrderTotal
    Task: Show the customers who have placed an order where the total amount is greater than 500.
    Tables Used: Orders, Customers

    Return: ProductName, SaleDate, SaleAmount
    Task: List product sales where the sale was made in 2022 or the sale amount exceeded 400.
    Tables Used: Products, Sales

    Return: ProductName, TotalSalesAmount
    Task: Display each product along with the total amount it has been sold for.
    Tables Used: Sales (as a derived table), Products

    Return: EmployeeName, DepartmentName, Salary
    Task: Show the employees who work in the HR department and earn a salary greater than 50000.
    Tables Used: Employees, Departments

    Return: ProductName, SaleDate, StockQuantity
    Task: List the products that were sold in 2023 and had more than 50 units in stock at the time.
    Tables Used: Products, Sales

    Return: EmployeeName, DepartmentName, HireDate
    Task: Show employees who either work in the Sales department or were hired after 2020.
    Tables Used: Employees, Departments

🔴 Hard-Level Tasks (7)

    Return: CustomerName, OrderID, Address, OrderDate
    Task: List all orders made by customers in the USA whose address starts with 4 digits.
    Tables Used: Customers, Orders

    Return: ProductName, Category, SaleAmount
    Task: Display product sales for items in the Electronics category or where the sale amount exceeded 350.
    Tables Used: Products, Sales

    Return: CategoryName, ProductCount
    Task: Show the number of products available in each category.
    Tables Used: Products (as a derived table), Categories

    Return: CustomerName, City, OrderID, Amount
    Task: List orders where the customer is from Los Angeles and the order amount is greater than 300.
    Tables Used: Customers, Orders

    Return: EmployeeName, DepartmentName
    Task: Display employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
    Tables Used: Employees, Departments

    Return: ProductName, QuantitySold, Price
    Task: List products that had a sales quantity above 100 and a price above 500.
    Tables Used: Sales, Products

    Return: EmployeeName, DepartmentName, Salary
    Task: Show employees who are in the Sales or Marketing department and have a salary above 60000.
    Tables Used: Employees, Departments
