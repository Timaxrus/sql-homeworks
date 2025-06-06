--Easy Tasks

-- 1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

SELECT
	CONCAT(EMPLOYEE_ID, '-', First_Name, ' ', LAST_NAME)
FROM
	Employees;


-- 2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'

SELECT
	Phone_number AS OldNum,
	REPLACE(PHONE_NUMBER, '124',  '999') AS NewNum
FROM
	Employees
WHERE
	PHONE_NUMBER LIKE '%124%';


-- 3.That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the employees' first names.(Employees)

SELECT
	FIRST_NAME,
	LEN(TRIM(FIRST_NAME)) AS LengthFirstName
FROM
	Employees
WHERE
	LOWER(TRIM(FIRST_NAME)) LIKE '[a,j,m]%'
ORDER BY
	FIRST_NAME;


-- 4.Write an SQL query to find the total salary for each manager ID.(Employees table)

SELECT DISTINCT
	e.MANAGER_ID,
	SUM(m.SALARY)
FROM
	Employees AS e
JOIN
	Employees AS m
	ON e.MANAGER_ID = m.EMPLOYEE_ID
GROUP BY e.MANAGER_ID;


-- 5.Write a query to retrieve the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table

SELECT	
	year1,
    GREATEST(max1,max2,max3) AS MaxAll
FROM 
	TestMax;


-- 6.Find me odd numbered movies description is not boring.(cinema)

SELECT
	id,
    description
FROM
	cinema
WHERE
	id % 2 = 1
    AND TRIM(description) != 'boring';


-- 7.You have to sort data based on the Id but Id with 0 should always be the last row. Now the question is can you do that with a single order by column.(SingleOrder)

SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;


-- 8.Write an SQL query to select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.(person)

SELECT
	COALESCE(ssn, passportid, itin, NULL) AS SetOfCoumns
FROM 
	person;


-- 9.Find the employees who have been with the company for more than 10 years, but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)

SELECT
	employee_id,
    first_name,
    last_name,
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS Years_of_service
FROM
	Employees
WHERE
	DATEDIFF(YEAR, hire_date, GETDATE()) > 10
    AND DATEDIFF(YEAR, hire_date, GETDATE()) < 15;


-- 10.Find the employees who have a salary greater than the average salary of their respective department.(Employees)

SELECT
	e.employee_id,
    e.department_id,
    e.salary,
    AvgSalary
FROM
	Employees AS e
JOIN
    (Select
        e1.department_id,
        AVG(e1.salary) AS AvgSalary
    FROM 
        Employees AS e1
    GROUP BY
        e1.department_id) AS AvgSal
    ON e.DEPARTMENT_ID = AvgSal.Department_id
WHERE
	e.SALARY > AvgSal.AvgSalary;


-- Medium Tasks 

-- 1.Write an SQL query that separates the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.

DECLARE @string VARCHAR(MAX) = 'tf56sd#%OqH';
DECLARE @position INT = 1;
DECLARE @char VARCHAR(5) = '';

DECLARE @Uppercase VARCHAR(MAX) = '';
DECLARE @Lowercase VARCHAR(MAX) = '';
DECLARE @Numerals VARCHAR(MAX) = '';
DECLARE @Others VARCHAR(MAX) = '';

WHILE @position <= LEN(@string)
BEGIN
	SET @char = SUBSTRING(@string, @position, 1);

	IF @char COLLATE Latin1_General_BIN LIKE '[A-Z]'
		SET	@Uppercase = CONCAT(@Uppercase, @char);
	ELSE IF @char COLLATE Latin1_General_BIN LIKE '[a-z]'
		SET @Lowercase = CONCAT(@Lowercase, @char);
	ELSE IF @char COLLATE Latin1_General_BIN LIKE '[0-9]'
		SET @Numerals = CONCAT(@Numerals, @char);
	ELSE
		SET @Others = CONCAT(@Others, @char);

	SET @position = @position + 1

END;

SELECT 
	@Uppercase AS Uppercase, 
	@Lowercase AS Lowercase,
	@Numerals AS Numerals, 
	@Others AS Others;


-- 2.split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

SELECT 
	SUBSTRING(TRIM(FullName), 1, CHARINDEX(' ',TRIM(FullName))-1) AS FirstName,
	SUBSTRING(TRIM(FullName), CHARINDEX(' ',TRIM(FullName)) + 1, CHARINDEX(' ',TRIM(FullName), CHARINDEX(' ',TRIM(FullName)) + 1) - CHARINDEX(' ',TRIM(FullName))-1) AS MiddleName,
	SUBSTRING(TRIM(FullName), CHARINDEX(' ',TRIM(FullName), CHARINDEX(' ',TRIM(FullName)) + 1), LEN(TRIM(FullName)) - CHARINDEX(' ',TRIM(FullName), CHARINDEX(' ',TRIM(FullName)) + 1) + 1) AS LastName
FROM Students;


-- 3.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

SELECT 
	o.CustomerID,
	o.OrderID,
	o.DeliveryState,
	o.Amount
FROM 
	Orders AS o
WHERE 
	o.DeliveryState = 'TX'
	AND EXISTS
			(SELECT 1 FROM Orders AS os 
			 WHERE os.DeliveryState = 'CA' 
			 AND os.CustomerID = o.CustomerID);


-- 4.Write an SQL query to transform a table where each product has a total quantity into a new table where each row represents a single unit of that product.For example, if A and B, it should be A,B and B,A.(Ungroup)

WITH MaxAll AS (
  SELECT
      MAX(quantity) AS MaxNum
  FROM Ungroup)
, Numbers AS (
   SELECT 1 AS Num
   UNION ALL
   SELECT Num + 1
   FROM Numbers
   WHERE Num + 1 <= (SELECT MaxNum FROM MaxAll))
 
, Prod_qty AS (
   SELECT 
     u.productdescription, 1 AS qty 
   FROM Ungroup AS u
   CROSS JOIN
     Numbers AS n
   WHERE n.Num <= u.Quantity
     )
, Pairs AS ( 
   SELECT 
     p1.productdescription AS Product1,
     p2.productdescription AS Product2
   FROM 
   	 Prod_qty p1
   CROSS JOIN 
     Prod_qty p2
   WHERE 
   	 p1.productdescription <> p2.productdescription)

SELECT
	Product1,
    Product2
FROM Pairs

UNION ALL

SELECT
	Product2 AS Product1,
    Product1 AS Product2
FROM Pairs;


-- 5.Write an SQL statement that can group concatenate the following values.(DMLTable)

SELECT STRING_AGG(String, ' ') 
FROM DMLTable;


-- 6.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

-- If the employee has worked for less than 1 year → 'New Hire'

-- If the employee has worked for 1 to 5 years → 'Junior'

-- If the employee has worked for 5 to 10 years → 'Mid-Level'

-- If the employee has worked for 10 to 20 years → 'Senior'

-- If the employee has worked for more than 20 years → 'Veteran'(Employees)


	SELECT 
	CONCAT(first_name, ' ', last_name) AS EmployeeName,
    CASE
    	WHEN DATEDIFF(YEAR, hire_date, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, hire_date, GETDATE()) >= 1 AND DATEDIFF(YEAR, hire_date, GETDATE()) <= 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 5 AND DATEDIFF(YEAR, hire_date, GETDATE()) <= 10 THEN 'Med-level'
        WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 10 AND DATEDIFF(YEAR, hire_date, GETDATE()) <= 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS Emp_stage
FROM 
	Employees;


-- 7.Find the employees who have a salary greater than the average salary of their respective department(Employees)

WITH Avg_Dept_Sal AS (
SELECT
	DEPARTMENT_ID,
	AVG(SALARY) AS Avg_Sal
FROM 
	Employees
GROUP BY
	DEPARTMENT_ID)

SELECT
	CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName
FROM 
	Employees AS e
JOIN 
	Avg_Dept_Sal
	ON e.DEPARTMENT_ID = Avg_Dept_Sal.DEPARTMENT_ID
WHERE
	e.SALARY > Avg_Dept_Sal.Avg_Sal;


-- 8.Find all employees whose names (concatenated first and last) contain the letter "a" and whose salary is divisible by 5(Employees)

SELECT
	CONCAT(FIRST_NAME, ' ', LAST_NAME) AS EmployeeName
FROM
	Employees
WHERE
	CAST(SALARY AS decimal(10,2)) % 5 = 0 
	AND CONCAT(FIRST_NAME, ' ', LAST_NAME) LIKE '%a%';


-- 9.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)

WITH NumOfEmp AS (
SELECT
	e.DEPARTMENT_ID,
	COUNT(e.EMPLOYEE_ID) AS EmpNumByDept,
	SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS EmpOverThreeYears
FROM
	Employees AS e	
GROUP BY
	e.DEPARTMENT_ID)

SELECT
	DEPARTMENT_ID,
	EmpNumByDept,
	CONCAT(CAST(EmpOverThreeYears AS float) / CAST(EmpNumByDept AS float) * 100, '%') AS EmpPercentage
FROM NumOfEmp;


-- 10.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

WITH MinMax AS (
SELECT
	SpacemanID,
	JobDescription,
	MissionCount,
	ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount ASC) AS MinExp,
	ROW_NUMBER() OVER (PARTITION BY JobDescription ORDER BY MissionCount DESC) AS MaxExp
FROM Personal)
SELECT
	JobDescription,
	MIN(CASE WHEN MinExp = 1 THEN SpacemanID END) AS MinExp ,
	MIN(CASE WHEN MaxExp = 1 THEN SpacemanID END) AS MaxExp
FROM MinMax
GROUP BY JobDescription;


--Difficult Tasks 

-- 1.Write an SQL query that replaces each row with the sum of its value and the previous row's value. (Students table)

SELECT
	*,
	Grade + LAG(Grade, 1, 0) OVER (ORDER BY StudentID) AS RunningSum
FROM Students;

-- 2.Given the following hierarchical table, write an SQL statement that determines the level of depth each employee has from the president. (Employee table)

WITH Steps AS (
SELECT
	EmployeeID,
	ManagerID,
	JobTitle,
	0 AS DepthLvl
FROM Employee 
WHERE ManagerID IS NULL
UNION ALL
SELECT
	e.EmployeeID,
	e.ManagerID,
	e.JobTitle,
	s.DepthLvl + 1 AS DepthLvl
FROM Employee AS e
JOIN Steps AS s
	ON e.ManagerID = s.EmployeeID)
SELECT
	EmployeeID,
	ManagerID,
	JobTitle,
	DepthLvl
FROM Steps;


-- 3.You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)




-- 4.Given the following dataset, find the students that share the same birthday.(Student Table)

SELECT
	st1.StudentName AS Student1,
	st2.StudentName AS Student2
FROM 
	Student AS st1
JOIN
	Student AS st2
	ON st1.Birthday = st2.Birthday
WHERE st1.Birthday = st2.Birthday
AND st1.StudentName < st2.StudentName;


-- 5.You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, 
--aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score 
--for each unique player pair(PlayerScores)

WITH Division AS (
SELECT
	CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS PlayerA,
	CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS PlayerB,
	Score
FROM PlayerScores)

SELECT
	PlayerA,
	PLayerB,
	SUM(Score)
FROM Division
GROUP BY PlayerA, PlayerB;

