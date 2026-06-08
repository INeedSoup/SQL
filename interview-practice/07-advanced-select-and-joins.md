# 7. Advanced SELECT and JOINs

This lesson covers interview patterns that go beyond a basic two-table join. These show up often in placement SQL rounds because they test whether you understand rows, groups, missing matches, and comparison across records.

---

## 1. Self JOIN

A self join compares rows inside the same table. Use aliases so each copy has a clear role.

```sql
SELECT e.employee_id,
       e.name AS employee_name,
       m.name AS manager_name
FROM Employee AS e
LEFT JOIN Employee AS m
  ON e.manager_id = m.employee_id;
```

**Use cases**

- Employee and manager relationships
- Customer referrals
- Comparing current row with another row in the same table

---

## 2. Anti JOIN: Find rows with no match

MySQL does not have an `ANTI JOIN` keyword. The common pattern is `LEFT JOIN` plus `IS NULL`.

```sql
SELECT c.customer_id,
       c.customer_name
FROM Customers AS c
LEFT JOIN Orders AS o
  ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
```

**Interview idea:** "customers who never ordered", "employees without bonus", "visits without transactions".

---

## 3. Semi JOIN: Find rows that have a match

Use `EXISTS` when you only need to know whether a related row exists.

```sql
SELECT c.customer_id,
       c.customer_name
FROM Customers AS c
WHERE EXISTS (
    SELECT 1
    FROM Orders AS o
    WHERE o.customer_id = c.customer_id
);
```

`EXISTS` is often safer than `IN` when the subquery can contain `NULL`.

---

## 4. Non-equi JOIN

Not every join uses `=`.

```sql
SELECT e.employee_id,
       e.salary,
       b.grade
FROM Employees AS e
JOIN SalaryBands AS b
  ON e.salary BETWEEN b.min_salary AND b.max_salary;
```

**Use cases**

- Salary bands
- Date ranges
- Price validity windows

---

## 5. Join on date ranges

This is a common pattern in pricing and subscription problems.

```sql
SELECT p.product_id,
       u.purchase_date,
       p.price,
       u.units
FROM Prices AS p
JOIN UnitsSold AS u
  ON p.product_id = u.product_id
 AND u.purchase_date BETWEEN p.start_date AND p.end_date;
```

Put range conditions in the `ON` clause when they define how the tables match.

---

## 6. Deduplicate before joining

If the right table has duplicate keys, a join can accidentally multiply rows.

```sql
WITH latest_status AS (
    SELECT customer_id,
           MAX(updated_at) AS latest_update
    FROM CustomerStatus
    GROUP BY customer_id
)
SELECT c.customer_id,
       c.customer_name,
       s.status
FROM Customers AS c
JOIN latest_status AS ls
  ON c.customer_id = ls.customer_id
JOIN CustomerStatus AS s
  ON s.customer_id = ls.customer_id
 AND s.updated_at = ls.latest_update;
```

Always ask: "Is the join key unique on the side I am joining to?"

---

## 7. Conditional JOIN

Sometimes a join should match only a subset of rows from the right table.

```sql
SELECT u.user_id,
       COUNT(c.confirmation_id) AS confirmed_count
FROM Users AS u
LEFT JOIN Confirmations AS c
  ON u.user_id = c.user_id
 AND c.action = 'confirmed'
GROUP BY u.user_id;
```

Putting `c.action = 'confirmed'` in `ON` keeps users with zero confirmations. Putting it in `WHERE` would remove them.

---

## 8. Window functions with joins

MySQL 8 supports window functions. They are very useful for ranking and latest-row problems.

```sql
WITH ranked_orders AS (
    SELECT o.*,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY order_date DESC, order_id DESC
           ) AS rn
    FROM Orders AS o
)
SELECT c.customer_id,
       c.customer_name,
       r.order_id,
       r.order_date
FROM Customers AS c
LEFT JOIN ranked_orders AS r
  ON c.customer_id = r.customer_id
 AND r.rn = 1;
```

This returns each customer's latest order while keeping customers who have never ordered.

---

## 9. Common mistakes

- Filtering a `LEFT JOIN` table in `WHERE` when you meant to keep unmatched rows.
- Joining before removing duplicates from a many-to-many table.
- Using `SELECT *` in multi-table joins and getting duplicate column names.
- Forgetting tie-breakers in latest-row queries.
- Counting `COUNT(*)` after a `LEFT JOIN` when you meant to count matches from the right table.

---

## 10. Practice prompts

1. Find employees whose salary is higher than their manager's salary.
2. Find users who signed up but never confirmed.
3. Return each product with its latest price.
4. Find customers who bought products from every category.
5. Find orders where the order date falls inside a customer's active subscription period.
