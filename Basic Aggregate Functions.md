Aggregate functions summarize multiple rows into a single value. They are essential for reporting, analytics, and any type of grouped calculation.

### **Common Aggregate Functions**

| Function          | What it does                          |
| ----------------- | ------------------------------------- |
| **COUNT(*)**      | Counts all rows.                      |
| **COUNT(column)** | Counts non-null values in the column. |
| **MIN(column)**   | Smallest value in the group.          |
| **MAX(column)**   | Largest value in the group.           |
| **AVG(column)**   | Average of values.                    |
| **SUM(column)**   | Total of all values.                  |

### **Syntax without Grouping**

```
SELECT AGG_FUNC(column) AS alias
FROM table
WHERE condition;
```

If there is no GROUP BY, the aggregate function runs on the entire filtered dataset.

---

## **2. Grouped Aggregate Queries**

Use `GROUP BY` to divide rows into logical groups before running aggregates.

### **Syntax**

```
SELECT AGG_FUNC(column) AS alias
FROM table
WHERE condition
GROUP BY column;
```

### **Key points**

- Rows sharing the same group-by value form one group.    
- Output will have one row per group.    
- Every selected column must be either:    
    1. Grouped, or        
    2. An aggregate expression.        

---

## **3. Filtering Groups with HAVING**

`WHERE` filters rows _before_ grouping.  
`HAVING` filters groups _after_ aggregation.

### **Syntax**

```
SELECT group_column, AGG_FUNC()
FROM table
WHERE row_condition
GROUP BY group_column
HAVING group_condition;
```

Use `HAVING` when you need to filter aggregated results (example: groups where AVG(salary) > 50000).

---

## **4. SQL Query Execution Order**

Order matters because each step can only use results from earlier steps.

1. **FROM / JOIN**  
    Combines tables and forms the working dataset.    
2. **WHERE**  
    Filters individual rows.    
3. **GROUP BY**  
    Groups remaining rows.    
4. **HAVING**  
    Filters complete groups.    
5. **SELECT**  
    Computes expressions and aggregates.    
6. **DISTINCT**  
    Removes duplicates.    
7. **ORDER BY**  
    Sorts results.    
8. **LIMIT / OFFSET**  
    Determines how many rows to return.    

---

# **Leetcode SQL Solutions Explained with Notes**

## **1. Filter rows and sort by rating**

```
SELECT *
FROM Cinema
WHERE (id%2 != 0)
  AND description != "boring"
ORDER BY rating DESC;
```

### **Explanation**

- `id % 2 != 0` keeps only odd IDs.    
- `description != 'boring'` removes boring movies.    
- No aggregation here, but uses filtering (`WHERE`) and sorting (`ORDER BY`).    
- Execution order: FROM → WHERE → SELECT → ORDER BY.    

---

## **2. Weighted average price of products**

```
SELECT p.product_id,
       COALESCE(ROUND(SUM(u.units*p.price)/SUM(u.units), 2), 0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
  ON p.product_id = u.product_id
 AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

### **Explanation**

- Joins price records with unit sales within valid date ranges.    
- Calculates a weighted average price using:    
    - `SUM(u.units*p.price)` = total revenue for that price period        
    - `SUM(u.units)` = total units sold        
- `COALESCE(..., 0)` returns 0 if no units were sold.    
- Uses aggregation (`SUM`, `GROUP BY`) and date filtering in the join.    

---

## **3. Average experience years per project**

```
SELECT p.project_id,
       ROUND(SUM(e.experience_years)/COUNT(*), 2) AS average_years
FROM Project p
JOIN Employee e
  ON p.employee_id = e.employee_id
GROUP BY p.project_id;
```

### **Explanation**

- Each row in Project represents one employee assigned to that project.    
- The join retrieves each employee’s experience.    
- `SUM(...) / COUNT(*)` manually computes an average.    
- Could also be `AVG(e.experience_years)`.

---

## **4. Contest participation percentage**

```
SELECT contest_id,
       ROUND(COUNT(DISTINCT user_id) * 100 /
       (SELECT COUNT(user_id) FROM Users), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

### **Explanation**

- Counts unique participants per contest.    
- Divides by total users to get participation percentage.    
- `GROUP BY` groups participation by contest.    
- Sorting ensures highest percentage comes first.    

---

## **5. Query performance metrics**

```
SELECT query_name,
       ROUND(AVG(rating/position), 2) AS quality,
       ROUND(100 * SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)/COUNT(*), 2)
       AS poor_query_percentage
FROM Queries
GROUP BY query_name;
```

### **Explanation**

- `rating/position` reflects relative ranking quality.  
    Averaged per query name.    
- Poor queries: rating < 3.    
- `SUM(CASE...)` counts poor queries.    
- `COUNT(*)` counts total queries.    


---

## **6. Monthly transaction summary**

```
SELECT DATE_FORMAT(trans_date, '%Y-%m') AS month,
       country,
       COUNT(*) AS trans_count,
       SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
       SUM(amount) AS trans_total_amount,
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END)
         AS approved_total_amount
FROM Transactions
GROUP BY month, country
ORDER BY month, country;
```

### **Explanation**

- Groups data by month and country (two-level grouping).    
- Calculates:    
    - number of transactions        
    - number approved        
    - total amount        
    - approved amount        
- Uses conditional aggregation with `CASE WHEN`.    

---

## **7. First-order immediate delivery percentage**

```
WITH FirstOrder AS (
    SELECT customer_id,
           MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
)
SELECT ROUND(
       100 * SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END)
       / COUNT(*), 2
) AS immediate_percentage
FROM Delivery d
JOIN FirstOrder f
  ON d.customer_id = f.customer_id
 AND d.order_date = f.first_order_date;
```

### **Explanation**

- First CTE finds each customer’s first order date.    
- The final query checks if the first order was delivered on the user’s preferred date.    
- Uses:    
    - `MIN()` to find earliest order per customer        
    - join to match the first orders only        
    - conditional aggregation        

---

## **8. Fraction of players who logged in the day after first login**

```
WITH FirstLogin AS (
    SELECT player_id,
           MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
)
SELECT ROUND(
       COUNT(DISTINCT a.player_id) /
       (SELECT COUNT(DISTINCT player_id) FROM Activity), 2
) AS fraction
FROM Activity a
JOIN FirstLogin f
  ON a.player_id = f.player_id
WHERE a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY);
```

### **Explanation**

- Finds each player's first login date.    
- Checks which players returned exactly next day.    
- Divides by total distinct players.    
- Demonstrates use of:    
    - CTE        
    - date arithmetic        
    - grouping with MIN