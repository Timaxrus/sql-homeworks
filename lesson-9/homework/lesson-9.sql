-- 🟢 Easy (10 puzzles)

-- 1. Using Products, Suppliers table List all combinations of product names and supplier names.

SELECT 
  p.ProductName,
    s.SupplierName
FROM Products p 
INNER JOIN Suppliers s 
ON p.SupplierID = s.SupplierID;


-- 2. Using Departments, Employees table Get all combinations of departments and employees.

SELECT 
	d.DepartmentName,
    e.Name
FROM Departments d 
INNER JOIN Employees e
ON d.DepartmentID = e.DepartmentID;


-- 3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name

SELECT 
	s.SupplierName,
    p.ProductName
FROM Suppliers s
INNER JOIN Products p 
ON s.SupplierID = p.SupplierID;


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
INNER JOIN Enrollments e 
ON s.StudentID = e.StudentID
INNER JOIN Courses c 
ON e.CourseID = c.CourseID;

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
