-- 🟢 Easy (10 puzzles)

-- 1. Using Products, Suppliers table List all combinations of product names and supplier names.

SELECT 
	p.ProductName,
    s.SupplierName
FROM Products p 
CROSS JOIN Suppliers s;


-- 2. Using Departments, Employees table Get all combinations of departments and employees.

SELECT
	d.DepartmentName,
    e.Name
FROM Departments d 
CROSS JOIN Employees e;


-- 3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name

SELECT 
	s.SupplierName,
    p.ProductName
FROM Suppliers s
CROSS JOIN Products p 
WHERE s.SupplierID = p.SupplierID;


-- 4. Using Orders, Customers table List customer names and their orders ID.

SELECT
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID
FROM Customers c 
INNER JOIN Orders o 
ON c.CustomerID = o.CustomerID;


-- 5. Using Courses, Students table Get all combinations of students and courses.

SELECT
	s.Name,
    c.CourseName
FROM Students s 
CROSS JOIN Courses c;

-- 6. Using Products, Orders table Get product names and orders where product IDs match.

SELECT	
	p.ProductName,
    o.OrderID
FROM Products p 
INNER JOIN Orders o 
ON p.ProductID = o.ProductID;


-- 7. Using Departments, Employees table List employees whose DepartmentID matches the department.

SELECT
	e.Name,
    d.DepartmentName
FROM Employees e 
INNER JOIN Departments d 
ON e.DepartmentID = d.DepartmentID;


-- 8. Using Students, Enrollments table List student names and their enrolled course IDs.

SELECT 
	s.Name,
    e.CourseID
FROM Students s 
INNER JOIN Enrollments e 
ON s.StudentID = e.StudentID;


-- 9. Using Payments, Orders table List all orders that have matching payments.

SELECT
	o.OrderID,
    o.TotalAmount AS OrderAmount,
    p.Amount AS PaidAmount,
    p.PaymentMethod
FROM Orders o 
INNER JOIN Payments p 
ON o.OrderID = p.OrderID;


-- 10. Using Orders, Products table Show orders where product price is more than 100.

SELECT 
	o.OrderID,
    o.OrderDate,
    o.Quantity,
    o.TotalAmount,
    p.ProductName,
    p.Price
FROM Orders o 
INNER JOIN Products p 
ON o.ProductID = p.ProductID
WHERE p.Price > 100;

-- 🟡 Medium (10 puzzles)

-- 11. Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.

SELECT
	e.Name,
	d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID != d.DepartmentID;


-- 12. Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.

SELECT
	o.OrderID,
	o.Quantity,
	o.TotalAmount,
	p.StockQuantity
FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductID
WHERE o.Quantity > p.StockQuantity;


-- 13. Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.

SELECT 
	c.FirstName + ' ' + c.LastName AS CutomerName,
	s.ProductID
FROM Customers c
INNER JOIN Sales s
ON c.CustomerID = s.CustomerID
WHERE s.SaleAmount >= 500;

-- 14. Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.

SELECT
	s.Name,
    c.CourseName
FROM Students s 
INNER JOIN Enrollments e 
ON s.StudentID = e.StudentID
INNER JOIN Courses c 
ON e.CourseID = c.CourseID;


-- 15. Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.

SELECT 
	p.ProductName,
	s.SupplierName
FROM Products p
INNER JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE LOWER(SupplierName) LIKE '%tech%';


-- 16. Using Orders, Payments table Show orders where payment amount is less than total amount.

SELECT
	o.OrderID,
	o.OrderDate,
	o.TotalAmount,
	p.PaymentDate,
	p.Amount AS PaymentAmount
FROM Orders o
INNER JOIN Payments p
ON o.OrderID = p.OrderID
WHERE o.TotalAmount > p.Amount;


-- 17. Using Employees table List employee names with salaries greater than their manager’s salary.

SELECT 
	e.Name AS EmployeeName,
	e.Salary AS EmployeeSalary,
	m.Name AS ManagerName,
	m.Salary AS ManagerSalary
FROM Employees e
INNER JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE e.Salary > m.Salary;


-- 18. Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.

SELECT
	p.ProductName,
	c.CategoryName
FROM Products p
INNER JOIN Categories c
ON p.Category = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');

-- 19. Using Sales, Customers table Show all sales from customers who are from 'USA'.

SELECT
	s.SaleID,
	s.SaleDate,
	c.Country AS CountryOfCustomer
FROM Sales s
INNER JOIN Customers c
ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';


-- 20. Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.

SELECT
	o.OrderID,
	o.OrderDate,
	o.TotalAmount,
	c.Country AS CountryOfCustomer
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;

-- 🔴 Hard (5 puzzles)

-- 21. Using Employees table List all pairs of employees from different departments.

SELECT
	e1.Name AS Employee1,
	e2.Name AS Employee2
FROM Employees e1
CROSS JOIN Employees e2
WHERE e1.DepartmentID != e2.DepartmentID;

-- 22. Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).

SELECT 
	ps.PaymentID,
	ps.PaymentDate,
	ps.Amount AS PaidAmount,
	p.ProductName,
	p.Price,
	o.Quantity AS OrderedQuantity,
	p.Price * o.Quantity AS CorrectTotalAmount
FROM Payments ps
INNER JOIN Orders o
ON ps.OrderID = o.OrderID
INNER JOIN Products p
ON o.ProductID = p.ProductID
WHERE ps.Amount <> p.Price * o.Quantity;


-- 23. Using Students, Enrollments, Courses table Find students who are not enrolled in any course.

SELECT 
	s.StudentID,
	s.Name,
	s.Age,
	s.Major,
	c.CourseName
FROM Students s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID
LEFT JOIN Courses c
ON e.CourseID = c.CourseID
WHERE e.StudentID IS NULL


-- 24. Using Employees table List employees who are managers of someone, but their salary is less than or equal to the person they manage.

SELECT
    m.Name AS ManagerName,
    m.Salary AS ManagerSalary,
    e.Name AS EmployeeName,
    e.Salary AS EmployeeSalary
FROM Employees e
INNER JOIN Employees m
ON e.ManagerID = m.EmployeeID
WHERE m.Salary <= e.Salary;


-- 25. Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.

SELECT 
	c.CustomerID,
	CONCAT_WS(' ', c.FirstName, c.LastName) AS CustomerName,
	c.Phone,
	c.Email
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p
ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;