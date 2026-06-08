# 10. Window Functions, Ranking, and Analytics

Window functions let you calculate values across related rows without collapsing the result like `GROUP BY` does. They are very important for interview questions about ranking, top-N per group, running totals, previous or next rows, and latest records.

## 1. Basic Syntax

```sql
SELECT
    column_name,
    window_function() OVER (
        PARTITION BY group_column
        ORDER BY sort_column
    ) AS calculated_value
FROM table_name;
```

Key idea:

- `PARTITION BY` works like "restart the calculation for each group".
- `ORDER BY` inside `OVER` decides row sequence inside each group.
- The outer `ORDER BY` only controls final display order.

## 2. ROW_NUMBER vs RANK vs DENSE_RANK

```sql
SELECT
    employee_id,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank,
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dense_salary_rank
FROM employees;
```

Use this rule:

| Function | Tie behavior | Best use |
| --- | --- | --- |
| `ROW_NUMBER()` | Breaks ties arbitrarily unless you add a tie-breaker | Pick exactly one latest/highest row |
| `RANK()` | Same rank for ties, leaves gaps | Sports-style ranking |
| `DENSE_RANK()` | Same rank for ties, no gaps | Top-N salaries including ties |

## 3. Latest Row Per User

Common question: find each user's latest login, order, transaction, or event.

```sql
WITH ranked_events AS (
    SELECT
        e.*,
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

Why `event_id DESC` is useful:

- If two events have the same timestamp, it gives a deterministic tie-breaker.
- Interviewers like this because it shows you understand duplicate timestamps.

## 4. Top N Per Group

Common question: top 3 salaries in each department.

```sql
WITH ranked_employees AS (
    SELECT
        e.*,
        DENSE_RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees AS e
)
SELECT
    department_id,
    employee_id,
    salary
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY department_id, salary DESC;
```

Use `DENSE_RANK()` if ties should be included. Use `ROW_NUMBER()` if the question says exactly 3 rows per department.

## 5. Running Total

```sql
SELECT
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM orders
ORDER BY order_date;
```

For department-wise running totals:

```sql
SELECT
    department_id,
    salary_date,
    salary_paid,
    SUM(salary_paid) OVER (
        PARTITION BY department_id
        ORDER BY salary_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS department_running_total
FROM salary_payments;
```

## 6. LAG and LEAD

Use `LAG()` to compare with the previous row and `LEAD()` to compare with the next row.

```sql
SELECT
    user_id,
    login_date,
    LAG(login_date) OVER (
        PARTITION BY user_id
        ORDER BY login_date
    ) AS previous_login_date,
    DATEDIFF(
        login_date,
        LAG(login_date) OVER (
            PARTITION BY user_id
            ORDER BY login_date
        )
    ) AS days_since_previous_login
FROM logins;
```

## 7. Consecutive Day Check

Common question: users who logged in the day after their first login.

```sql
WITH first_login AS (
    SELECT
        player_id,
        MIN(event_date) AS first_date
    FROM activity
    GROUP BY player_id
)
SELECT
    ROUND(
        COUNT(DISTINCT a.player_id) /
        (SELECT COUNT(*) FROM first_login),
        2
    ) AS fraction
FROM first_login AS f
JOIN activity AS a
  ON a.player_id = f.player_id
 AND a.event_date = DATE_ADD(f.first_date, INTERVAL 1 DAY);
```

Alternative with `LEAD()`:

```sql
WITH ordered_activity AS (
    SELECT
        player_id,
        event_date,
        ROW_NUMBER() OVER (
            PARTITION BY player_id
            ORDER BY event_date
        ) AS rn,
        LEAD(event_date) OVER (
            PARTITION BY player_id
            ORDER BY event_date
        ) AS next_event_date
    FROM activity
)
SELECT
    ROUND(
        SUM(CASE WHEN next_event_date = DATE_ADD(event_date, INTERVAL 1 DAY) THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fraction
FROM ordered_activity
WHERE rn = 1;
```

## 8. Moving Average

```sql
SELECT
    visited_on,
    amount,
    AVG(amount) OVER (
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS seven_day_avg
FROM customer_visits;
```

Use this for rolling 7-day revenue, moving average ratings, or recent activity metrics.

## 9. Window Functions With GROUP BY

Sometimes you aggregate first, then rank the aggregated result.

```sql
WITH department_sales AS (
    SELECT
        department_id,
        salesperson_id,
        SUM(amount) AS total_sales
    FROM sales
    GROUP BY department_id, salesperson_id
),
ranked_sales AS (
    SELECT
        department_id,
        salesperson_id,
        total_sales,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM department_sales
)
SELECT *
FROM ranked_sales
WHERE sales_rank = 1;
```

This pattern is very common: first summarize with `GROUP BY`, then rank with a window function.

## 10. Common Mistakes

- Filtering a window function directly in `WHERE`. Use a CTE or derived table first.
- Forgetting `PARTITION BY`, which ranks across the whole table instead of per group.
- Forgetting tie behavior. Always choose between `ROW_NUMBER`, `RANK`, and `DENSE_RANK` deliberately.
- Using window `ORDER BY` but assuming it controls the final display order. Add an outer `ORDER BY`.
- Using `RANGE` when duplicates in the order column can change the frame behavior. For interview answers, `ROWS BETWEEN ...` is usually clearer.

## 11. Practice Prompts

- Find the latest order for each customer.
- Find top 2 products by revenue in each category.
- Find employees earning the second-highest salary in each department.
- Calculate daily running revenue.
- Calculate a 7-day moving average of sales.
- Compare each month's revenue with the previous month.
- Find users whose second login happened within 7 days of the first login.
- Rank students by score within each class, including ties.
