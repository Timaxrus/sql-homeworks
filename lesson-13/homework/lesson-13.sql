-------------> Beginner Level (10 Puzzles)

-- 1. Extract a Substring → Extract the first 4 characters from 'DATABASE'.

SELECT SUBSTRING('DATABASE', 1, 4) AS extracted_string;

-- 2. Find Position of a Word → Find position of 'SQL' in 'I love SQL Server'.

SELECT CHARINDEX('SQL', 'I love SQL server') AS word_pos;
  
-- 3. Replace a Word → Replace 'World' with 'SQL' in 'Hello World'.

SELECT REPLACE('Hello World', 'World', 'SQL') AS replaced_word;

-- 4. Find String Length → Find length of 'Microsoft SQL Server'.

SELECT LEN('Microsoft SQL server') AS length;

-- 5. Extract Last 3 Characters → Get last 3 characters from 'Database'.

SELECT RIGHT('Database', 3) AS last_three_char;

-- 6. Count a Character → Count occurrences of 'a' in 'apple', 'banana', 'grape'.

SELECT LEN('apple, banana, grape') - LEN(REPLACE('apple, banana, grape', 'a', '')) AS char_num;

-- 7. Remove Part of a String → Remove first 5 characters from 'abcdefg'.

SELECT STUFF('abcdefg', 1, 5, '') AS five_char_removed; 

-- 8. Extract a Word → Extract second word from 'SQL is powerful', 'I love databases'.

SELECT 
TRIM(SUBSTRING('SQL is poweful', CHARINDEX(' ', 'SQL is poweful')+1, CHARINDEX(' ', 'SQL is poweful', 
CHARINDEX(' ', 'SQL is poweful')+1) -CHARINDEX(' ', 'SQL is poweful')-1)) AS second_word1;

SELECT 
TRIM(SUBSTRING('I love databases', CHARINDEX(' ', 'I love databases')+1, CHARINDEX(' ', 'I love databases', 
CHARINDEX(' ', 'I love databases')+1) -CHARINDEX(' ', 'I love databases')-1)) AS second_word2;

-- 9. Round a Number → Round 15.6789 to 2 decimal places.

SELECT ROUND(15.6789,2) AS rounded_value;

-- 10. Absolute Value → Find absolute value of -345.67.

SELECT ABS(-345.67) AS abs_value;
