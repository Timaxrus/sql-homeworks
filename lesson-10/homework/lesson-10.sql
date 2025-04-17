-- 🟢 Easy-Level Tasks (10)

-- 1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
-- 🔁 Expected Output: EmployeeName, Salary, DepartmentName

SELECT
	e.Name AS EmployeeName,
	e.Salary,
	d.DepartmentName
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;


-- 2. Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
-- 🔁 Expected Output: FirstName, LastName, OrderDate

SELECT
	c.FirstName, 
	c.LastName,
	o.OrderDate
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = '2023';


-- 3. Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
-- 🔁 Expected Output: EmployeeName, DepartmentName
-- (Hint: Use a LEFT OUTER JOIN)

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
LEFT OUTER JOIN Departments d
	ON e.DepartmentID = d.DepartmentID;


-- 4. Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
-- 🔁 Expected Output: SupplierName, ProductName

SELECT
	s.SupplierName,
	p.ProductName
FROM Suppliers s
LEFT JOIN Products p
	ON s.SupplierID = p.SupplierID;


-- 5. Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
-- 🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount

SELECT
	o.OrderID,
	o.OrderDate,
	p.PaymentDate,
	p.Amount
FROM Orders o
FULL OUTER JOIN Payments p
	ON o.OrderID = p.OrderID;


-- 6. Using the Employees table, write a query to show each employee's name along with the name of their manager.
-- 🔁 Expected Output: EmployeeName, ManagerName

SELECT	
	e1.Name AS EmployeeName,
	e2.Name AS ManagerName
FROM Employees e1
LEFT JOIN Employees e2
	ON e1.ManagerID = e2.EmployeeID;


-- 7. Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
-- 🔁 Expected Output: StudentName, CourseName

SELECT
	s.Name AS StudentName,
	c.CourseName
FROM Students s
JOIN Enrollments e
	ON s.StudentID = e.StudentID
JOIN Courses c
	ON e.CourseID = c.CourseID
WHERE LOWER(c.CourseName) = 'math 101';


-- 8. Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
-- 🔁 Expected Output: FirstName, LastName, Quantity

SELECT 
	c.FirstName,
	c.LastName,
	o.Quantity
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;


-- 9. Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
-- 🔁 Expected Output: EmployeeName, DepartmentName

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


-- 🟠 Medium-Level Tasks (9)

-- 10. Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
-- 🔁 Expected Output: DepartmentName, EmployeeCount

SELECT
	d.DepartmentName,
	COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e
	ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 10;


-- 11. Using the Products and Sales tables, write a query to find products that have never been sold.
-- 🔁 Expected Output: ProductID, ProductName

SELECT
	p.ProductID,
	p.ProductName
FROM Products p
WHERE NOT EXISTS (SELECT 1 
	          FROM Sales s WHERE s.ProductID =p.ProductID);


-- 12. Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
-- 🔁 Expected Output: FirstName, LastName, TotalOrders

SELECT
	c.FirstName,
	c.LastName,
	COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName
	HAVING COUNT(o.OrderID) > 0;


-- 13. Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
-- 🔁 Expected Output: EmployeeName, DepartmentName

SELECT
	e.Name AS EmployeeName,
	d.DepartmentName
FROM Employees e
JOIN Departments d
	ON e.DepartmentID = d.DepartmentID;


-- 14. Using the Employees table, write a query to find pairs of employees who report to the same manager.
-- 🔁 Expected Output: Employee1, Employee2, ManagerID


SELECT
	e1.EmployeeID AS Employee1,
	e2.EmployeeID AS Employee2,
	e1.ManagerID
FROM Employees e1
JOIN Employees e2
	ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID;


 -- 15. Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
-- 🔁 Expected Output: OrderID, OrderDate, FirstName, LastName

SELECT 
	o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM Orders o 
JOIN Customers c 
	ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '2022-01-01' AND o.OrderDate < '2023-01-01';


-- 16. Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
-- 🔁 Expected Output: EmployeeName, Salary, DepartmentName

SELECT
	e.Name AS EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e 
JOIN Departments d 
	ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 60000 AND LOWER(d.DepartmentName) = 'sales';


-- 17. Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
-- 🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount

SELECT	
	o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Payments p 
JOIN Orders o 
	ON p.OrderID = o.OrderID;


-- 18. Using the Products and Orders tables, write a query to find products that were never ordered.
-- 🔁 Expected Output: ProductID, ProductName

SELECT
	p.ProductID,
    p.ProductName
FROM Products p 
WHERe NOT EXISTS (SELECT 1 FROM Orders o WHERE p.ProductID = o.ProductID);


-- 🔴 Hard-Level Tasks (9)

-- 19. Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
-- 🔁 Expected Output: EmployeeName, Salary

SELECT
	e1.Name,
    e1.Salary
FROM Employees e1
WHERE e1. Salary > (SELECT AVG(e2.Salary) FROM Employees e2);


-- 20. Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
-- 🔁 Expected Output: OrderID, OrderDate

SELECT
	o.OrderID,
    o.OrderDate
FROM Orders o 
WHERE o.OrderDate < '2020-01-01'
	AND NOT EXISTS (SELECT 1 FROM Payments p WHERE o.OrderID = p.OrderID);


-- 21. Using the Products and Categories tables, write a query to return products that do not have a matching category.
-- 🔁 Expected Output: ProductID, ProductName

SELECT
	p.ProductID,
    p.ProductName
FROM Products p 
WHERE NOT EXISTS (SELECT 1 FROM Categories c WHERE p.Category = c.CategoryID);


-- 22. Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
-- 🔁 Expected Output: Employee1, Employee2, ManagerID, Salary

SELECT
	e1.EmployeeID AS Employee1,
	e2.EmployeeID AS Employee2,
	e1.ManagerID,
    e1.Salary AS Employee1Salary,
    e2.Salary AS Employee2Salary
FROM Employees e1
JOIN Employees e2
	ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID
	AND e1.Salary > 60000
	AND e2.Salary > 60000;


-- 23. Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
-- 🔁 Expected Output: EmployeeName, DepartmentName

SELECT
	e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e 
JOIN Departments d 
	ON e.DepartmentID = d.DepartmentID
WHERE LOWER(d.DepartmentName) LIKE 'm%';

-- 24. Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
-- 🔁 Expected Output: SaleID, ProductName, SaleAmount

SELECT
	s.SaleID,
    p.ProductName,
    s.SaleAmount
FROM Sales s 
JOIN Products p 
	ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;


-- 25. Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
-- 🔁 Expected Output: StudentID, StudentName

SELECT 
	s.StudentID,
    s.Name AS StudentName
FROM Students s 
WHERE NOT EXISTS (SELECT 1 FROM Enrollments e 
                  JOIN Courses c
                  ON e.CourseID = c.CourseID
                  WHERE s.StudentID = e.StudentID
                  AND LOWER(c.CourseName) = 'math 101');


-- 26. Using the Orders and Payments tables, write a query to return orders that are missing payment details.
-- 🔁 Expected Output: OrderID, OrderDate, PaymentID

SELECT
	o.OrderID,
    o.OrderDate,
    p.PaymentID
FROM Orders o 
LEFT JOIN Payments p 
	ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;


-- 27. Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
-- 🔁 Expected Output: ProductID, ProductName, CategoryName

SELECT
	p.ProductID,
    p.ProductName,
    c.CategoryName
FROM Products p 
LEFT JOIN Categories c 
	ON p.Category = c.CategoryID
WHERE LOWER(c.CategoryName) IN ('electronics', 'furniture');
