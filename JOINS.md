## **1. Database Normalization**

- Real-world data is split across multiple related tables.    
- This reduces duplication and keeps data consistent.    
- Comes at the cost of more complex queries since tables must be joined.    

---

# **2. Multi-table Queries with JOINs**

## **INNER JOIN**

Returns only rows that appear in both tables.

**Syntax**

```
SELECT ...
FROM tableA
INNER JOIN tableB ON tableA.key = tableB.key;
```

**Key idea**  
The join condition selects matching rows across tables. Unmatched rows are dropped.

---

## **LEFT, RIGHT, and FULL JOIN (OUTER JOINS)**

### **LEFT JOIN**

Returns all rows from the left table, and matching rows from the right table.  
Right side is NULL when no match exists.

### **RIGHT JOIN**

Opposite of LEFT JOIN.

### **FULL JOIN**

Returns all rows from both tables.  
Missing matches are filled with NULL.

---

## **Working with NULLs**

- Use `IS NULL` or `IS NOT NULL`.    
- NULL is not equal to anything, not even another NULL.    

---

# **3. Expressions and Aliases**

SQL allows math, string operations, and functions in SELECT.

Example:

```
SELECT ABS(value) * 10 AS scaled_value
FROM table;
```

Aliases (`AS name`) make complex expressions readable.

---

# **4. CROSS JOIN**

Produces a Cartesian product: every row in table A paired with every row in table B.

Syntax:

```
SELECT ...
FROM A
CROSS JOIN B;
```

Useful for:

- Generating all combinations
- Comparing all rows across tables (such as yesterday vs today)
   
---

# **5. COALESCE**

Used to replace NULLs with a fallback value.

Example:

```
COALESCE(bonus, 0)
```

---

# **6. Conditional Aggregation**

SQL lets you count based on conditions inside aggregate functions.

Example:

```
SUM(action = 'confirmed')
```

In MySQL, `action = 'confirmed'` returns 1 or 0.

---

# **7. HAVING**

Used to filter groups after `GROUP BY`.

---

# **8. LeetCode Query Explanations**

## 1. Employee Unique ID + Name

```
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI ON Employees.id = EmployeeUNI.id;
```

**Concepts used**

- LEFT JOIN    
- Matching keys across tables    

**Explanation**  
Returns all employees. If a unique ID exists in EmployeeUNI, include it. If not, unique_id will be NULL.

---

## 2. Product with Sales Data

```
SELECT p.product_name, s.year, s.price
FROM Sales AS s
LEFT JOIN Product AS p ON s.product_id = p.product_id;
```

**Concepts**

- LEFT JOIN    
- Aliases    

**Explanation**  
Return every sales record, even if the product name is missing.

---

## 3. Count Visits Without Transactions

```
SELECT customer_id, COUNT(customer_id) AS count_no_trans
FROM Visits
LEFT JOIN Transactions ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.visit_id IS NULL
GROUP BY customer_id;
```

**Concepts**

- LEFT JOIN to detect missing records    
- NULL filtering    
- GROUP BY    

**Explanation**  
If a visit has no matching transaction, it's counted as a no-transaction visit.

---

## 4. Higher Temperature on Next Day

```
SELECT today.id 
FROM Weather yesterday 
CROSS JOIN Weather today 
WHERE DATEDIFF(today.recordDate, yesterday.recordDate) = 1
  AND today.temperature > yesterday.temperature;
```

**Concepts**

- CROSS JOIN (creates all day-pairs)    
- Date difference    
- Row comparison across the same table    

**Explanation**  
Compare each day with the previous day to find when temperature increased.

---

## 5. Machine Processing Time

```
SELECT a1.machine_id, 
       ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time
FROM Activity AS a1 
JOIN Activity AS a2
  ON a1.machine_id = a2.machine_id
 AND a1.process_id = a2.process_id
 AND a1.activity_type = 'start'
 AND a2.activity_type = 'end'
GROUP BY a1.machine_id;
```

**Concepts**

- Self JOIN    
- Conditional join    
- Aggregate functions    
- Aliases    

**Explanation**  
Match start and end timestamps for each process to compute average processing time per machine.

---

## 6. Employee Bonuses < 1000 or NULL

```
SELECT e.name, b.bonus
FROM Employee AS e
LEFT JOIN Bonus AS b ON e.empId = b.empId
WHERE bonus < 1000 OR bonus IS NULL;
```

**Concepts**

- LEFT JOIN    
- NULL check    
- Simple OR condition    

**Explanation**  
Show employees with low bonuses or no bonus assigned.

---

## 7. Student Exam Attendance (Students x Subjects grid)

```
SELECT s.student_id, s.student_name, sub.subject_name,
       COUNT(e.subject_name) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS sub
LEFT JOIN Examinations AS e
  ON s.student_id = e.student_id
 AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
```

**Concepts**

- CROSS JOIN to generate all (student, subject) pairs    
- LEFT JOIN to check attendance    
- GROUP BY    
- Conditional counting    

**Explanation**  
Creates a full matrix of every student and every subject, then counts exams they attended.

---

## 8. Managers With 5 or More Direct Reports

```
SELECT e.name
FROM Employee AS e
INNER JOIN Employee AS m ON e.id = m.managerId
GROUP BY m.managerId
HAVING COUNT(m.managerId) >= 5;
```

**Concepts**

- Self JOIN    
- GROUP BY    
- HAVING (post-group filter)    

**Explanation**  
Counts employees under each manager and returns managers with 5+ reports.

---

## 9. Confirmation Rate

```
SELECT s.user_id,
       ROUND(COALESCE(SUM(c.action = 'confirmed') / COUNT(c.user_id), 0), 2)
       AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id;
```

**Concepts**

- LEFT JOIN    
- Conditional aggregation (`SUM(condition)`)    
- COALESCE (replace NULL with zero)    
- Rounding    

**Explanation**  
Calculates the fraction of confirmations per user. Users with no confirmations get a rate of 0.
