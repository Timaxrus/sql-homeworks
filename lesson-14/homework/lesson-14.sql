-- Easy Tasks 

-- 1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns) 

SELECT
	Name,
	SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1) AS [Name],
	SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name) - CHARINDEX(',', Name)) AS Surname

FROM TestMultipleColumns

-- 2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent) 

-- 3.In this puzzle you will have to split a string based on dot(.).(Splitter) 

-- 4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS) 

-- 5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots) 

-- 6.Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table) 

-- 7.Write a SQL query to count the spaces present in the string.(CountSpaces) 

-- 8.write a SQL query that finds out employees who earn more than their managers.(Employee)

-- Medium Tasks 

-- 1.Write a SQL query to separate the integer values and the character values into two different columns.(SeperateNumbersAndCharcters) 

-- 2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather) 

-- 3.Write a SQL query that reports the device that is first logged in for each player.(Activity) 

-- 4.Write an SQL query that reports the first login date for each player.(Activity) 

-- 5.Your task is to split the string into a list using a specific separator (such as a space, comma, etc.), 
-- and then return the third item from that list.(fruits) 

-- 6.Write a SQL query to create a table where each character from the string will be converted into a row, 
-- with each row having a single column.(sdgfhsdgfhs@121313131) 

-- 7.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, 
-- replace it with the value of p2.code.(p1,p2) 

-- 8.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
-- For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should 
-- be calculated based on the area sales for that week.(WeekPercentagePuzzle)

-- Difficult Tasks 

-- 1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals) 

-- 2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters) 

-- 3.Write a T-SQL query to remove the duplicate integer values present in the string column. 
-- Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames) 

-- 4.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters) 

-- 5.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)