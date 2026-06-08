# MySQL Tutorial and Interview SQL Practice

This repository is a structured MySQL learning vault. It has two main tracks:

1. **Placement query practice**: focused notes and solved interview-style SQL patterns.
2. **Tutorial practice**: a broader MySQL guide and runnable SQL script for hands-on learning.

## Repository Structure

```text
.
├── interview-practice/
│   ├── 01-select-where-order-by-limit-offset.md
│   ├── 02-joins.md
│   ├── 03-basic-aggregate-functions.md
│   ├── 04-sorting-and-grouping.md
│   ├── 05-inserting-updating-deleting-rows.md
│   ├── 06-creating-altering-dropping-tables.md
│   ├── 07-advanced-select-and-joins.md
│   ├── 08-subqueries-set-operations.md
│   ├── 09-advanced-string-functions-regex-clauses.md
│   └── 10-window-functions-ranking-and-analytics.md
├── tutorial/
│   ├── mysql-complete-tutorial.md
│   └── mysql-introduction-script.sql
├── reference/
│   └── mysql-functions.md
├── INTERVIEW_CHECKLIST.md
└── FUTURE_SCOPE.md
```

## Recommended Learning Path

Start with `tutorial/mysql-complete-tutorial.md` if you are new to MySQL. Then run selected parts of `tutorial/mysql-introduction-script.sql` in MySQL Workbench or another MySQL client.

For interview preparation, go through `interview-practice/` in order. The lessons move from basic filtering to joins, aggregation, subqueries, regex, ranking, window functions, and common placement patterns.

Use `INTERVIEW_CHECKLIST.md` as the fast revision sheet before a mock test or placement round.

## How to Use the SQL Script

The script is meant for practice, not production. Read a section, run a small block, inspect the output, then continue. Some lines demonstrate unsafe commands, failing constraints, duplicate keys, foreign-key errors, or rollback behavior; keep those lines commented until you intentionally want to test the error.

Recommended workflow:

```sql
CREATE DATABASE IF NOT EXISTS mysql_tutorial_practice;
USE mysql_tutorial_practice;
```

Run DDL and DML examples carefully. Statements like `DROP`, `DELETE`, `TRUNCATE`, and broad `UPDATE` queries can permanently change data if used outside a practice database.

## Topics Covered

- SELECT, WHERE, DISTINCT, ORDER BY, LIMIT, OFFSET
- Joins, self joins, anti joins, date-range joins
- Aggregate functions, GROUP BY, HAVING, conditional aggregation
- INSERT, UPDATE, DELETE, transactions, and safety checks
- CREATE, ALTER, DROP, constraints, indexes, foreign keys
- Subqueries, CTEs, set operations, EXISTS and NOT EXISTS
- String functions, regex, CASE, NULL handling
- Window functions, ranking, top-N per group, running totals
- Views, stored procedures, triggers, and MySQL utility functions

## Interview Focus

The placement track emphasizes patterns such as:

- Find missing matches
- Count distinct values per group
- Find top, second-highest, latest, or first records
- Compare rows with department or global averages
- Calculate percentages and rates
- Solve "bought all products" and other set-completion questions
- Use `CASE` for conditional aggregation
- Use `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LAG`, and `LEAD` for ranking and event-order problems

## Notes

Most examples target MySQL 8+. Some concepts are common across SQL databases, but syntax can vary between MySQL, PostgreSQL, SQL Server, SQLite, and Oracle.

See `FUTURE_SCOPE.md` for topics that should be expanded next.
