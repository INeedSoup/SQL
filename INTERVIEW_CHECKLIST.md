# MySQL Interview Revision Checklist

Use this file as a last-pass checklist before solving SQL interview questions.

## Query Order

Remember the logical order:

1. `FROM` / `JOIN`
2. `WHERE`
3. `GROUP BY`
4. `HAVING`
5. `SELECT`
6. `DISTINCT`
7. `ORDER BY`
8. `LIMIT` / `OFFSET`

## Must-know Patterns

- Filter rows with `WHERE`, then filter groups with `HAVING`.
- Use `COUNT(*)` for rows and `COUNT(column)` when NULL values should be ignored.
- Use `COUNT(DISTINCT column)` for unique values.
- Use `LEFT JOIN ... WHERE right_table.id IS NULL` for anti-join problems.
- Use `EXISTS` when checking whether related rows exist.
- Use `NOT EXISTS` instead of `NOT IN` when the subquery can return NULL.
- Use conditional aggregation with `SUM(CASE WHEN ... THEN 1 ELSE 0 END)`.
- Use `NULLIF(denominator, 0)` to avoid divide-by-zero errors.
- Use `COALESCE(value, fallback)` to replace NULL in final output.
- Use `ROW_NUMBER()` when you need exactly one row after ranking.
- Use `RANK()` or `DENSE_RANK()` when ties matter.

## Common Interview Templates

### Second Highest Salary

```sql
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);
```

### Latest Row Per User

```sql
WITH ranked_events AS (
    SELECT e.*,
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY event_time DESC, event_id DESC
           ) AS rn
    FROM events AS e
)
SELECT *
FROM ranked_events
WHERE rn = 1;
```

### Top 3 Per Group

```sql
WITH ranked_employees AS (
    SELECT e.*,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employees AS e
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3;
```

### Customers Who Bought Every Product

```sql
SELECT customer_id
FROM customer_product
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*) FROM product
);
```

## Mistakes To Avoid

- Do not compare NULL with `= NULL`; use `IS NULL`.
- Do not use aggregate functions in `WHERE`; use `HAVING`.
- Do not use `SELECT *` in interview answers unless the question asks for all columns.
- Do not forget tie handling in salary, ranking, or top-N questions.
- Do not use `UNION` when duplicates must be preserved; use `UNION ALL`.
- Do not assume MySQL supports `FULL OUTER JOIN`; emulate it with `LEFT JOIN` plus `RIGHT JOIN` and `UNION`.
- Do not update or delete before previewing affected rows with `SELECT`.

## When Stuck

1. Write the required output columns first.
2. Identify the base table.
3. Add joins only for missing columns or filters.
4. Decide whether the problem is row-level, group-level, or rank-level.
5. Convert the English condition into `WHERE`, `HAVING`, or a window-function filter.
