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
	m.SALARY
FROM
	Employees AS e
JOIN
	Employees AS m
	ON e.MANAGER_ID = m.EMPLOYEE_ID;


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

DECLARE @input_string NVARCHAR(MAX) = 'tf56sd#%OqH';
DECLARE @position INT = 1;
DECLARE @char NVARCHAR(1);

-- Temporary variables to hold the separated results
DECLARE @uppercase NVARCHAR(MAX) = '';
DECLARE @lowercase NVARCHAR(MAX) = '';
DECLARE @numbers NVARCHAR(MAX) = '';
DECLARE @others NVARCHAR(MAX) = '';

-- Loop through each character in the input string
WHILE @position <= LEN(@input_string)
BEGIN
    -- Extract one character at a time
    SET @char = SUBSTRING(@input_string, @position, 1);

    -- Categorize the character
    IF @char LIKE '[A-Z]'
        SET @uppercase = CONCAT(@uppercase, @char); -- Use CONCAT for better readability
    ELSE IF @char LIKE '[a-z]'
        SET @lowercase = CONCAT(@lowercase, @char);
    ELSE IF @char LIKE '[0-9]'
        SET @numbers = CONCAT(@numbers, @char);
    ELSE
        SET @others = CONCAT(@others, @char);

    -- Move to the next position
    SET @position = @position + 1;
END;

-- Display the results
SELECT 
    @uppercase AS Uppercase,
    @lowercase AS Lowercase,
    @numbers AS Numbers,
    @others AS Others;


-- 2.split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)

3.For every customer that had a delivery to California, provide a result set of the customer orders that were delivered to Texas. (Orders Table)

4.Write an SQL query to transform a table where each product has a total quantity into a new table where each row represents a single unit of that product.For example, if A and B, it should be A,B and B,A.(Ungroup)

5.Write an SQL statement that can group concatenate the following values.(DMLTable)

6.Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:

If the employee has worked for less than 1 year → 'New Hire'

If the employee has worked for 1 to 5 years → 'Junior'

If the employee has worked for 5 to 10 years → 'Mid-Level'

If the employee has worked for 10 to 20 years → 'Senior'

If the employee has worked for more than 20 years → 'Veteran'(Employees)

7.Find the employees who have a salary greater than the average salary of their respective department(Employees)

8.Find all employees whose names (concatenated first and last) contain the letter "a" and whose salary is divisible by 5(Employees)

9.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years(Employees)

10.Write an SQL statement that determines the most and least experienced Spaceman ID by their job description.(Personal)

--Difficult Tasks 1.Write an SQL query that replaces each row with the sum of its value and the previous row's value. (Students table)

2.Given the following hierarchical table, write an SQL statement that determines the level of depth each employee has from the president. (Employee table)

3.You are given the following table, which contains a VARCHAR column that contains mathematical equations. Sum the equations and provide the answers in the output.(Equations)

4.Given the following dataset, find the students that share the same birthday.(Student Table)

5.You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
