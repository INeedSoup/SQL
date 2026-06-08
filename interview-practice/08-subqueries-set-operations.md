# 8. Subqueries and Set Operations

Subqueries help answer questions that need an intermediate result. Set operations combine the output of two compatible queries.

---

## 1. Scalar subquery

A scalar subquery returns one value.

```sql
SELECT employee_id,
       name,
       salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);
```

**Interview pattern:** "above average", "greater than company average", "less than total average".

---

## 2. Subquery with IN

Use `IN` when the subquery returns a list.

```sql
SELECT customer_id,
       customer_name
FROM Customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders
);
```

If the subquery can return `NULL`, be careful with `NOT IN`. Prefer `NOT EXISTS` for anti-match problems.

---

## 3. EXISTS and NOT EXISTS

`EXISTS` checks whether at least one matching row exists.

```sql
SELECT c.customer_id,
       c.customer_name
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.customer_id
);
```

This is a clean way to find customers with no orders.

---

## 4. Correlated subquery

A correlated subquery references the outer query.

```sql
SELECT e.employee_id,
       e.name,
       e.department_id,
       e.salary
FROM Employees AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employees AS e2
    WHERE e2.department_id = e.department_id
);
```

This finds employees earning more than their department average.

---

## 5. Derived table in FROM

A subquery in `FROM` behaves like a temporary result table.

```sql
SELECT department_id,
       avg_salary
FROM (
    SELECT department_id,
           AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY department_id
) AS dept_avg
WHERE avg_salary > 50000;
```

Every derived table in MySQL needs an alias.

---

## 6. CTE version

Common table expressions make complex queries easier to read.

```sql
WITH dept_avg AS (
    SELECT department_id,
           AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY department_id
)
SELECT department_id,
       avg_salary
FROM dept_avg
WHERE avg_salary > 50000;
```

Use CTEs when the intermediate result has a meaningful name.

---

## 7. UNION and UNION ALL

Both queries must return the same number of columns in compatible order.

```sql
SELECT first_name, last_name
FROM Employees
UNION
SELECT first_name, last_name
FROM Customers;
```

`UNION` removes duplicates. `UNION ALL` keeps duplicates and is usually faster.

```sql
SELECT first_name, last_name
FROM Employees
UNION ALL
SELECT first_name, last_name
FROM Customers;
```

`ORDER BY` belongs at the end of the full set operation.

```sql
SELECT city FROM Customers
UNION
SELECT city FROM Suppliers
ORDER BY city;
```

---

## 8. INTERSECT and EXCEPT in MySQL

MySQL does not support `INTERSECT` or `EXCEPT` in the same portable way as some other databases. Use joins or `EXISTS` instead.

**INTERSECT equivalent: rows in both sets**

```sql
SELECT DISTINCT c.customer_id
FROM Customers AS c
WHERE EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.customer_id
);
```

**EXCEPT equivalent: rows in first set but not second**

```sql
SELECT c.customer_id
FROM Customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.customer_id
);
```

---

## 9. LeetCode-style examples

### Largest number that appears once

```sql
SELECT MAX(num) AS num
FROM MyNumbers
WHERE num IN (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(*) = 1
);
```

### Customers who bought all products

```sql
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*)
    FROM Product
);
```

### Employees above department average

```sql
SELECT e.employee_id,
       e.name
FROM Employee AS e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM Employee AS e2
    WHERE e2.department_id = e.department_id
);
```

---

## 10. Choosing the right tool

| Need | Good pattern |
| --- | --- |
| Compare against one number | Scalar subquery |
| Check membership | `IN` or `EXISTS` |
| Find missing matches | `NOT EXISTS` or `LEFT JOIN ... IS NULL` |
| Reuse an intermediate result | CTE |
| Stack similar results | `UNION ALL` |
| Remove duplicate stacked results | `UNION` |
