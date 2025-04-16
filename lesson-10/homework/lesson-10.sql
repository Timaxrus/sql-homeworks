-- 🟢 Easy-Level Tasks (10)

-- 1. Using the Employees and Departments tables, write a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
-- 🔁 Expected Output: EmployeeName, Salary, DepartmentName

-- 2. Using the Customers and Orders tables, write a query to display customer names and order dates for orders placed in the year 2023.
-- 🔁 Expected Output: FirstName, LastName, OrderDate

-- 3. Using the Employees and Departments tables, write a query to show all employees along with their department names. Include employees who do not belong to any department.
-- 🔁 Expected Output: EmployeeName, DepartmentName
-- (Hint: Use a LEFT OUTER JOIN)

-- 4. Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
-- 🔁 Expected Output: SupplierName, ProductName

-- 5. Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
-- 🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount

-- 6. Using the Employees table, write a query to show each employee's name along with the name of their manager.
-- 🔁 Expected Output: EmployeeName, ManagerName

-- 7. Using the Students, Courses, and Enrollments tables, write a query to list the names of students who are enrolled in the course named 'Math 101'.
-- 🔁 Expected Output: StudentName, CourseName

-- 8. Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
-- 🔁 Expected Output: FirstName, LastName, Quantity

    Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.
    🔁 Expected Output: EmployeeName, DepartmentName

🟠 Medium-Level Tasks (9)

    Using the Employees and Departments tables, write a query to return department names that have more than 10 employees.
    🔁 Expected Output: DepartmentName, EmployeeCount

    Using the Products and Sales tables, write a query to find products that have never been sold.
    🔁 Expected Output: ProductID, ProductName

    Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.
    🔁 Expected Output: FirstName, LastName, TotalOrders

    Using the Employees and Departments tables, write a query to show only those records where both employee and department exist (no NULLs).
    🔁 Expected Output: EmployeeName, DepartmentName

    Using the Employees table, write a query to find pairs of employees who report to the same manager.
    🔁 Expected Output: Employee1, Employee2, ManagerID

    Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name.
    🔁 Expected Output: OrderID, OrderDate, FirstName, LastName

    Using the Employees and Departments tables, write a query to return employees from the 'Sales' department whose salary is above 60000.
    🔁 Expected Output: EmployeeName, Salary, DepartmentName

    Using the Orders and Payments tables, write a query to return only those orders that have a corresponding payment.
    🔁 Expected Output: OrderID, OrderDate, PaymentDate, Amount

    Using the Products and Orders tables, write a query to find products that were never ordered.
    🔁 Expected Output: ProductID, ProductName

🔴 Hard-Level Tasks (9)

    Using the Employees table, write a query to find employees whose salary is greater than the average salary of all employees.
    🔁 Expected Output: EmployeeName, Salary

    Using the Orders and Payments tables, write a query to list all orders placed before 2020 that have no corresponding payment.
    🔁 Expected Output: OrderID, OrderDate

    Using the Products and Categories tables, write a query to return products that do not have a matching category.
    🔁 Expected Output: ProductID, ProductName

    Using the Employees table, write a query to find employees who report to the same manager and earn more than 60000.
    🔁 Expected Output: Employee1, Employee2, ManagerID, Salary

    Using the Employees and Departments tables, write a query to return employees who work in departments whose name starts with the letter 'M'.
    🔁 Expected Output: EmployeeName, DepartmentName

    Using the Products and Sales tables, write a query to list sales where the amount is greater than 500, including product names.
    🔁 Expected Output: SaleID, ProductName, SaleAmount

    Using the Students, Courses, and Enrollments tables, write a query to find students who have not enrolled in the course 'Math 101'.
    🔁 Expected Output: StudentID, StudentName

    Using the Orders and Payments tables, write a query to return orders that are missing payment details.
    🔁 Expected Output: OrderID, OrderDate, PaymentID

    Using the Products and Categories tables, write a query to list products that belong to either the 'Electronics' or 'Furniture' category.
    🔁 Expected Output: ProductID, ProductName, CategoryName

