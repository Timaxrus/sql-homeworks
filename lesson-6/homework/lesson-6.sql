-- PUZZLE 1: Finding Distinct Values
-- Question: Explain at least two ways to find distinct values based on two columns.

-- Way 1.
-- Values in col1 and col2 are reorganized based on their comparison. The smaller value is under col1 and the larger one is under col2.
-- This way 'a-b' and 'b-a' can treated as same pairs. Then they are grouped based on swapped order and we get the final result.

SELECT 
    CASE WHEN col1 <= col2 THEN col1 ELSE col2 END AS col1,         -- If col1 is smaller or equal to col2 then value of col1 should be considered as col1.
    CASE WHEN col1 <= col2 THEN col2 ELSE col1 END AS col2          -- If col1 is smaller or equal to col2 then value of col2 should be considered as col2.
FROM InputTbl
GROUP BY 
    CASE WHEN col1 <= col2 THEN col1 ELSE col2 END,                 -- Group by col1 if it is smaller than or equal to col2.
    CASE WHEN col1 <= col2 THEN col2 ELSE col1 END                  -- Group by col2 if it is greater than or equal to col1.
ORDER BY 1, 2;



-- Way 2. 
-- Using LEAST/GREATEST functions

SELECT 
    LEAST(col1, col2) AS column1,                 -- LEAST() returns the smaller of the two values
    GREATEST(col1, col2) AS column2               -- GREATEST() returns the larger of the two values
FROM InputTbl
GROUP BY 
    LEAST(col1, col2),                         -- This is simillar to "column1".
    GREATEST(col1, col2)                       -- And this to "column2".


-- Way 3.
-- Using UNION operator

SELECT col1, col2 FROM InputTbl WHERE col1 <= col2       -- Select col1 and col2 where col1 is less than or equal to col2.
UNION
SELECT col2, col1 FROM InputTbl WHERE col1 > col2        -- Select col2 and col1 where col1 is greater than or equal to col2.
GROUP BY col1, col2
ORDER BY col1, col2;



-- Puzzle 2: Removing Rows with All Zeroes
-- Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.

SELECT A, B, C, D 
FROM TestMultipleZero
WHERE A != 0 OR B != 0 OR C != 0 OR D != 0            -- At least one column no equal to 0


-- Puzzle 3: Find those with odd ids

SELECT * 
FROM Section1
WHERE NOT ID % 2 = 0                         -- Making sure that the id is not divisible by 2.


-- Puzzle 4: Person with the smallest id (use the table in puzzle 3)

SELECT 
	TOP 1 *                                      -- Selecting top 1 row only based on sorting the id column in an ascending order.
FROM Section1
ORDER BY id ASC


-- Puzzle 5: Person with the highest id (use the table in puzzle 3)

SELECT 
	TOP 1 *                                      -- Selecting top 1 row only based on sorting the id column in an descending order.
FROM Section1
ORDER BY id DESC


-- Puzzle 6: People whose name starts with b (use the table in puzzle 3)

SELECT *
FROM Section1
WHERE LOWER(name) LIKE'b%'                              -- Filtering the name column that start with 'b' handling the case issue.



-- Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).

SELECT * 
FROM ProductCodes
WHERE Code LIKE '%[_]%'                                 -- Filtering the codes that contain '_', using '[]' brackets so that _ is considered as sign not a placeholder.