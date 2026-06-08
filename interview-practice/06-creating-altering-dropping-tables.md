# 1. Creating Tables

You create a new table using `CREATE TABLE`. A table schema defines:

- Column names    
- Data types    
- Constraints (PRIMARY KEY, UNIQUE, NOT NULL, etc.)    
- Default values    

## Syntax

```sql
CREATE TABLE IF NOT EXISTS mytable (
    column_name DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value
);
```

`IF NOT EXISTS` prevents errors if the table already exists.

---

## Common Data Types

|Type|Description|
|---|---|
|INT, BIGINT, BOOLEAN|Whole numbers. MySQL stores `BOOLEAN` as a tiny integer alias.|
|DECIMAL(p,s), FLOAT, DOUBLE|Use `DECIMAL` for money and exact values; floating-point types are approximate.|
|CHAR(n), VARCHAR(n), TEXT|Character data. `CHAR` is fixed-length, `VARCHAR` is variable-length with a max limit, and `TEXT` stores large strings.|
|DATE, DATETIME|Store calendar dates and timestamps. Useful for logs, time-series, events.|
|BLOB|Binary data like images or files. Stored as raw bytes.|

---

## Common Table Constraints

|Constraint|Meaning|
|---|---|
|PRIMARY KEY|Unique identifier for each row. Values must be unique and not NULL.|
|AUTO_INCREMENT|MySQL auto-generated increasing integer.|
|UNIQUE|All values in the column must be unique.|
|NOT NULL|Value cannot be NULL.|
|CHECK (expression)|Custom rule for validation (e.g., salary > 0).|
|FOREIGN KEY|Ensures values match a primary key in another table, enforcing relational integrity.|

---

## Example: Movies table

```sql
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    director VARCHAR(255),
    release_year INT,
    length_minutes INT
);
```

---

# 2. Altering Tables (ALTER TABLE)

As your application grows, you might need to adjust a table’s structure. `ALTER TABLE` lets you add, remove, or rename columns, and even rename the table itself.

## A. Adding columns

```sql
ALTER TABLE mytable
ADD new_column DataType OptionalConstraint DEFAULT default_value;
```

Some DBs (like MySQL) support:

- `FIRST` (add at start)    
- `AFTER another_column` to control placement    

Most others add new columns at the end.

**Example**

```sql
ALTER TABLE employees
ADD phone VARCHAR(15) DEFAULT NULL;
```

---

## B. Removing columns

Supported in modern MySQL versions.

```sql
ALTER TABLE mytable
DROP column_to_be_deleted;
```

If unsupported, you must:

1. Create a new table without that column.    
2. Copy data from old table to new.    
3. Drop old table.    
4. Rename new table.    

---

## C. Renaming the table

```sql
ALTER TABLE mytable
RENAME TO new_table_name;
```

---

# 3. Dropping Tables (DROP TABLE)

`DROP TABLE` deletes:

- The entire table    
- All its rows    
- Its schema and metadata    

This is irreversible unless you have backups.

## Syntax

```sql
DROP TABLE IF EXISTS mytable;
```

Using `IF EXISTS` avoids errors if the table is missing.

---

## Foreign Key considerations

If a table is referenced by foreign keys:

- You cannot drop it until dependent tables are updated.    
- You may need to drop constraints, remove rows, or drop dependent tables first.    

Example:

```sql
DROP TABLE payroll;   -- fails if employees.payroll_id references payroll.id
```

Solutions:

- Remove or update foreign key relations first.    
- Use `ON DELETE CASCADE` when designing relationships (only if appropriate).    

---

# 4. Full Workflow Example

## Step 1: Create a employees table

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    salary INT CHECK (salary > 0),
    joined_on DATE DEFAULT CURRENT_DATE
);
```

## Step 2: Add a new column

```sql
ALTER TABLE employees
ADD email VARCHAR(255) UNIQUE;
```

## Step 3: Remove a column

```sql
ALTER TABLE employees
DROP role;
```

## Step 4: Rename the table

```sql
ALTER TABLE employees
RENAME TO staff;
```

## Step 5: Drop the table

```sql
DROP TABLE IF EXISTS staff;
```
