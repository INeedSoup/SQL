## **1. What a SELECT query does**

A SELECT query is used to retrieve data from a database.  
It tells the database:

1. What columns you want    
2. Which table they belong to    
3. Optional: what filtering, sorting, or limits to apply    

### Basic structure

```sql
SELECT column1, column2, …
FROM table_name;
```

### Selecting all columns

```sql
SELECT *
FROM table_name;
```

Useful when exploring a new table.

---

## **2. Understanding Tables**

- A table represents an entity (example: Dogs).    
- Each row is an instance of the entity (example: a pug, a beagle).    
- Columns represent shared properties (example: color, height, tail length).    

---

## **3. Filtering results using WHERE**

The WHERE clause reduces rows by checking conditions on each row.

### Example

```sql
SELECT column
FROM mytable
WHERE column > 10;
```

### Combining conditions

```sql
WHERE condition
  AND another_condition
  OR third_condition
```

### Important numerical operators

| Operator            | Meaning                   | Example              |
| ------------------- | ------------------------- | -------------------- |
| =, !=, <, <=, >, >= | Standard comparisons      | col != 4             |
| BETWEEN a AND b     | Inclusive range           | col BETWEEN 1 AND 10 |
| IN (…)              | Value must be in list     | col IN (2,4,6)       |
| NOT IN (…)          | Value must not be in list | col NOT IN (1,3,5)   |

### Extra point

- SQL is not case sensitive for keywords, but caps are a readability convention.
    

---

## **4. Text filtering**

### Operators for text columns

| Operator | Meaning                    | Example            |
| -------- | -------------------------- | ------------------ |
| =        | Case-sensitive exact match | col = 'abc'        |
| != or <> | Exact mismatch             | col <> 'xyz'       |
| LIKE     | Case-insensitive match     | col LIKE 'ABC'     |
| NOT LIKE | Case-insensitive mismatch  | col NOT LIKE 'AB%' |
| %        | Zero or more characters    | '%cat%'            |
| _        | One character              | 'A_'               |
| IN (…)   | Text inside list           | col IN ('A','B')   |

### MUST-KNOW point

- Strings must be quoted: `'abc'`    
- Pattern matching works only with LIKE/NOT LIKE.    

---

## **5. Removing duplicates**

Use DISTINCT to fetch only unique rows.

```sql
SELECT DISTINCT column
FROM table_name;
```

### Extra point

DISTINCT applies to the entire row you select, not individual columns.

---

## **6. Sorting results**

Use ORDER BY to sort ascending (ASC) or descending (DESC).

```sql
SELECT column1, column2
FROM table
ORDER BY column1 ASC;
```

### Extra points

- Sorting is done alphanumerically.    
- You can sort by multiple columns using commas.    

---

## **7. Limiting the number of results**

Useful for pagination and huge tables.

```sql
LIMIT num_rows OFFSET starting_point;
```

### Example

```sql
LIMIT 10 OFFSET 20;
```

Returns 10 rows, starting after skipping the first 20.

### Execution order tip

LIMIT and OFFSET are applied last, after WHERE and ORDER BY.

---

## **8. Complete SELECT query template**

```sql
SELECT column, another_column, …
FROM table
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

---

# **9. LeetCode SQL Examples (With Explanations of Key Concepts)**

## **A. Filter rows using multiple AND conditions**

```sql
SELECT product_id 
FROM Products 
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

Concepts used:

- Filtering using multiple AND conditions.    
- Exact matching with string values.    
- `'Y'` is quoted because it's text.    

---

## **B. Using IS NULL correctly**

```sql
SELECT name 
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;
```

### **Important rule**

You cannot check NULL values using:

```sql
referee_id = NULL     -- WRONG
```

Why?  
NULL means “unknown”. SQL uses 3-valued logic (true, false, unknown), so comparisons with NULL don’t return true.  
Correct usage:

```sql
IS NULL
IS NOT NULL
```

---

## **C. Using logical OR to filter large values**

```sql
SELECT name, population, area 
FROM World 
WHERE area >= 3000000 OR population >= 25000000;
```

Concepts used:

- OR clause to include rows that satisfy either condition.    
- Comparing numerical data.    

---

## **D. DISTINCT with sorting**

```sql
SELECT DISTINCT(author_id) AS id 
FROM Views 
WHERE author_id = viewer_id 
ORDER BY id;
```

Concepts used:

- DISTINCT to remove duplicates.    
- Renaming a column with `AS`.    
- ORDER BY after filtering.    

### Reminder

Distinct applies before sorting.

---

## **E. Using string functions**

```sql
SELECT tweet_id 
FROM Tweets 
WHERE LENGTH(content) > 15;
```

Concepts used:

- LENGTH function to check text length.    
- Simple numeric comparison on function output.    

---

# **10. Extra Important Tips for Beginners**

### 1. ORDER OF EXECUTION (simple version)

1. FROM    
2. WHERE    
3. DISTINCT    
4. ORDER BY    
5. LIMIT / OFFSET    

### 2. SQL ignores extra spaces and line breaks → use formatting for clarity.

### 3. Use aliases for cleaner queries:

```sql
SELECT name AS user_name
```

### 4. Avoid SELECT * in production (slower, unstable if schema changes).

### 5. Use parentheses when mixing AND and OR to avoid logic errors.
