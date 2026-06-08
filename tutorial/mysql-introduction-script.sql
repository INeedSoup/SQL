-- MySQL tutorial practice script.
-- Run this in a dedicated practice database only.
-- Some statements intentionally demonstrate errors or dangerous operations; keep them commented
-- until you specifically want to test that behavior.
-- If you want a completely fresh run, uncomment the next line first.
-- DROP DATABASE IF EXISTS mysql_tutorial_practice;

CREATE DATABASE IF NOT EXISTS mysql_tutorial_practice;
-- sys is a system database; do not practice in it.
USE mysql_tutorial_practice;
-- ALTER DATABASE mysql_tutorial_practice READ ONLY = 0;
-- Some MySQL environments do not support database READ ONLY mode. If enabled, writes are blocked.

START TRANSACTION;

CREATE TABLE employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);
SELECT * FROM employees;
-- RENAME TABLE employees to WORKERS;
ALTER TABLE employees ADD phone_number VARCHAR(15);
ALTER TABLE employees RENAME COLUMN phone_number TO email;
ALTER TABLE employees MODIFY email VARCHAR(100);
ALTER TABLE employees MODIFY email VARCHAR(100) FIRST;
-- ALTER TABLE employees MODIFY email VARCHAR(100) AFTER column_name
ALTER TABLE employees DROP COLUMN email;
COMMIT;

START TRANSACTION;
SELECT * FROM employees;
INSERT INTO employees VALUES (1, "Eugene", "Krabs", 25.50, "2023-01-02");
INSERT INTO employees VALUES (2, "Squidward", "Tentacles", 15.00, "2023-01-03"), 
							 (3, "Spongebob", "Squarepants", 12.50, "2023-01-04" ),
                             (4, "Patrick", "Star", 12.50, "2023-01-05"),
                             (5, "Sandy", "Cheeks", 17.25, "2023-01-06");
INSERT INTO employees (employee_id, first_name, last_name) VALUES (6, "Sheldon", "Plankton");

SELECT first_name, last_name, first_name FROM employees;
SELECT * FROM employees WHERE employee_id = 4;
SELECT * FROM employees WHERE hourly_pay >= 15;
SELECT * FROM employees WHERE hire_date <= "2023-01-03";
SELECT * FROM employees WHERE employee_id != 1;
SELECT * FROM employees WHERE hire_date IS NULL;

UPDATE employees SET hourly_pay = 10.50, hire_date = "2023-01-06" WHERE employee_id = 6;
SET AUTOCOMMIT = OFF;
-- UPDATE employees SET hourly_pay = 10.25;
-- DELETE FROM employees;
DELETE FROM employees WHERE employee_id = 6;
-- ROLLBACK;
SELECT * FROM employees;
COMMIT;

CREATE TABLE test(
	my_date DATE,
    my_time TIME,
    my_datetime DATETIME
);
INSERT INTO test VALUES (CURRENT_DATE(), CURRENT_TIME(), NOW());
INSERT INTO test VALUES (CURRENT_DATE()-1, NULL, NULL);
SELECT * FROM test;
DROP TABLE test;

START TRANSACTION;
CREATE TABLE products (
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4, 2)
);
ALTER TABLE products ADD CONSTRAINT uq_products_product_name UNIQUE(product_name);
-- We first created a table and specified UNIQUE constraint there, then tried doing it again with ALTER.
-- This creates another unique index on the same column.
INSERT INTO products VALUES (100, "Hamburger", 3.99), 
							(101, "Fries", 1.89),
                            (102, "Soda", 1.00),
                            (103, "Ice Cream", 1.49);
SELECT * FROM products;
SHOW INDEXES FROM products;
ALTER TABLE products DROP INDEX product_name;
ALTER TABLE products DROP INDEX product_name_2;
COMMIT;

START TRANSACTION;
CREATE TABLE products (
	product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(4, 2) NOT NULL
);
ALTER TABLE products MODIFY COLUMN price DECIMAL(4, 2) NOT NULL;
INSERT INTO products VALUES (104, "Cookie", 0);
ALTER TABLE products MODIFY COLUMN price DECIMAL(4, 2) NULL;
INSERT INTO products VALUES (104, "Cookie", NULL);
DELETE FROM products WHERE product_id = 104;
SELECT * FROM products;
ROLLBACK;
COMMIT;

START TRANSACTION;
CREATE TABLE employees (
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(4, 2),
    hire_date DATE,
    CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);
ALTER TABLE employees ADD CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00);
INSERT INTO employees VALUES(6, "Sheldon", "Plankton", 5.00, "2023-01-07");
INSERT INTO employees VALUES(6, "Sheldon", "Plankton", 10.00, "2023-01-07");
ALTER TABLE employees DROP CHECK chk_hourly_pay;
SELECT * FROM employees;
ROLLBACK;
DELETE FROM employees WHERE employee_id = 6;
-- For AND OR NOT chapter ahead
INSERT INTO employees (employee_id, first_name, last_name, hourly_pay, hire_date) VALUES(6, "Sheldon", "Plankton", 10.00, "2023-01-07");
COMMIT;

START TRANSACTION;
INSERT INTO products VALUES (104, "Straw", 0.00),
							(105, "Napkin", 0.00),
							(106, "Fork", 0.00),
							(107, "Spoon", 0.00);
DELETE FROM products WHERE product_id >= 104;
CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(4, 2) DEFAULT 0
);
ALTER TABLE products ALTER price SET DEFAULT 0;
INSERT INTO products (product_id, product_name) VALUES (104, "Straw"),
							(105, "Napkin"),
							(106, "Fork"),
							(107, "Spoon");
SELECT * FROM products;

CREATE TABLE transactions(
	transaction_id INT,
    amount DECIMAL(5, 2),
    transaction_date DATETIME DEFAULT NOW()
);
INSERT INTO transactions (transaction_id, amount) VALUES (1, 2.89);
SELECT * FROM transactions;
DROP TABLE transactions;
COMMIT;

START TRANSACTION;
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5, 2)
);
-- The table already has a primary key from CREATE TABLE.
-- ALTER TABLE transactions ADD PRIMARY KEY(transaction_id);
INSERT INTO transactions VALUES (1000, 4.99);
INSERT INTO transactions VALUES (1001, 2.89);
-- INSERT INTO transactions VALUES(1001, 3.38);
-- INSERT INTO transactions VALUES(NULL, 3.38);
INSERT INTO transactions VALUES (1002, 3.38);
SELECT amount FROM transactions WHERE transaction_id = 1003;
SELECT * FROM transactions;
COMMIT;

START TRANSACTION;
DROP TABLE transactions;
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2)
);
INSERT INTO transactions (amount) VALUES (4.99);
INSERT INTO transactions (amount) VALUES (2.89);
INSERT INTO transactions (amount) VALUES (3.38);
INSERT INTO transactions (amount) VALUES (4.99);
ALTER TABLE transactions AUTO_INCREMENT = 1000;
DELETE FROM transactions;
INSERT INTO transactions (amount) VALUES (4.99);
INSERT INTO transactions (amount) VALUES (2.89);
INSERT INTO transactions (amount) VALUES (3.38);
INSERT INTO transactions (amount) VALUES (4.99);
SELECT * FROM transactions;
COMMIT;

START TRANSACTION;
CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
INSERT INTO CUSTOMERS (first_name, last_name) VALUES("Fred", "Fish"),
													("Larry", "Lobster"),
													("Bubble", "Bass");
SELECT * FROM customers;
DROP TABLE transactions;
CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
ALTER TABLE transactions DROP FOREIGN KEY transactions_ibfk_1;
ALTER TABLE transactions ADD CONSTRAINT fk_customer_id FOREIGN KEY(customer_id) REFERENCES customers(customer_id);
ALTER TABLE transactions AUTO_INCREMENT = 1000;
INSERT INTO transactions (amount, customer_id) VALUES (4.99, 3),
													  (2.89, 2),
                                                      (3.38, 3),
                                                      (4.99, 1);
SELECT * FROM transactions;
DELETE FROM customers WHERE customer_id = 3;
COMMIT;

START TRANSACTION;
INSERT INTO transactions (amount, customer_id) VALUES (1, NULL);
INSERT INTO customers (first_name, last_name) VALUES ("Poppy", "Puff");
SELECT * FROM transactions;
SELECT * FROM customers;
-- INNER JOIN
SELECT * FROM transactions INNER JOIN customers ON transactions.customer_id = customers.customer_id;
SELECT transaction_id, amount, first_name, last_name FROM transactions INNER JOIN customers ON transactions.customer_id = customers.customer_id;
-- LEFT JOIN
SELECT * FROM transactions LEFT JOIN customers ON transactions.customer_id = customers.customer_id;
-- RIGHT JOIN
SELECT * FROM transactions RIGHT JOIN customers ON transactions.customer_id = customers.customer_id;
COMMIT;

SELECT COUNT(amount) FROM transactions;
SELECT COUNT(amount) as COUNT FROM transactions;
SELECT MAX(amount) AS maximum FROM transactions;
SELECT MIN(amount) AS minimum FROM transactions;
SELECT AVG(amount) AS average FROM transactions;
SELECT SUM(amount) AS sum FROM transactions;
SELECT CONCAT(first_name, " ", last_name) AS full_name FROM employees;

START TRANSACTION;
ALTER TABLE employees ADD COLUMN job VARCHAR(25) AFTER hourly_pay;
SELECT * FROM employees;
UPDATE employees SET job = "manager" WHERE employee_id = 1;
UPDATE employees SET job = "cashier" WHERE employee_id = 2;
UPDATE employees SET job = "cook" WHERE employee_id = 3 OR employee_id = 4;
UPDATE employees SET job = "asst. manager" WHERE employee_id = 5;
UPDATE employees SET job = "janitor" WHERE employee_id = 6;
SELECT * FROM employees WHERE hire_date < "2023-01-05" AND job = "cook";
SELECT * FROM employees WHERE job = "cook" OR job = "cashier" ;
SELECT * FROM employees WHERE NOT job = "manager" AND NOT job = "asst. manager";
SELECT * FROM employees WHERE hire_date BETWEEN "2023-01-04" AND "2023-01-07";
SELECT * FROM employees WHERE job IN ("cook", "cashier", "janitor");
COMMIT;

SELECT * FROM employees;
SELECT * FROM employees WHERE first_name LIKE "s%";
SELECT * FROM employees WHERE hire_date LIKE "2023%";
SELECT * FROM employees WHERE last_name LIKE "%r";
SELECT * FROM employees WHERE first_name LIKE "sp%";
SELECT * FROM employees WHERE job LIKE "_ook";
SELECT * FROM employees WHERE job LIKE "_oo_";
SELECT * FROM employees WHERE hire_date LIKE "____-01-__";
SELECT * FROM employees WHERE hire_date LIKE "____-__-02";
SELECT * FROM employees WHERE job LIKE "_a%";

SELECT * FROM employees ORDER BY last_name;
SELECT * FROM employees ORDER BY last_name DESC;
SELECT * FROM employees ORDER BY first_name;
SELECT * FROM employees ORDER BY first_name DESC;
SELECT * FROM employees ORDER BY hire_date;
SELECT * FROM employees ORDER BY hire_date DESC;
SELECT * FROM transactions ORDER BY amount ASC, customer_id DESC;

SELECT * FROM customers;
SELECT * FROM customers ORDER BY last_name DESC LIMIT 2;
SELECT * FROM customers ORDER BY last_name DESC LIMIT 1, 2;
SELECT * FROM customers ORDER BY last_name DESC LIMIT 2 OFFSET 1;

INSERT INTO customers (first_name, last_name) VALUES ("Sheldon", "Plankton");
-- DOES NOT SHOW DUPLICATES VALUES
SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;
-- SHOWS DUPLICATE VALUES
SELECT first_name, last_name FROM employees
UNION ALL
SELECT first_name, last_name FROM customers;
DELETE FROM customers WHERE first_name = "sheldon";

START TRANSACTION;
SELECT * FROM customers;
ALTER TABLE customers ADD referral_id INT;
UPDATE customers SET referral_id = 1 WHERE customer_id = 2;
UPDATE customers SET referral_id = 2 WHERE customer_id = 3;
UPDATE customers SET referral_id = 2 WHERE customer_id = 4;
SELECT * FROM customers as a INNER JOIN customers as b ON a.referral_id = b.customer_id;
SELECT a.customer_id, a.first_name, a.last_name, CONCAT(b.first_name, " ", b.last_name) AS "referred by" FROM customers as a INNER JOIN customers as b ON a.referral_id = b.customer_id;
SELECT a.customer_id, CONCAT(a.first_name, " ", a.last_name) AS customer_name, a.referral_id, CONCAT(b.first_name, " ", b.last_name) AS "referred by" FROM customers as a LEFT JOIN customers as b ON a.referral_id = b.customer_id;

SELECT * FROM employees;
ALTER TABLE employees ADD supervisor_id INT;
UPDATE employees SET supervisor_id = 5 WHERE employee_id IN (2, 3, 4, 6);
UPDATE employees SET supervisor_id = 1 WHERE employee_id = 5;
SELECT * FROM employees as a INNER JOIN employees as b ON a.employee_id = b.supervisor_id;
SELECT a.employee_id, CONCAT(a.first_name, " ", a.last_name) as employee_name, a.supervisor_id, CONCAT(b.first_name, " ", b.last_name) as supervisor_name FROM employees as a INNER JOIN employees as b ON a.supervisor_id = b.employee_id;
SELECT a.employee_id, CONCAT(a.first_name, " ", a.last_name) as employee_name, a.supervisor_id, CONCAT(b.first_name, " ", b.last_name) as supervisor_name FROM employees as a LEFT JOIN employees as b ON a.supervisor_id = b.employee_id;
COMMIT;

START TRANSACTION;
SELECT * FROM employees;
CREATE VIEW employee_attendance AS SELECT first_name, last_name FROM employees;
SELECT * FROM employee_attendance ORDER BY last_name;
DROP VIEW employee_attendance;

SELECT * FROM customers;
ALTER TABLE customers ADD COLUMN email VARCHAR(50);
UPDATE customers SET email = "FFish@gmail.com" WHERE customer_id = 1;
UPDATE customers SET email = "LLobster@gmail.com" WHERE customer_id = 2;
UPDATE customers SET email = "BBass@gmail.com" WHERE customer_id = 3;
UPDATE customers SET email = "PPuff@gmail.com" WHERE customer_id = 4;
CREATE VIEW customer_emails AS SELECT email FROM customers;
SELECT * FROM customer_emails;
INSERT INTO customers VALUES (5, "Pearl", "Krabs", NULL, "PKrabs@gmail.com");
SELECT * FROM customer_emails;
COMMIT;

START TRANSACTION;
SELECT * FROM transactions;
SELECT * FROM customers;
SHOW INDEXES FROM customers;
CREATE INDEX last_name_idx ON customers(last_name);
SELECT * FROM customers WHERE last_name = "Puff";
SELECT * FROM customers WHERE first_name = "Poppy";
CREATE INDEX last_name_first_name_idx ON customers(last_name, first_name);
ALTER TABLE customers DROP INDEX last_name_idx;
SELECT * FROM customers WHERE last_name = "Puff" AND first_name = "Poppy";
COMMIT;

SELECT * FROM employees;
SELECT first_name, last_name, hourly_pay, (SELECT AVG(hourly_pay) FROM employees) AS avg_pay FROM employees;
SELECT first_name, last_name, hourly_pay FROM employees WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);

SELECT * FROM transactions;
SELECT first_name, last_name FROM customers WHERE customer_id IN (SELECT DISTINCT customer_id FROM transactions WHERE customer_id IS NOT NULL);
SELECT first_name, last_name FROM customers WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM transactions WHERE customer_id IS NOT NULL);

START TRANSACTION;
SELECT * FROM transactions;
ALTER TABLE transactions ADD order_date DATE;
INSERT INTO transactions VALUES (1005, 2.49, 4, "2023-01-03"),
								 (1006, 5.48, NULL, "2023-01-03");
UPDATE transactions SET order_date = "2023-01-01" WHERE transaction_id in (1000, 1001);
UPDATE transactions SET order_date = "2023-01-02" WHERE transaction_id in (1002, 1003);
UPDATE transactions SET order_date = "2023-01-03" WHERE transaction_id in (1004);
SELECT SUM(amount), order_date FROM transactions GROUP BY order_date;
SELECT MAX(amount), order_date FROM transactions GROUP BY order_date;
SELECT MIN(amount), order_date FROM transactions GROUP BY order_date;
SELECT AVG(amount), order_date FROM transactions GROUP BY order_date;

SELECT SUM(amount), customer_id FROM transactions GROUP BY customer_id;
SELECT MAX(amount), customer_id FROM transactions GROUP BY customer_id;
SELECT MIN(amount), customer_id FROM transactions GROUP BY customer_id;
SELECT AVG(amount), customer_id FROM transactions GROUP BY customer_id;
SELECT COUNT(amount), customer_id FROM transactions GROUP BY customer_id;
SELECT COUNT(amount), customer_id FROM transactions GROUP BY customer_id HAVING COUNT(amount) > 1 AND customer_id IS NOT NULL;

SELECT SUM(amount), order_date FROM transactions GROUP BY order_date WITH ROLLUP;
SELECT COUNT(transaction_id), order_date FROM transactions GROUP BY order_date WITH ROLLUP;
SELECT COUNT(transaction_id) AS "# of orders", customer_id FROM transactions GROUP BY customer_id WITH ROLLUP;
SELECT SUM(hourly_pay) AS "hourly_pay", employee_id FROM employees GROUP BY employee_id WITH ROLLUP;
COMMIT;

START TRANSACTION;
SET foreign_key_checks = 1;
DELETE FROM customers WHERE customer_id = 4;
INSERT INTO customers VALUES (4, "Poppy", "Puff", 2, "PPuff@gmail.com");
INSERT INTO transactions VALUES (1005, 2.49, 4, "2023-01-03");

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5,2),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL
);

ALTER TABLE transactions DROP FOREIGN KEY fk_customer_id;
ALTER TABLE transactions ADD CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL;
DELETE FROM customers WHERE customer_id = 4;

ALTER TABLE transactions ADD CONSTRAINT fk_transactions_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
UPDATE transactions SET customer_id = 4 WHERE transaction_id = 1005;
DELETE FROM customers WHERE customer_id = 4;

SELECT * FROM transactions;
SELECT * FROM customers;
COMMIT;

START TRANSACTION;
DELIMITER $$
CREATE PROCEDURE get_customers()
BEGIN
	SELECT * FROM customers;
END $$
DELIMITER ;
CALL get_customers();
DROP PROCEDURE get_customers;

DELIMITER $$
CREATE PROCEDURE find_customer(IN id INT)
BEGIN
	SELECT * FROM customers WHERE customer_id = id;
END $$
DELIMITER ;
CALL find_customer(3);
DROP PROCEDURE find_customer;

DELIMITER $$
CREATE PROCEDURE find_customer(IN f_name VARCHAR(50), IN l_name VARCHAR(50))
BEGIN
	SELECT * FROM customers WHERE first_name = f_name AND last_name = l_name;
END $$
DELIMITER ;
CALL find_customer("Larry", "Lobster");
DROP PROCEDURE find_customer;
COMMIT;

START TRANSACTION;
ALTER TABLE employees ADD COLUMN salary DECIMAL(10, 2) AFTER hourly_pay;
UPDATE employees SET salary = hourly_pay * 2080;
CREATE TRIGGER before_hourly_pay_update BEFORE UPDATE ON employees FOR EACH ROW SET NEW.salary = (NEW.hourly_pay * 2080);
SHOW TRIGGERS;
UPDATE employees SET hourly_pay = 50 WHERE employee_id = 1;
UPDATE employees SET hourly_pay = hourly_pay + 1;
SELECT * FROM employees;

DELETE FROM employees WHERE employee_id = 6;
CREATE TRIGGER before_hourly_pay_insert BEFORE INSERT ON employees FOR EACH ROW SET NEW.salary = (NEW.hourly_pay * 2080);
INSERT INTO employees VALUES (6, "Sheldon", "Plankton", 10, NULL, "janitor", "2023-01-07", 5);
SELECT * FROM employees;

CREATE TABLE expenses (
	expense_id INT PRIMARY KEY,
    expense_name VARCHAR(50),
    expense_total DECIMAL(10, 2)
);
INSERT INTO expenses VALUES (1, "salaries", 0),
							(2, "supplies", 0),
                            (3, "taxes", 0);
UPDATE expenses SET expense_total = (SELECT SUM(salary) FROM employees) WHERE expense_name = "salaries"; 
CREATE TRIGGER after_salary_delete AFTER DELETE ON employees FOR EACH ROW UPDATE expenses SET expense_total = expense_total - OLD.salary WHERE expense_name = "salaries";
DELETE FROM employees WHERE employee_id = 6;
CREATE TRIGGER after_salary_insert AFTER INSERT ON employees FOR EACH ROW UPDATE expenses SET expense_total = expense_total + NEW.salary WHERE expense_name = "salaries";
INSERT INTO employees VALUES (6, "Sheldon", "Plankton", 10, NULL, "janitor", "2023-01-07", 5);
CREATE TRIGGER after_salary_update AFTER UPDATE ON employees FOR EACH ROW UPDATE expenses SET expense_total = expense_total + (NEW.salary - OLD.salary) WHERE expense_name = "salaries";
UPDATE employees SET hourly_pay = 100 WHERE employee_id = 1;
SELECT * FROM expenses;
COMMIT;
