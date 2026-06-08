# 9. Advanced String Functions, Regex, and Clauses

This lesson focuses on MySQL text handling and the clauses that commonly appear in interview SQL problems.

---

## 1. String cleanup functions

```sql
SELECT TRIM(name) AS cleaned_name,
       LOWER(email) AS normalized_email
FROM Users;
```

Useful functions:

| Function | Use |
| --- | --- |
| `TRIM()` | Remove leading and trailing spaces |
| `LOWER()` / `UPPER()` | Normalize case |
| `REPLACE()` | Replace text |
| `CONCAT()` | Join strings |
| `CONCAT_WS()` | Join strings with a separator |

---

## 2. Extracting parts of strings

```sql
SELECT email,
       SUBSTRING_INDEX(email, '@', 1) AS username,
       SUBSTRING_INDEX(email, '@', -1) AS domain
FROM Users;
```

More extraction tools:

```sql
SELECT LEFT(phone, 3) AS area_code,
       RIGHT(phone, 4) AS last_four,
       SUBSTRING(phone, 5, 3) AS middle_part
FROM Contacts;
```

---

## 3. LIKE patterns

```sql
SELECT user_id,
       name
FROM Users
WHERE name LIKE 'A%';
```

| Pattern | Meaning |
| --- | --- |
| `'A%'` | Starts with A |
| `'%son'` | Ends with son |
| `'%data%'` | Contains data |
| `'_a%'` | Second character is a |

`LIKE` is simple and fast enough for many prefix checks, but it is not full regex.

---

## 4. REGEXP / RLIKE

MySQL supports regular expression matching with `REGEXP` or `RLIKE`.

```sql
SELECT user_id,
       mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode[.]com$';
```

Common regex pieces:

| Pattern | Meaning |
| --- | --- |
| `^` | Start of string |
| `$` | End of string |
| `[A-Z]` | Any uppercase letter |
| `[0-9]` | Any digit |
| `*` | Zero or more |
| `+` | One or more |
| `[.]` | Literal dot |

---

## 5. CASE expressions

`CASE` is used for labels, conditional aggregation, and scoring.

```sql
SELECT order_id,
       amount,
       CASE
           WHEN amount >= 1000 THEN 'high'
           WHEN amount >= 500 THEN 'medium'
           ELSE 'low'
       END AS order_bucket
FROM Orders;
```

Conditional counting:

```sql
SELECT user_id,
       SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) AS confirmed_count,
       COUNT(*) AS total_actions
FROM Confirmations
GROUP BY user_id;
```

---

## 6. IF, IFNULL, NULLIF, COALESCE

```sql
SELECT user_id,
       IF(score >= 50, 'pass', 'fail') AS result,
       IFNULL(phone, 'missing') AS phone_status,
       COALESCE(nickname, first_name, 'anonymous') AS display_name
FROM Users;
```

| Function | Use |
| --- | --- |
| `IF(condition, a, b)` | MySQL-specific conditional |
| `IFNULL(value, fallback)` | Replace one nullable value |
| `COALESCE(a, b, c)` | First non-null value |
| `NULLIF(a, b)` | Returns NULL when values are equal |

---

## 7. GROUP BY, HAVING, ORDER BY, LIMIT

Full interview query structure:

```sql
SELECT customer_id,
       COUNT(*) AS order_count,
       SUM(amount) AS total_amount
FROM Orders
WHERE order_date >= '2025-01-01'
GROUP BY customer_id
HAVING SUM(amount) >= 1000
ORDER BY total_amount DESC, customer_id ASC
LIMIT 10;
```

Logical order:

1. `FROM` / `JOIN`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `ORDER BY`
7. `LIMIT`

---

## 8. Window clauses

Window functions calculate over related rows without collapsing them into one group.

```sql
SELECT employee_id,
       department_id,
       salary,
       RANK() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS salary_rank
FROM Employees;
```

Common functions:

| Function | Use |
| --- | --- |
| `ROW_NUMBER()` | Unique row number per partition |
| `RANK()` | Ranking with gaps after ties |
| `DENSE_RANK()` | Ranking without gaps after ties |
| `LAG()` | Previous row value |
| `LEAD()` | Next row value |

---

## 9. Practice examples

### Valid emails

```sql
SELECT user_id,
       name,
       mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode[.]com$';
```

### Capitalize names

```sql
SELECT user_id,
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name
FROM Users
ORDER BY user_id;
```

### Classify transactions

```sql
SELECT transaction_id,
       CASE
           WHEN amount >= 10000 THEN 'large'
           WHEN amount >= 1000 THEN 'medium'
           ELSE 'small'
       END AS transaction_size
FROM Transactions;
```

### Second highest salary

```sql
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```

---

## 10. Interview reminders

- Use single quotes for string literals.
- Use backticks only when an identifier has a reserved word or awkward name.
- `WHERE` cannot use aggregate results; use `HAVING`.
- `ORDER BY` can usually use aliases from `SELECT`.
- Prefer `COALESCE` when more than one fallback value is possible.
