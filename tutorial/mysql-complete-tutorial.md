SQL, which stands for Structured Query Language, is a programming language that is used to communicate with and manage databases.

RDBMS stands for Relational Database Management System, RDBMS is the basis for SQL, and all modern database systems. The data in RDBMS is stored in database objects called tables. A table is a collection of related data entries and it consists of columns and rows.

A column is a vertical entity in a table. A record, also called a row, is each individual entry that exists in a table. A record is a horizontal entity in a table.

## SQL Syntax
Most of the actions you need to perform on a database are done with SQL statements. 
*SQL keywords are not case sensitive*

*Some DBMS require a semicolon at the end of each SQL statement. It is the standard way to  separate each SQL statement in DBMS that allows more than one SQL statement to be executed in the same call to the server*

## Languages
1. DDL (Data Definition Language): Defines, alters, or destroys the structure and schema of the database, cause an implicit commit, CREATE, ALTER, DROP, TRUNCATE.
2. DML (Data Manipulation Language): Manages, updates, and modifies the data inside the tables, INSERT, UPDATE, DELETE.
3. DQL (Data Query Language): Fetch or retrieve data from the database, SELECT
4. TCL (Transaction Control Language): Manages changes made by DML statements, COMMIT, ROLLBACK, SAVEPOINT
5. DCL (Data Control Language): Manages security, permissions, and access controls for database users, GRANT, REVOKE, 

## DATABASES
Databases are like the folders and tables are documents of the folder i.e., database

``` SQL
CREATE DATABASE database_name;

SHOW DATABASES;

USE database_name;

ALTER DATABASE database_name READ ONLY = 1;

DROP DATABASE database_name;
```


*You need administrative privileges to create, drop a database*

- The CREATE DATABASE statement is used to create a new SQL database
- The SHOW DATABASES lists all the databases available
- We have to USE database before working on it, or can also set it default schema for using it
- When we set database to read only we are not able to drop it
- The DROP DATABASE statement is used to permanently delete an existing SQL database

*Be careful before dropping a database, it deletes the databases and all its content (tables, views, stored procedures, and data)*

- The BACKUP DATABASE statement is used in SQL Server to create a full backup of an existing SQL database
- A differential backup only captures the data that has changed since the last full backup, it requires at least one prior backup

``` SQL
-- SQL Server syntax, not MySQL:
BACKUP DATABASE databasename TO DISK = 'filepath';

-- SQL Server syntax, not MySQL:
BACKUP DATABASE databasename TO DISK = 'filepath' WITH DIFFERENTIAL;
```

In MySQL, use `mysqldump`, MySQL Shell, or your hosting provider's backup system instead of `BACKUP DATABASE`.

*Always place backup database in a different drive than the original database, if you get a disk crash, you will not lose your backup file along with the database*

*A differential backup reduces the backup time (since only the changes are backed up)*

## TABLES

``` SQL
CREATE TABLE table_name(
	column1 datatype constraint,
	column2 datatype constraint,
	column3 datatype constraint,
	....
);
```

The CREATE TABLE statement is used to create a new table in a database
- The table_name parameter specifies the name of the new table
- The datatype parameter specifies the datatype of each column
- The constraint parameter is optional, and specifies rules for data integrity

``` SQL
CREATE TABLE new_table AS SELECT column1, column2, ... FROM existing_table WHERE ...;
```

Here we are creating a new table that copies some/all data from an existing table. 

``` SQL
DROP TABLE IF EXISTS table_name;
```

The DROP TABLE statement is used to permanently delete an existing table in a database, to prevent an error (if the table does not exists) it is a good practice to add the IF EXISTS clause

*In most databases you cannot drop a table that is referenced by a foreign key constraint in another table. To solve this, you must remove the foreign key constraint or drop the dependent table*

``` SQL
TRUNCATE TABLE table_name;
```

The truncate table statement is used to delete all the records in a table, but keeps the table structure, columns and constraints

``` SQL
ALTER TABLE table_name ADD column_name datatype;

ALTER TABLE table_name DROP COLUMN column_name;

ALTER TABLE table_name RENAME COLUMN old_name TO new_name;

ALTER TABLE table_name MODIFY COLUMN column_name new_datatype constraint;

ALTER TABLE table_name ADD CONSTRAINT constraint_name constraint_definition;
ALTER TABLE employees ADD CONSTRAINT CHK_Age CHECK (Age >= 18);

ALTER TABLE table_name RENAME TO new_table_name;

ALTER TABLE table_name MODIFY COLUMN column_name datatype AFTER/FIRST another_column_name; 
-- This is how we reorder columns
```

Some common ALTER TABLE operations are:
- Add column
- Drop column
- Rename column
- Modify column
- Add constraint
- Rename table
- Reorder the column in a table

## Inserting Data
The INSERT INTO statement is used to insert new records in two ways:

``` SQL
INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, values2, values3, ...);

INSERT INTO table_name VALUES (value1, value2, value3, ...);

INSERT INTO table_name VALUES (row1_values, ...), (row2_values, ...), ...;
```

- When we want to insert data only in specific columns, we use the first syntax where where we specify columns in which we want to enter the data, and the values in same order for those columns, the fields for which values are not provided will be set null or default .
- For inserting multiple rows, we use the same INSERT INTO statement, but with multiple values parenthesis.

## SQL Select Statement
The SELECT statement is used to select data from a database.

``` SQL
SELECT column1, column2, ... FROM table_name;

SELECT * FROM table_name;
-- To select all from the table
```

The order of the columns in SELECT command defines the order in which the values will retrieved and displayed.
The WHERE clause is used to filter records, used to extract only those records that fulfill a specific condition

``` SQL
SELECT column1, column2, ... FROM table_name WHERE condition;
```

*The WHERE clause is not only used in SELECT statements, it is also used in update, delete, etc.*

- SQL requires single quotes around text values (most DBMS would also allow double quotes) but numeric fields should not be enclosed in quotes.
- Operators like = (Equal), > (Greater than), < (Less than), >= (Greater than or equal), <= (Less than or equal), <> or != (not equal), BETWEEN (between a certain range), LIKE (Search for a pattern) and IN (To specify multiple possible values for a column) can be used in the WHERE clause.

The SELECT DISTINCT statement is used to return only distinct (unique) values

``` SQL
SELECT DISTINCT column1, column2, ... FROM table_name;

SELECT COUNT(DISTINCT column_name) FROM table_name;
```

By using the COUNT() function with the DISTINCT() keyword, we can count the number of unique entries.
*The COUNT(DISTINCT column_name) is not supported in Microsoft access databases*

## SQL Update and Delete
THE UPDATE statement is used to update or modify one or more records in a table

``` SQL
UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition; 
```

*The WHERE clause specifies which record(s) should be updated. If you omit the WHERE clause, all records in the table will be updated*.

The DELETE statement is used to delete existing records in a table.

``` SQL
DELETE FROM table_name WHERE condition;
```

*The WHERE clause specifies which record(s) should be deleted, If you omit the WHERE clause, all records in the table will be deleted*.

To delete the table completely, use the DROP TABLE statement

``` SQL
DROP TABLE table_name;
```

*You have to turn safe mode off on some DBMS while executing these queries*

## Auto Commit, START TRANSACTION COMMIT, SAVEPOINT and ROLLBACK
- In many DBMSs, **AUTOCOMMIT is enabled by default**.
- When AUTOCOMMIT is ON, every SQL statement is treated as a separate transaction and is automatically saved to the database.
- Because changes are committed immediately, they **cannot be rolled back** once executed.

```sql
SET AUTOCOMMIT = OFF;
```

- After turning AUTOCOMMIT OFF, changes are **not permanently saved** until a COMMIT command is executed.
- You can use SELECT @@AUTOCOMMIT; the value this statement return tell us about the current status of AUTOCOMMIT.
- START TRANSACTION temporarily turns off your databases safety off switch (AUTOCOMMIT) and creates an isolated, private buffer for your queries
- **In Databases like MySQL Data Definition Language (DDL) statements like ALTER, DROP, CREATE and TRUNCATE trigger an automatic, invisible commit. **
- This gives more control over transactions and allows recovery from mistakes.
- The **COMMIT** command permanently saves all changes made in the current transaction.
- SAVEPOINT creates temporary placeholder that allows you to undo a specific part of your work without closing the transaction

``` SQL
SAVEPOINT inventory_secured;
ROLLBACK TO SAVEPOINT inventory_secured;
```

- Once committed, the changes become visible to other users (depending on the DBMS) and **cannot be undone using ROLLBACK**.

```sql
COMMIT;
```

- Create a new safe point from which future rollbacks can occur.
- The **ROLLBACK** command undoes all changes made since the last COMMIT.
- It restores the database to the most recently committed state.

```sql
ROLLBACK;
```

## SQL Constraints
SQL constraints are rules for data in a table. Constraints are used to prevent insertion of invalid data in a table, and ensures the accuracy and reliability of the data in the table. If there is any violation between the constraint and the data action, the action is aborted.

Constraints can be specified in two ways:
- When a table is created (through the CREATE TABLE statement)
- After a table is created (through the ALTER TABLE statement)

The following constraints are commonly used in SQL:
- NOT NULL : Ensures that a column cannot have a NULL value

``` SQL
CREATE TABLE Persons (
	ID INT NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Age INT
);

ALTER TABLE Persons MODIFY COLUMN Age INT NOT NULL;

ALTER TABLE Persons MODIFY COLUMN Age INT NULL;
```

If a field in a table is optional, it is possible to insert or update a record without adding any value to this field. This way, the field will be saved with a NULL value, it basically represents an unknown, missing or inapplicable data in a database field. It is not a value itself but instead a placeholder to indicate the absence of data.
*It is different from zero (0) or an empty string("")* 
**It is not possible to test for NULL values with comparison operators, such as =, <, or <>. We will have to use the IS NULL and IS NOT NULL operators instead**

``` SQL
SELECT column_names FROM table_name WHERE column_name IS NULL;
SELECT column_names FROM table_name WHERE column_name IS NOT NULL;
```

*Always use IS NULL to look for NULL values*

- UNIQUE : Ensures that all values in a column are unique

``` SQL
CREATE TABLE Persons (
	ID int NOT NULL UNIQUE,
	Name VARCHAR(50) NOT NULL,
	Age int
);

CREATE TABLE Persons (
	ID int NOT NULL,
	Name VARCHAR(50) NOT NULL,
	Age int,
	CONSTRAINT UC_Person UNIQUE (ID, Name)
);

ALTER TABLE Persons ADD UNIQUE (ID);

ALTER TABLE Persons ADD CONSTRAINT UC_Person UNIQUE (ID, Name);

ALTER TABLE Persons DROP INDEX UC_Person;
```


**If we first create a table and specify UNIQUE constraint on a column there then try doing it again with ALTER statement on same column, it results in creating another unique index on same column with name column_name_2**

*We can name a unique constraint and also define a UNIQUE constraint on multiple columns*
*Index is created for unique column to add checking whole database and facilitate quick checks on the column in MySQL*
MODIFY COLUMN can not be used to add UNIQUE constraint to columns as that keyword is used to change Data Type, Length, NULL/NOT NULL, Default Value only.
So we can only state UNIQUE constraint with column when we are creating table, all other times it will be added on Table as separate index gets created for it, and while using CREATE keyword DBMS handles creating index also.

- PRIMARY KEY : Uniquely identifies each row in a table (a combination of a NOT NULL and UNIQUE)
*A table can only have one PRIMARY KEY constraint, it can be either single column or combination of columns, the primary key is the target for FOREIGN KEY constraints in other tables*

``` SQL
CREATE TABLE Persons (
	ID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Age INT
);

CREATE TABLE Persons (
	ID INT,
	Name VARCHAR(50),
	Age INT,
	PRIMARY KEY (ID, Name) 
);

CREATE TABLE Persons (
	ID INT,
	Name VARCHAR(50),
	Age INT,
	CONSTRAINT PK_Person PRIMARY KEY (ID, Name)
);

ALTER TABLE Persons ADD PRIMARY KEY (ID);

ALTER TABLE Persons ADD CONSTRAINT PK_Person PRIMARY KEY (ID, Name);

ALTER TABLE Persons DROP PRIMARY KEY;
```

This show how you can create primary key, primary made of multiple columns (with/without name) and altering table to do and at the end dropping PRIMARY KEY constraint.
This here also creates a index so we have to ADD it and can not modify column to add it.

- FOREIGN KEY : Establishes a link between data in two tables, and prevents action that will destroy the link between them. A FOREIGN KEY is a column in a table that refers to the PRIMARY KEY in another table. 
The table with foreign key column is called the child table, and the table with the primary key column is called the referenced or parent table. 
This constraint prevents invalid data from being inserted intro the foreign key column (in the child table), because the value has to exist in the parent table.
This constraint also prevents you from deleting a record in the parent table, if related rows still exist in the child table.

``` SQL
CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	PersonID INT,
	CONSTRAINT fk_Person FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

ALTER TABLE Orders ADD CONSTRAINT fk_Person FOREIGN KEY (PersonID) REFERENCES Persons(PersonsID);

ALTER TABLE Orders DROP FOREIGN KEY fk_Person;
```

While setting up FOREIGN KEY we have a option between 2 clause that we can add
1. ON DELETE SET NULL: When a FK is deleted, replace the FK with NULL
2. ON DELETE CASCADE: When a FK is deleted, delete row

``` SQL
-- For turning foreign key checks off, when delete after this without setting any clause the row in table will refer to same old values which may not exist  
SET foreign_key_checks = 0;

ALTER TABLE transactions ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;
ALTER TABLE transactions ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
```

- CHECK : Ensures that the value for a column satisfies a specific condition

``` SQL
CREATE TABLE Persons (
	ID INT PRIMARY KEY,
	Name VARCHAR(50),
	Age INT,
	CONSTRAINT chk_PerosonAge CHECK (Age >= 18)
);

ALTER TABLE Persons ADD CHECK (Age >= 18);

ALTER TABLE Persons ADD CONSTRAINT chk_PersonsAge CHECK (Age >= 18 AND Name != "Andrew Wilson");

ALTER TABLE Persons DROP CHECK chk_PersonAge;
```

This shows how you can create CHECK constraint, we can also name them and have multiple checks using AND, OR etc.

- DEFAULT : Sets a default value for a column if no values is specified

``` SQL
CREATE TABLE Persons(
	ID int PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Age INT,
	City VARCHAR(50) DEFAULT 'Sandes'
);

CREATE TABLE Orders (
	ID int PRIMARY KEY,
	OrderNumber INT NOT NULL,
	OrderDate DATE DEFAULT CURRENT_DATE()
);

ALTER TABLE Persons ALTER City SET DEFAULT 'Sandes';

ALTER TABLE Persons ALTER City DROP DEFAULT;
```

The DEFAULT constraint can also be used to insert system values, by using functions like CURRENT_DATE() to insert the current date.
*When using default constraint, once you have set default values from one or more column then while inserting values for the rest which are not default we have to specify specifically for which columns are we inserting values or else it will recognize for which columns are the values being provided and for which default values are to considered.*

- CREATE INDEX : Creates indexes on columns to retrieve data from the database faster

Indexes are used to find values within a specific column more quickly, MySQL normally searches sequentially through a column, The longer the column, the more expensive the operation is.

UPDATE TAKES MORE time, SELECT takes less time

*Updating tables with indexes are more time-consuming than tables without indexes (because the indexes must also be updated). So only create indexes on columns that are frequently searched against*

*We can also have multi column indexes where the order of column matters*

There are two types of Indexes
- CREATE INDEX : Creates a non-unique index (duplicate values are allowed)
- CREATE UNIQUE INDEX : Creates a unique index (duplicate values are not allowed)

``` SQL
CREATE INDEX index_name ON table_name (column1, column2, ...);

CREATE UNIQUE INDEX index_name ON table_name (column1, column2, ...);

ALTER TABLE table_name DROP INDEX index_name;
```

- AUTO_INCREMENT :  This field is a numeric column that automatically generates a unique number, when a new record is inserted into a table. The auto-incremented field is typically the PRIMARY KEY field that we want to automatically be assigned a unique number, every time a new record is inserted.
``` SQL
CREATE TABLE Persons(
	PersonId INT AUTO_INCREMENT PRIMARY KEY,
	LastName VARCHAR(50) NOT NULL,
	FirstName VARCHAR(50),
	Age INT
);

-- The default starting value for AUTO_INCREMENT is 1, and it will increment by 1 for each new record. To let AUTO_INCREMENT start with another value, use 
ALTER TABLE Persons AUTO_INCREMENT = 100;

-- When we insert a new record into the "Persons" table, we will NOT have to specify a value for the "PersonId" column (a unique value will be added automatically)
INSERT INTO Persons (FirstName, LastName) VALUES ("Lars", "Monsen");
```

## SQL Joins
The JOIN clause is used to combine rows from two or more tables, based on a related column between them.
- (INNER) JOIN : Returns only rows that have matching values in both tables (intersection)
*We can use just JOIN instead of INNER JOIN, as INNER is the default join type*

``` SQL
SELECT column_name(s) FROM table1 INNER JOIN table2 ON table1.column_name = table2.column_name;
```

*The syntax combines two tables based on a related column, and the ON keyword is used to specify the matching condition*
**It is good practice to also include the table name when specifying columns in SQL joins**

``` SQL
SELECT Products.ProductID, Products.ProductName, Categories.CategoryName FROM Products INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;
```

You can also JOIN more than two tables by adding multiple INNER JOIN clauses in your query.

``` SQL
SELECT Order.OrderID, Customers.CustomerName, Shippers.ShipperName FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;
```

- LEFT (OUTER JOIN) : Return all rows the left table, and only the matched rows from the right table (LEFT complete + RIGHT intersection), If there is no match in the right table, the result for the columns from the right table will be NULL
*The Keywords LEFT JOIN and LEFT OUTER JOIN are equal - the OUTER keyword is optional*

``` SQL
SELECT column_name(S) FROM table1 LEFT JOIN table2 ON table1.column_name = table2.column_name;

-- To find only the customers who have not placed any order, add a WHERE clause to filter for NULL value on the right table
SELECT Customers.CustomerName, Orders.OrderID FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID WHERE Orders.CustomerID IS NULL;
```

- RIGHT (OUTER JOIN) : Returns all rows from the right table, and only the matched rows from the left table (RIGHT complete + LEFT intersection), if there is no match in the left table, the result for the columns from the left table will be NULL.
*The RIGHT JOIN and RIGHT OUTER JOIN keywords are equal - the OUTER keyword is optional*

``` SQL
SELECT column_name FROM table1 RIGHT JOIN table2 ON table1.column_name = table2.column_name;
```

*The thing about right join or left join is that both are similar in a manner as we can only stick to one and get both sides result by just reordering tables. *

- FULL (OUTER) JOIN : Returns all rows when there is a match in either the left or right table. If a row in the left table has no match in the right table, the result set includes the left row's data and NULL values for all columns of the right table. If a row in the right table has no match in the left table, the result set includes the right row's data and NULL values for all columns of the left table. 
*The FULL JOIN and FULL OUTER JOIN keywords are equal - the OUTER keyword is optional, FULL JOIN can potentially return very large result-sets.*

``` SQL
SELECT column_name(s) FROM table1 FULL JOIN table2 ON table1.column_name = table2.column_name WHERE condition;
```

*MySQL does not support the FULL JOIN syntax at all, to get the exact same result as a FULL JOIN in MYSQL, you have to use a UNION operator to combine a LEFT JOIN and a RIGHT JOIN*

- Self Join : A self join is a regular join, but the table is joined with itself, here using alias is must to clarify what columns to fetch from which tables.

``` SQL
SELECT column_name(s) FROM table1 T1, table1 T2 WHERE condition;
```

## Logical Operators

- *The AND operator displays a record if all conditions are TRUE*

``` SQL
SELECT column1, column2, ... FROM table_name WHERE condition1 AND condition2 AND condition3 ...;
```

- *The OR operator displays a record if any of the conditions are TRUE*

``` SQL
SELECT column1, column2, ... FROM table_name WHERE condition1 OR condition2 OR condition3 ...; 
```

- *The NOT operator is used in the WHERE clause to return all records that DO NOT match the specified criteria*
The NOT operator is also used in combination with other operators to exclude data, such as:
- NOT LIKE
- NOT BETWEEN
- NOT IN
- IS NOT NULL
- NOT EXISTS

``` SQL
SELECT column1, column2, ... FROM table_name WHERE NOT condition;
```

- *The IN operator is used in the WHERE clause to check if a specified column's value matches any value within a provided list,  basically a shorthand for multiple OR conditions, making queries shorter and more readable*

``` SQL
SELECT column_name(s) FROM table_name WHERE column_name IN (value1, value2, ...);

-- NOT IN
SELECT * FROM Customers WHERE Country NOT IN ("Germany", "France", "UK");

-- IN (SELECT)
SELECT * FROM Customers WHERE CustomerID IN (SELECT CustomerID FROM Orders);

-- NOT IN (SELECT)
SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);
```

- *The BETWEEN operator is used in the WHERE clause to select values within a specified range.*
The range is **inclusive**. 

``` SQL
SELECT column_name(s) FROM table_name WHERE column_name BETWEEN value1 AND value2;

-- NOT BETWEEN
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;

-- BETWEEN with IN
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20 AND CategoryID IN (1, 2, 3);

-- BETWEEN Text Values
SELECT * FROM Products WHERE ProductName BETWEEN "Geitost" AND "Louisiana Hot Spiced Okra" ORDER BY ProductName;

-- NOT BETWEEN Text Value
SELECT * FROM Products WHERE ProductName NOT BETWEEN "Geitost" AND "Louisiana Hot Spiced Okra" ORDER BY ProductName;

-- Between Dates
SELECT * FROM Orders WHERE OrderDate BETWEEN "1996-07-01" AND "1996-07-31";
```

## SQL Aliases
An alias is created with the AS keyword, and is often used to make a column name more readable. An alias only exists for the duration of that query.

``` SQL
-- Alias for column
SELECT column_name AS alias_name FROM table_names;

-- Alias for table
SELECT column_name(s) FROM table_name AS alias_name;

-- If an alias contains spaces in MySQL, wrap it in backticks.
SELECT ProductName AS `My Great Products` FROM Products;
```

*Some databases systems allows both [] and "", and some allows one of them*

``` SQL
-- Concatenate Columns
SELECT CustomerName, CONCAT(Address, ', ', Postal Code, ', ', City, ', ', Country) AS Address FROM Customers;

-- Simplyfy stuff
SELECT c.CustomerName, o.OrderID FROM customers AS c JOIN orders AS o ON c.customerId = o.customerID; 
```

Aliases are useful when:
- There are more than one table involved in a query
- Functions are used in the query
- Column names are long or not very readable
- Two or more columns are combined together

## SQL Wildcards
A wildcard character is used to substitute one or more characters in a string. Wildcard characters are used with the LIKE operator. The LIKE operator is used in a WHERE clause to search for a specified pattern in a column.

- % : Represents zero or more characters
- _ : Represents a single character

``` SQL
-- Return all customers that ends with the pattern 'es'
SELECT * FROM Customers WHERE CustomerName LIKE "%es";
-- Return all customers that contains the pattern 'mer'
SELECT * FROM Customers WHERE CustomerName LIKE "%mer%";

-- Return all customers with a City starting with any character, followed by "ondon"
SELECT * FROM Customers WHERE City LIKE "_ondon";
-- Return all customers with a City starting with "L", followed by any 3 characters, ending with "on"
SELECT * FROM Customers WHERE City LIKE "L___on";

-- Return all customers that starts with "a" and are at least 3 character in length
SELECT * FROM Customers WHERE CustomerName LIKE "a__%";
-- Return all customers that have "r" in the second position
SELECT * FROM Customers WHERE CustomerName LIKE "_r%";
```

## SQL ORDER BY 
The ORDER BY keyword is used to sort the result-set in ascending or descending order. The ORDER BY keyword sorts the result-set in ascending order (ASC) by default.

``` SQL 
SELECT column1, column2, ... FROM table_name ORDER BY column1, column2, ... ASC|DESC;

-- Order by Several Columns
SELECT * FROM Customers ORDER BY Country, CustomerName;
-- Combine ASC and DESC
SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;
```

Now when we are ordering by several columns then if there are same values in column1 then it will sort in according to the column2 DESC or AESC what ever is provided

## SQL Limit
The LIMIT clause is used to limit the number of records to return. Can be used to display a large data on pages (pagination).

``` SQL 
SELECT column_name(s) FROM table_name WHERE condition LIMIT number;

-- OFFSET
SELECT * FROM Customers LIMIT 3 OFFSET 3;
SELECT * FROM Customers LIMIT 3, 3;

-- 2nd Highest salary
SELECT * FROM Employees ORDER BY Hourly_Pay DESC LIMIT 1 OFFSET 1;
```

## SQL UNION
The UNION operator is used to combine the result-set of two or more SELECT statements. The UNION operator automatically removes duplicate rows from the result set
Requirements for UNION:
- Every SELECT statement within UNION must have the same number of columns
- The columns must also have similar data types
- The columns in every SELECT statement must also be in the same order

``` SQL
SELECT column_name(s) FROM table1 
UNION 
SELECT column_name(s) FROM table2;
```

* The column names in the result set are usually equal to the column names in the first SELECT statement*
* The UNION ALL operator includes all rows from each statement, including any duplicates

## SQL VIEWS
An SQL view is a virtual table based on the result-set of an SQL statement. An SQL view contains rows and columns, just like a real table. The fields in the view are fields from one or more real tables in the database.
You can add SQL statements and functions to a view and present the data as if it were coming from one single table.

``` SQL
-- CREATE VIEW
CREATE VIEW view_name AS SELECT column1, column2, ... FROM table_name WHERE condition;

-- Update VIEW
CREATE OR REPLACE VIEW view_name AS SELECT column1, column2, ... FROM table WHERE condition;

-- DROP VIEW
DROP VIEW view_name;
```

*A view always shows real-time data. The database engine only stores the view's definition (the SELECT statement), not the copy of the data*

**SQL Subqueries is a query nested inside another SQL query. It allows complex filtering, aggregation, and data manipulation by using the result of one query inside another.** 

``` SQL
-- Finding students whose score is higher than average score
SELECT * FROM Students WHERE Score > (SELECT AVG(Score) FROM Students);
```

## SQL GROUP BY
The GROUP BY statement is used to group rows that have the same values into summary rows, like "Find the number of customers in each country". The GROUP BY statement in almost always used in conjunction with aggregate functions, like COUNT(), SUM(), AVG(), MAX(), MIN(), to perform calculations on each group

``` SQL
SELECT column1, aggregate_function(column2), column3, ... FROM table_name WHERE condition GROUP BY column1, column3 ORDER BY column_name;

-- WITH ROLLUP
SELECT column, aggregate_function(column) FROM table GROUP BY column1, column2 WITH ROLLUP;
```

*The ROLLUP operator enhances the capabilities of the group by clause by enabling the computation of subtotals and grand totals for a set of columns. It produces a results set that incorporates rows at various levels of aggregation*

## The Logical Order of Execution
1. FROM / JOIN: Gathers raw tables before apply filters
2. WHERE: Drops unneeded rows early to optimize memory
3. GROUP BY: Organizes remaining records for aggregate
4. HAVING: Filters groups (cannot use WHERE on group calculations)
5. SELECT: generates outputs and computes your column names
6. DISTINCT: removes matching row duplicates from the selected data
7. ORDER BY: sorts the finalized clean records 
8. LIMIT / OFFSET: Cuts down the final table size for end-user

## SQL Stored Procedure
A stored procedure is a precompiled SQL code that can be saved and reused. If you have an SQL query that you write over and over again, save it as stored procedure, and then just call it to execute it.
A stored procedure can also have parameters, so it can act based on the parameter value(s) that is passed.

Key Benefits of stored procedures
- Code Reusability
- Improved Performance
- Database Security
- Easy Maintenance

``` SQL
DELIMITER $$
CREATE PROCEDURE procedure_name(IN param1 datatype, IN param2 datatype)
BEGIN
	-- SQL statements to be executed
	SELECT column1, column2 FROM table_name WHERE columnN = paramN;
END $$
DELIMITER ;

-- OR

DELIMITER //  
CREATE PROCEDURE _procedure_name_  
  _@param1 datatype_,  
  _@param2 datatype_  
BEGIN  
  -- SQL_statements to be executed  
  SELECT _column1_, _column2_  
  FROM _table_name_  
  WHERE _columnN_ = _@paramN_;  
END //  
DELIMITER;

-- Execute a stored procedure
CALL procedure_name("value1", "value2");
DROP PROCEDURE IF EXISTS procedure_name;
```

## SQL Trigger
