-- Easy Tasks 

-- 1.Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns) 

SELECT
	SUBSTRING(TRIM(Name), 1, CHARINDEX(',', TRIM(Name)) - 1) AS [Name],
	SUBSTRING(TRIM(Name), CHARINDEX(',', TRIM(Name)) + 1, LEN(TRIM(Name)) - CHARINDEX(',', TRIM(Name))) AS Surname
FROM
	TestMultipleColumns;


-- 2.Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent) 

SELECT
	Strs
FROM 
	TestPercent
WHERE 
	Strs LIKE '%[%]%';


-- 3.In this puzzle you will have to split a string based on dot(.).(Splitter) 

SELECT
    Vals,
    CASE
        WHEN CHARINDEX('.', TRIM(Vals)) > 0 THEN SUBSTRING(TRIM(Vals), 1, CHARINDEX('.', TRIM(Vals)) - 1)
        ELSE TRIM(Vals) -- Handle cases where there is no dot
    END AS First,
    CASE
        WHEN CHARINDEX('.', TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1) > 0 THEN
            SUBSTRING(TRIM(Vals),
                CHARINDEX('.', TRIM(Vals)) + 1,
                CHARINDEX('.', TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1) - CHARINDEX('.', TRIM(Vals)) - 1)
        WHEN CHARINDEX('.', TRIM(Vals)) > 0 THEN
            SUBSTRING(TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1, LEN(TRIM(Vals)))
        ELSE NULL -- Handle cases where there is no second dot
    END AS Second,
    CASE
        WHEN CHARINDEX('.', TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1) > 0 THEN
            SUBSTRING(TRIM(Vals),
                CHARINDEX('.', TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1) + 1,
                LEN(TRIM(Vals)) - CHARINDEX('.', TRIM(Vals), CHARINDEX('.', TRIM(Vals)) + 1))
        ELSE NULL
    END AS Third
FROM Splitter; 


-- 4.Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS) 

DECLARE @InputString NVARCHAR(MAX) = '1234ABC123456XYZ1234567890ADS';

WITH Numbers AS (
    SELECT TOP (LEN(@InputString))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS Number
    FROM sys.objects
),
ReplacedChars AS (
    SELECT
        Number,
        CASE
            WHEN SUBSTRING(@InputString, Number, 1) LIKE '[0-9]' THEN 'X'
            ELSE SUBSTRING(@InputString, Number, 1)
        END AS ReplacedChar
    FROM Numbers
)
SELECT STRING_AGG(ReplacedChar, '') AS ResultString
FROM ReplacedChars;


-- 5.Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots) 

SELECT *
FROM testDots
WHERE 
	LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;


-- 6.Write a SQL query to count the occurrences of a substring within a string in a given column.(Not table) 

SELECT (LEN(given_column) - LEN(REPLACE(given_column, 'substring', ''))) / LEN('substring') AS Occurence_number
FROM Table_name


-- 7.Write a SQL query to count the spaces present in the string.(CountSpaces) 

SELECT
	texts,
	LEN(TRIM(texts)) - LEN(REPLACE(TRIM(texts), ' ', '')) AS SpaceCount
FROM CountSpaces;


-- 8.write a SQL query that finds out employees who earn more than their managers.(Employee)

SELECT
	e.Name,
	e.Salary,
	e.ManagerId
FROM Employee AS e
WHERE e.Salary > (SELECT m.Salary 
				  FROM Employee AS m 
				  WHERE e.ManagerId = m.Id);

-- Medium Tasks 

-- 1.Write a SQL query to separate the integer values and the character values into two different columns.(SeperateNumbersAndCharcters) 

CREATE FUNCTION dbo.GetMixedChars (@input VARCHAR(100))
RETURNS @Result TABLE (
	NumericVals VARCHAR(100),
	AlphabeticVals VARCHAR(100))
AS
BEGIN
    DECLARE @Numeric VARCHAR(100) = ''
	DECLARE @Alphabetic VARCHAR(100) = ''
    DECLARE @i INT = 1
	DECLARE @char VARCHAR(1)
    
    WHILE @i <= LEN(@input)
    BEGIN
		SET @char = SUBSTRING(@input, @i, 1);
				
        IF SUBSTRING(@input, @i, 1) LIKE '[A-Za-z]'
            SET @Alphabetic = @Alphabetic + @char;

		ELSE IF SUBSTRING(@input, @i, 1) LIKE '[0-9]'
			SET @Numeric = @Numeric + @char;

        SET @i = @i + 1
    END
    
    INSERT INTO @Result VALUES (@Numeric, @Alphabetic)
	RETURN
END
GO

SELECT
	s.Value,
	g.AlphabeticVals,
	g.NumericVals
FROM 
	SeperateNumbersAndCharcters AS s
CROSS APPLY 
	dbo.GetMixedChars(s.Value) AS g;


-- 2.write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather) 

SELECT
w1.id 
FROM weather w1
WHERE w1.Temperature > (SELECT w2.Temperature
FROM weather w2 WHERE DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1);

-- 3.Write a SQL query that reports the device that is first logged in for each player.(Activity) 

WITH Player AS (
SELECT
	player_id,
	MIN(event_date) AS date
FROM Activity
GROUP BY player_id) 
SELECT
	a.player_id,
	a.device_id
FROM Activity a
JOIN Player p
ON a.player_id = p.player_id
WHERE a.event_date = p.date;
 

-- 4.Write an SQL query that reports the first login date for each player.(Activity) 

WITH Player AS (
SELECT
	player_id,
	MIN(event_date) AS date
FROM Activity
GROUP BY player_id) 
SELECT
	a.player_id,
	a.event_date
FROM Activity a
JOIN Player p
ON a.player_id = p.player_id
WHERE a.event_date = p.date;


-- 5.Your task is to split the string into a list using a specific separator (such as a space, comma, etc.), 
-- and then return the third item from that list.(fruits) 

WITH SepPos AS (
SELECT
	fruit_list,
	CHARINDEX(',', fruit_list) AS firstSep,
	CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) AS secondSep,
	CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1) AS thirdSep
FROM fruits)
, ThirdFruit AS (
SELECT
	CASE WHEN secondSep > 0 AND thirdSep > 0 THEN SUBSTRING(fruit_list, secondSep + 1, thirdSep - secondSep - 1)
	ELSE NULL
	END AS thirdItem
FROM SepPos)

SELECT
	thirdItem
FROM ThirdFruit;


-- 6.Write a SQL query to create a table where each character from the string will be converted into a row, 
-- with each row having a single column.(sdgfhsdgfhs@121313131) 

WITH Mychars AS(
SELECT
	SUBSTRING('sdgfhsdgfhs@121313131', 1, 1) AS Mychar,
	1 AS position
UNION ALL
SELECT
	SUBSTRING('sdgfhsdgfhs@121313131', position + 1, 1) AS Mychar,
	position + 1
FROM Mychars
WHERE position <= LEN('sdgfhsdgfhs@121313131'))

SELECT Mychar FROM Mychars;


-- 7.You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, 
-- replace it with the value of p2.code.(p1,p2) 

SELECT 
	CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS NewCode
FROM p1
JOIN p2 
ON p1.id = p2.id;


-- 8.You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
-- For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should 
-- be calculated based on the area sales for that week.(WeekPercentagePuzzle)

WITH TotalSale AS (
SELECT
	SUM(ISNULL(SalesLocal,0)) + SUM(ISNULL(SalesRemote, 0)) AS TotalSales,
	SUM(SUM(ISNULL(SalesLocal,0)) + SUM(ISNULL(SalesRemote, 0))) OVER (PARTITION BY FinancialWeek ORDER BY FinancialWeek) AS Overall,
	FinancialWeek,
	Area,
	DayOfWeek
FROM WeekPercentagePuzzle
GROUP BY FinancialWeek, Area, DayOfWeek)

SELECT
	TotalSales,
	Area,
	DayOfWeek,
	CAST(CAST(TotalSales AS float) / CAST(Overall AS float) * 100 AS varchar(50)) + '%' AS perc
FROM TotalSale;


-- Difficult Tasks 

-- 1.In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals) 

WITH SecV AS (
SELECT
	Id, 
	STUFF(Vals, 1, 3, '') AS rem,
	SUBSTRING(Vals, 1, 3) AS subs
FROM MultipleVals)
SELECT
	m.*,
	CONCAT(
		STUFF(
			REPLACE(
				s.subs, SUBSTRING(s.subs, 1, 1), SUBSTRING(s.subs, 3, 1)), 
					3, 1, SUBSTRING(m.Vals, 1, 1)), '', s.rem) AS SwappedVal
FROM SecV AS s
JOIN MultipleVals m
ON s.id = m.Id;

-- 2.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters) 

SELECT
	* 
FROM FindSameCharacters
WHERE LEN(Vals) > 1 
AND LEN(REPLACE(Vals, SUBSTRING(Vals, 1, 1), '')) = 0;


-- 3.Write a T-SQL query to remove the duplicate integer values present in the string column. 
-- Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames) 

SELECT 
    PawanName,
    -- Step-by-step cleaning
    CASE
        WHEN RIGHT(Pawan_slug_name, 2) = '-3' THEN LEFT(Pawan_slug_name, LEN(Pawan_slug_name) - 2) -- remove '-3'
        ELSE
            REPLACE(
                REPLACE(
                    REPLACE(
                        Pawan_slug_name,
                        '-111', '-1'
                    ),
                    '-4444', '-4'
                ),
                '-32', ''
            )
    END AS Cleaned_slug_name
FROM 
    RemoveDuplicateIntsFromNames;


-- 4.Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters) 

SELECT
	* 
FROM FindSameCharacters
WHERE LEN(Vals) > 1 
AND LEN(REPLACE(Vals, SUBSTRING(Vals, 1, 1), '')) = 0;

-- 5.Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)

SELECT
	Vals,
	SUBSTRING(Vals, 1, 1)
FROM GetIntegers
WHERE SUBSTRING(Vals, 1, 1) LIKE '[0-9]'
AND VALS LIKE '%[a-z]%';