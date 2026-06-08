## 1. String Functions

| Function             | One-line Explanation                    | Example                                    |
| -------------------- | --------------------------------------- | ------------------------------------------ |
| `ASCII()`            | Returns ASCII value of a character.     | `SELECT ASCII('A');` → `65`                |
| `CHAR_LENGTH()`      | Returns string length in characters.    | `SELECT CHAR_LENGTH('Hello');` → `5`       |
| `CHARACTER_LENGTH()` | Same as `CHAR_LENGTH()`.                | `SELECT CHARACTER_LENGTH('SQL');` → `3`    |
| `CONCAT()`           | Joins multiple strings.                 | `SELECT CONCAT('Hello',' ','World');`      |
| `CONCAT_WS()`        | Joins strings using a separator.        | `SELECT CONCAT_WS('-', '2025','06','01');` |
| `FIELD()`            | Returns position of value in list.      | `SELECT FIELD('B','A','B','C');` → `2`     |
| `FIND_IN_SET()`      | Finds position in comma-separated list. | `SELECT FIND_IN_SET('B','A,B,C');`         |
| `FORMAT()`           | Formats a number with commas/decimals.  | `SELECT FORMAT(12345.678,2);`              |
| `INSERT()`           | Replaces part of a string.              | `SELECT INSERT('Hello',2,3,'ABC');`        |
| `INSTR()`            | Finds first occurrence of substring.    | `SELECT INSTR('Hello','ll');`              |
| `LCASE()`            | Converts to lowercase.                  | `SELECT LCASE('HELLO');`                   |
| `LEFT()`             | Returns leftmost characters.            | `SELECT LEFT('Hello',2);`                  |
| `LENGTH()`           | Returns length in bytes.                | `SELECT LENGTH('Hello');`                  |
| `LOCATE()`           | Finds substring position.               | `SELECT LOCATE('ll','Hello');`             |
| `LOWER()`            | Converts to lowercase.                  | `SELECT LOWER('HELLO');`                   |
| `LPAD()`             | Pads string on left.                    | `SELECT LPAD('123',5,'0');`                |
| `LTRIM()`            | Removes leading spaces.                 | `SELECT LTRIM(' Hello');`                  |
| `MID()`              | Extracts substring.                     | `SELECT MID('Hello',2,3);`                 |
| `POSITION()`         | Returns substring position.             | `SELECT POSITION('ll' IN 'Hello');`        |
| `REPEAT()`           | Repeats string.                         | `SELECT REPEAT('Hi',3);`                   |
| `REPLACE()`          | Replaces substring occurrences.         | `SELECT REPLACE('Hello','l','x');`         |
| `REVERSE()`          | Reverses string.                        | `SELECT REVERSE('Hello');`                 |
| `RIGHT()`            | Returns rightmost characters.           | `SELECT RIGHT('Hello',2);`                 |
| `RPAD()`             | Pads string on right.                   | `SELECT RPAD('123',5,'0');`                |
| `RTRIM()`            | Removes trailing spaces.                | `SELECT RTRIM('Hello ');`                  |
| `SPACE()`            | Returns specified spaces.               | `SELECT SPACE(5);`                         |
| `STRCMP()`           | Compares two strings.                   | `SELECT STRCMP('A','B');`                  |
| `SUBSTR()`           | Extracts substring.                     | `SELECT SUBSTR('Hello',2,3);`              |
| `SUBSTRING()`        | Extracts substring.                     | `SELECT SUBSTRING('Hello',2,3);`           |
| `SUBSTRING_INDEX()`  | Returns part before delimiter count.    | `SELECT SUBSTRING_INDEX('a,b,c',',',2);`   |
| `TRIM()`             | Removes leading/trailing spaces.        | `SELECT TRIM(' Hello ');`                  |
| `UCASE()`            | Converts to uppercase.                  | `SELECT UCASE('hello');`                   |
| `UPPER()`            | Converts to uppercase.                  | `SELECT UPPER('hello');`                   |

# 2. Numeric Functions

|Function|One-line Explanation|Example|
|---|---|---|
|`ABS()`|Returns absolute value.|`SELECT ABS(-10);`|
|`ACOS()`|Returns arc cosine.|`SELECT ACOS(0.5);`|
|`ASIN()`|Returns arc sine.|`SELECT ASIN(0.5);`|
|`ATAN()`|Returns arc tangent.|`SELECT ATAN(1);`|
|`ATAN2()`|Returns arc tangent of two values.|`SELECT ATAN2(2,1);`|
|`AVG()`|Returns average value.|`SELECT AVG(salary) FROM employees;`|
|`CEIL()`|Rounds up to nearest integer.|`SELECT CEIL(4.2);`|
|`CEILING()`|Same as CEIL.|`SELECT CEILING(4.2);`|
|`COS()`|Returns cosine value.|`SELECT COS(0);`|
|`COT()`|Returns cotangent value.|`SELECT COT(1);`|
|`COUNT()`|Counts rows.|`SELECT COUNT(*) FROM employees;`|
|`DEGREES()`|Converts radians to degrees.|`SELECT DEGREES(PI());`|
|`DIV`|Integer division.|`SELECT 10 DIV 3;`|
|`EXP()`|Returns e raised to power.|`SELECT EXP(2);`|
|`FLOOR()`|Rounds down to nearest integer.|`SELECT FLOOR(4.9);`|
|`GREATEST()`|Returns largest value.|`SELECT GREATEST(1,5,3);`|
|`LEAST()`|Returns smallest value.|`SELECT LEAST(1,5,3);`|
|`LN()`|Natural logarithm.|`SELECT LN(10);`|
|`LOG()`|Logarithm with optional base.|`SELECT LOG(10);`|
|`LOG10()`|Base-10 logarithm.|`SELECT LOG10(100);`|
|`LOG2()`|Base-2 logarithm.|`SELECT LOG2(8);`|
|`MAX()`|Maximum value.|`SELECT MAX(salary) FROM employees;`|
|`MIN()`|Minimum value.|`SELECT MIN(salary) FROM employees;`|
|`MOD()`|Returns remainder.|`SELECT MOD(10,3);`|
|`PI()`|Returns PI value.|`SELECT PI();`|
|`POW()`|Raises number to power.|`SELECT POW(2,3);`|
|`POWER()`|Same as POW.|`SELECT POWER(2,3);`|
|`RADIANS()`|Converts degrees to radians.|`SELECT RADIANS(180);`|
|`RAND()`|Generates random number.|`SELECT RAND();`|
|`ROUND()`|Rounds number.|`SELECT ROUND(12.345,2);`|
|`SIGN()`|Returns sign (-1,0,1).|`SELECT SIGN(-5);`|
|`SIN()`|Returns sine value.|`SELECT SIN(0);`|
|`SQRT()`|Returns square root.|`SELECT SQRT(25);`|
|`SUM()`|Returns total sum.|`SELECT SUM(salary) FROM employees;`|
|`TAN()`|Returns tangent value.|`SELECT TAN(1);`|
|`TRUNCATE()`|Truncates decimals.|`SELECT TRUNCATE(12.345,2);`|

# 3. Date Functions

|Function|One-line Explanation|Example|
|---|---|---|
|`ADDDATE()`|Adds interval to date.|`SELECT ADDDATE('2025-01-01',10);`|
|`ADDTIME()`|Adds interval to time.|`SELECT ADDTIME('10:00:00','02:00:00');`|
|`CURDATE()`|Current date.|`SELECT CURDATE();`|
|`CURRENT_DATE()`|Current date.|`SELECT CURRENT_DATE();`|
|`CURRENT_TIME()`|Current time.|`SELECT CURRENT_TIME();`|
|`CURRENT_TIMESTAMP()`|Current date & time.|`SELECT CURRENT_TIMESTAMP();`|
|`CURTIME()`|Current time.|`SELECT CURTIME();`|
|`DATE()`|Extracts date part.|`SELECT DATE(NOW());`|
|`DATEDIFF()`|Difference in days.|`SELECT DATEDIFF('2025-12-31','2025-01-01');`|
|`DATE_ADD()`|Adds interval.|`SELECT DATE_ADD(NOW(), INTERVAL 5 DAY);`|
|`DATE_FORMAT()`|Formats date.|`SELECT DATE_FORMAT(NOW(),'%d-%m-%Y');`|
|`DATE_SUB()`|Subtracts interval.|`SELECT DATE_SUB(NOW(), INTERVAL 5 DAY);`|
|`DAY()`|Day of month.|`SELECT DAY(NOW());`|
|`DAYNAME()`|Weekday name.|`SELECT DAYNAME(NOW());`|
|`DAYOFMONTH()`|Day of month.|`SELECT DAYOFMONTH(NOW());`|
|`DAYOFWEEK()`|Weekday index.|`SELECT DAYOFWEEK(NOW());`|
|`DAYOFYEAR()`|Day of year.|`SELECT DAYOFYEAR(NOW());`|
|`EXTRACT()`|Extracts date part.|`SELECT EXTRACT(YEAR FROM NOW());`|
|`FROM_DAYS()`|Converts day number to date.|`SELECT FROM_DAYS(1000);`|
|`HOUR()`|Returns hour.|`SELECT HOUR(NOW());`|
|`LAST_DAY()`|Last day of month.|`SELECT LAST_DAY(NOW());`|
|`LOCALTIME()`|Current date & time.|`SELECT LOCALTIME();`|
|`LOCALTIMESTAMP()`|Current date & time.|`SELECT LOCALTIMESTAMP();`|
|`MAKEDATE()`|Creates date.|`SELECT MAKEDATE(2025,100);`|
|`MAKETIME()`|Creates time.|`SELECT MAKETIME(10,20,30);`|
|`MICROSECOND()`|Returns microseconds.|`SELECT MICROSECOND(NOW());`|
|`MINUTE()`|Returns minutes.|`SELECT MINUTE(NOW());`|
|`MONTH()`|Returns month number.|`SELECT MONTH(NOW());`|
|`MONTHNAME()`|Returns month name.|`SELECT MONTHNAME(NOW());`|
|`NOW()`|Current date & time.|`SELECT NOW();`|
|`PERIOD_ADD()`|Adds months to period.|`SELECT PERIOD_ADD(202501,2);`|
|`PERIOD_DIFF()`|Difference between periods.|`SELECT PERIOD_DIFF(202512,202501);`|
|`QUARTER()`|Returns quarter.|`SELECT QUARTER(NOW());`|
|`SECOND()`|Returns seconds.|`SELECT SECOND(NOW());`|
|`SEC_TO_TIME()`|Seconds to time.|`SELECT SEC_TO_TIME(3600);`|
|`STR_TO_DATE()`|Converts string to date.|`SELECT STR_TO_DATE('01-06-2025','%d-%m-%Y');`|
|`SUBDATE()`|Subtracts interval.|`SELECT SUBDATE(NOW(),INTERVAL 5 DAY);`|
|`SUBTIME()`|Subtracts time.|`SELECT SUBTIME('10:00:00','01:00:00');`|
|`SYSDATE()`|Current system date & time.|`SELECT SYSDATE();`|
|`TIME()`|Extracts time part.|`SELECT TIME(NOW());`|
|`TIME_FORMAT()`|Formats time.|`SELECT TIME_FORMAT(NOW(),'%H:%i');`|
|`TIME_TO_SEC()`|Time to seconds.|`SELECT TIME_TO_SEC('01:00:00');`|
|`TIMEDIFF()`|Difference between times.|`SELECT TIMEDIFF('12:00:00','10:00:00');`|
|`TIMESTAMP()`|Creates timestamp.|`SELECT TIMESTAMP('2025-01-01');`|
|`TO_DAYS()`|Days since year 0.|`SELECT TO_DAYS(NOW());`|
|`WEEK()`|Week number.|`SELECT WEEK(NOW());`|
|`WEEKDAY()`|Weekday number.|`SELECT WEEKDAY(NOW());`|
|`WEEKOFYEAR()`|Week number of year.|`SELECT WEEKOFYEAR(NOW());`|
|`YEAR()`|Extracts year.|`SELECT YEAR(NOW());`|
|`YEARWEEK()`|Returns year and week.|`SELECT YEARWEEK(NOW());`|

# 4. Advanced Functions

|Function|One-line Explanation|Example|
|---|---|---|
|`BIN()`|Converts number to binary.|`SELECT BIN(10);`|
|`BINARY()`|Converts value to binary string.|`SELECT BINARY 'Hello';`|
|`CASE`|Conditional expression.|`SELECT CASE WHEN 10>5 THEN 'Yes' END;`|
|`CAST()`|Converts datatype.|`SELECT CAST('123' AS SIGNED);`|
|`COALESCE()`|First non-NULL value.|`SELECT COALESCE(NULL,NULL,5);`|
|`CONNECTION_ID()`|Current connection ID.|`SELECT CONNECTION_ID();`|
|`CONV()`|Converts number between bases.|`SELECT CONV('A',16,10);`|
|`CONVERT()`|Converts datatype/charset.|`SELECT CONVERT('123',SIGNED);`|
|`CURRENT_USER()`|Current authenticated user.|`SELECT CURRENT_USER();`|
|`DATABASE()`|Current database name.|`SELECT DATABASE();`|
|`IF()`|Returns value based on condition.|`SELECT IF(10>5,'Yes','No');`|
|`IFNULL()`|Replaces NULL value.|`SELECT IFNULL(NULL,'N/A');`|
|`ISNULL()`|Checks if value is NULL.|`SELECT ISNULL(NULL);`|
|`LAST_INSERT_ID()`|Last AUTO_INCREMENT value.|`SELECT LAST_INSERT_ID();`|
|`NULLIF()`|Returns NULL if values equal.|`SELECT NULLIF(10,10);`|
|`SESSION_USER()`|Current session user.|`SELECT SESSION_USER();`|
|`SYSTEM_USER()`|Current system user.|`SELECT SYSTEM_USER();`|
|`USER()`|Current user and host.|`SELECT USER();`|
|`VERSION()`|MySQL version.|`SELECT VERSION();`|

