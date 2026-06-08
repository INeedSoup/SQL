Here are clean, structured notes for each SQL query you shared. I kept the explanations clear and practical, focusing on the concepts behind each solution and highlighting anything worth paying attention to.

---

## 1. Count distinct subjects taught by each teacher

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt 
FROM Teacher 
GROUP BY teacher_id;
```

### What it does

For every teacher, it counts how many unique subjects they teach.

### Key concepts

- **GROUP BY** groups records per teacher.    
- **COUNT(DISTINCT …)** removes duplicates before counting.    

This avoids inflated counts if a teacher appears multiple times for the same subject.

---

## 2. Daily active users over a 30-day window

```sql
SELECT activity_date AS day,
       COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN DATE('2019-07-27') - INTERVAL 29 DAY 
                        AND '2019-07-27'
GROUP BY activity_date;
```

### What it does

Finds how many unique users were active each day in the 30 days ending on 2019-07-27.

### Key concepts

- **BETWEEN…INTERVAL…** filters a date range.    
- **COUNT(DISTINCT user_id)** counts unique users per day.    

- The lower bound uses `DATE('2019-07-27') - INTERVAL 29 DAY`, giving a 30-day span.    
- Output is daily stats, not cumulative.    

---

## 3. First year a product was sold + its sales data in that year

```sql
WITH FirstYear AS (
    SELECT product_id, MIN(year) AS first_year 
    FROM Sales 
    GROUP BY product_id
)
SELECT s.product_id, f.first_year, s.quantity, s.price
FROM Sales s
JOIN FirstYear f
    ON s.product_id = f.product_id 
   AND s.year = f.first_year;
```

### What it does

Finds the first year each product was sold, then returns the sales details for that first year only.

### Key concepts

- **CTE (WITH)** helps precompute the earliest year per product.    
- **MIN(year)** finds the first sale year.    
- **JOIN with year equality** filters Sales to only those first-year rows.    

This approach avoids window functions and stays simple and readable.

---

## 4. Classes with at least five distinct students

```sql
SELECT class 
FROM Courses 
GROUP BY class 
HAVING COUNT(DISTINCT student) >= 5;
```

### What it does

Returns classes that have five or more unique students enrolled.

### Key concepts

- **HAVING** applies filters on aggregated results.    
- **COUNT(DISTINCT student)** makes sure duplicate enrollments are not counted.    

Using `HAVING` instead of `WHERE` is crucial here, because the condition depends on aggregation.

---

## 5. Count followers for each user

```sql
SELECT user_id, COUNT(DISTINCT follower_id) AS followers_count 
FROM Followers 
GROUP BY user_id 
ORDER BY user_id ASC;
```

### What it does

For every user, counts how many distinct followers they have.

### Key concepts

- Straightforward use of **GROUP BY**.    
- **DISTINCT** helps remove duplicate following relationships.    

---

## 6. Largest number that appears exactly once

```sql
SELECT MAX(num) AS num 
FROM MyNumbers 
WHERE num IN (
    SELECT num 
    FROM MyNumbers 
    GROUP BY num 
    HAVING COUNT(num) = 1
);
```

### What it does

Finds the maximum number that occurs only once in the table.

### Key concepts

- **Subquery** filters numbers that appear exactly once.    
- **MAX** finds the largest among them.    

You could replace `num IN (…)` with a join, but this form is very readable.

---

## 7. Customers who bought every product

```sql
SELECT customer_id 
FROM Customer 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_key) = (
    SELECT COUNT(*) FROM Product
);
```

### What it does

Returns customers who purchased all products in the Product table.

### Key concepts

- **Set-completion logic**:  
    `distinct products bought` == `total products`.    
- Uses a subquery to get the number of products available.    

This pattern is common in “find who completed the full set” problems.
