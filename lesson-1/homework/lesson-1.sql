-- ===================
-- I. EASY
-- ===================


-- 1. DEFINE THE FOLLOWING TERMS: DATA, DATABASE, RELATIONAL DATABASE, TABLE

- DATA: Raw, unprocessed facts and figures. It can be any collection of characters, 
numbers, symbols, images, or sounds. It's the basic building blocks of information.

- DATABASE: A database is an organized collection of data, designed for efficient storage, retrieval, and management. 
It allows users to store and access large amounts of information in a structured way.

- RELATIONAL DATABASE: A relational database is a type of database that organizes data into one or more tables with defined 
relationships between them. These relationships are established using keys, allowing for efficient data retrieval and manipulation.

- TABLE: In a relational database, a table is a structure that organizes data into rows and columns. Each row represents a 
record, and each column represents a specific attribute of that record. 

-- 2. LIST FIVE KEY FEATURES OF SQL SERVER.

- High Performance and Scalability
- Advanced Security Features
- Business Intelligence and Analytics
- High Availability and Disaster Recovery
- Advanced Query Processing and Optimization

-- 3. WHAT ARE THE DIFFERENT AUTHENTIFICATION MODES AVAILABLE WHEN CONNECTING TO SQL SERVER (Give at least 2)?

- Windows Authentification Mode: 
- SQL Server Authentication Mode


-- ===================
-- II. MEDIUM
-- ===================

-- 4. Create a new database in SSMS named SchoolDB.

CREATE DATABASE SchoolDB;

-- 5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).

CREATE TABLE Students (
  StudentID INT PRIMARY KEY,
  Name VARCHAR(50),
  Age INT );

-- 6. Describe the differences between SQL Server, SSMS, and SQL.

    SQL Server is the database engine that manages the data.
    SSMS is the tool that's used to interact with SQL Server, manage databases, and execute queries.
    SQL is the language you use within SSMS (or other tools) to query and manipulate the data stored in SQL Server.



-- ===================
-- III. HARD
-- ===================


-- 7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

==============================================================================================
DQL (Data Query Language) 

Commands: SELECT
DQL is used to query or retrieve data from the database.

Example:

SELECT * FROM Students;    -- Retrieves all the columns from Students table


-- ==============================================================================================
DML (Data Manipulation Language) 

Commands: INSERT, UPDATE, DELETE
DML (INSERT) adds new record to a table, (UPDATE) modifies existing records in a table, (DELETE) removes records from a table.

Example:

INSERT INTO Students (StudentID, Name, AGE) VALUES (1, 'Timur', 34)
UPDATE Students SET AGE = 35 WHERE StudentID = 1;
DELETE FROM Students WHERE StudentID = 2;


-- ==============================================================================================
DDL (Data Definition Language) 

Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME
DDL (CREATE) creates new database object, (ALTER) modifies the structure of an existing table, (DROP) deletes a database object, (TRUNCATE) removes all rows from a table without changing the table structure.

Example:

CREATE TABLE Employees (EmployeeID INT PRIMARY KEY, Name VARCHAR(50), Salary DECIMAL(9, 2);
ALTER TABLE Employees ADD Email VARCHAR(100);
DROP VIEW Demographics;
TRUNCATE TABLE Employees;


-- ==============================================================================================
DCL (Data Control Language) 

Commands: GRANT, REVOKE
DCL (GRANT) gives specific privileges or permissions to a user or role, (REVOKE) removes previously granted privileges or permissions from a user or role.

Example: 

GRANT SELECT ON Employees TO Bill;
REVOKE SELECT ON Employees FROM Bill;


-- ==============================================================================================
TCL (Transaction Control Language) 

Commands: COMMIT, ROLLBACK, SAVEPOINT, SET TRANSACTION.
TCL (COMMIT) saves all changes made during the current transaction to the database permanently, (ROLLBACK) undoes all changes made during the current transaction, 
restoring the database to its state before the transaction began, (SAVEPOINT) creates a point within a transaction to which you can later roll back without affecting 
the entire transaction, (SET TRANSACTION) configures the properties of a transaction, such as its isolation level.

Example: 

SAVEPOINT BeforeUpdate;
  
UPDATE Employees
SET Salary = Salary + 100
WHERE EmployeeID = 2;

-- If everything is fine, commit the changes
COMMIT;

-- If there's an issue, rollback the changes
ROLLBACK TO BeforeUpdate;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


-- 8. Write a query to insert three records into the Students table.

INSERT INTO Students VALUES
  (1, 'Timur', 34),
	(2, 'John', 24),
	(3, 'Robert', 35);

-- 9. Create a backup of your SchoolDB database and restore it. (write its steps to submit)



===> CREATING A BACKUP OF SchoolDB:

Method 1: Using SQL Server Management Studio (SSMS) GUI

1. Open SSMS and connect to your SQL Server instance
2. Expand Databases in Object Explorer
3. Right-click on SchoolDB → Tasks → Back Up...
4. In the Backup dialog:
  - Backup type: Full
  - Backup component: Database
  - Destination: Click Add to specify file location (e.g., C:\Backups\SchoolDB_Backup.bak)
5. Click OK to execute the backup
6. Verify backup completed successfully in the Messages tab

Method 2: Using T-SQL Command 

BACKUP DATABASE SchoolDB 
TO DISK = 'C:\Backups\SchoolDB_Backup.bak'
WITH 
   COMPRESSION,
   STATS = 10,
   NAME = 'SchoolDB-Full Backup';
GO


====> RESTORING SchoolDB

Method 1: Using SSMS GUI

1. Open SSMS and connect to your SQL Server instance
2. Right-click Databases → Restore Database...
3. In the Restore dialog:
  - Source: Select "Device" and click the browse (...) button
  - Add your backup file (SchoolDB_Backup.bak)
  - Select the backup set to restore
4. In the Options page:
  - Check "Overwrite the existing database"
  - Verify file paths for data and log files
5. Click OK to execute the restore
6. Verify restore completed successfully

Method 2: Using T-SQL Command 

USE [master]
GO

RESTORE DATABASE SchoolDB 
FROM DISK = 'C:\Backups\SchoolDB_Backup.bak'
WITH 
   MOVE 'SchoolDB' TO 'C:\Data\SchoolDB.mdf',
   MOVE 'SchoolDB_Log' TO 'C:\Data\SchoolDB_Log.ldf',
   REPLACE,
   STATS = 10;
GO


     
