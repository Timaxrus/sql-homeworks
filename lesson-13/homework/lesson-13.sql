-------------> Beginner Level (10 Puzzles)

-- 1. Extract a Substring → Extract the first 4 characters from 'DATABASE'.

SELECT SUBSTRING('DATABASE', 1, 4) AS extracted_string;

-- 2. Find Position of a Word → Find position of 'SQL' in 'I love SQL Server'.

SELECT CHARINDEX('SQL', 'I love SQL server');
  
-- 3. Replace a Word → Replace 'World' with 'SQL' in 'Hello World'.

SELECT REPLACE('Hello World', 'World', 'SQL');

-- 4. Find String Length → Find length of 'Microsoft SQL Server'.

SELECT LEN('Microsoft SQL server');

-- 5. Extract Last 3 Characters → Get last 3 characters from 'Database'.

SELECT RIGHT('Database', 3);

-- 6. Count a Character → Count occurrences of 'a' in 'apple', 'banana', 'grape'.

SELECT LEN('apple, banana, grape') - LEN(REPLACE('apple, banana, grape', 'a', ''));

-- 7. Remove Part of a String → Remove first 5 characters from 'abcdefg'.

SELECT STUFF('abcdefg', 1, 5, ''); 

-- 8. Extract a Word → Extract second word from 'SQL is powerful', 'I love databases'.


9️⃣ Round a Number → Round 15.6789 to 2 decimal places.
🔟 Absolute Value → Find absolute value of -345.67.
