## Virtual table to see the database structure.

```sql
SELECT * FROM SQLITE_MASTER;
```

## Creates a new table, with 3 columns.
- To Create an id for each row use `id INTEGER PRIMARY KEY`.
- To keep track of the highest ID for the row use `AUTOINCREMENT`.


```sql
CREATE TABLE t (a INT, b REAL, c TEXT);
CREATE TABLE t (id INTEGER PRIMARY KEY, a, b, c);
CREATE TABLE t (id INTEGER PRIMARY KEY AUTOINCREMENT, a, b, c);
```

- Creates a new table, makes sure it's not overwriting.

```sql
CREATE TABLE IF NOT EXISTS t (a, b, c);
```

## Data Types and Affinity 
- SQLite 3 uses manifest typing, the type values is determined by the value itself.
- SQLite has 5 storage classes: `NULL`,`INTEGER`, `REAL`, `TEXT` and `BLOB`.
- Dates and times are stored as `TEXT`, `REAL` or `INTEGER` depending on representation.
- Type affinity is a recommendation for the column data: `NONE`, `TEXT`, `NUMERIC`, `REAL`.
- Affinity is based upon column definition.

### TEXT Affinity
- Stores values as `NULL`,`TEXT`, or `BLOB`.
- Numerical data is converted to `TEXT`
- Column type contains one of the following: `CHAR`, `CLOB`, or `TEXT`.

### NUMERIC Affinity
- `NUMERIC` Affinity - stores values as `INTEGER` or `REAL`.
- Text is converted to `INTEGER` or `REAL` if conversion may be lossless and reversible.
- 15 significant digits must be preserved.
- If lossless conversion is not possible, the value is stored as `TEXT`.
- It is the default affinity if none of the other affinity rules are satisfied.
- Booleans are stored as integer values: 0 and 1.

### INTEGER Affinity
- `INTEGER` affinity - works like `NUMERIC` but prefers `INTEGER` storage
-  The column type contains string `INT`

### REAL Affinity
-  `REAL` affinity - works like `NUMERIC` but prefers `REAL` storage.
-  The column type contains `REAL`, `FLOAT` or `DOUB`

### NONE Affinity
-  `NONE` affinity - if the column type contains `BLOB` or no type specified.
-  `BLOB` is a Binary Large Object.
-  To store a Binary object create a column as `BLOB` or `NONE` and cast when inserting it.

```sql
CREATE TABLE t (a INT, b REAL, c TEXT, d BLOB);
CREATE TABLE t (a INT, b REAL, c TEXT, d BLOB);
INSERT INTO t VALUES (1,2,3,4);
INSERT INTO t VALUES ('one','two','three','four');
INSERT INTO t VALUES ('a','b','c');
INSERT INTO t VALUES ('1','2','3','4');
INSERT INTO t (d) VALUES (CAST('xxx' AS BLOB));
SELECT * FROM t;
SELECT TYPEOF(a), TYPEOF(b), TYPEOF(c), TYPEOF(d) FROM t;
```

## Representing Booleans in SQLite 3
- Booleans are stored as integers: 1 or 0.
- Any non-zero number is true, 0 is false.

```sql
CREATE TABLE booltest (a INT, b INT);
INSERT INTO booltest VALUES (0,1);
SELECT * FROM booltest;
SELECT
  CASE WHEN a THEN 'TRUE' ELSE 'FALSE' END as boolA,
  CASE WHEN B THEN 'TRUE' ELSE 'FALSE' END as boolb
  FROM booltest;
```

## IF Statement in SQLite 3
- SQLite does not have an If / Else statement.
- Use the `CASE` statement instead.

## Representing Date / Time in SQLite 3
- Use the SQLite `DATETIME` function.
    - Use `DATE()` for date only.
    - Use `TIME()` for time only.
- DATETIME('now') - uses the GMT time.
- DATETIME('now', 'localtime') - tries to find out local time.
- JULIANDAY() - gives the julian date at Greenwitch. Best for high resolution, precision and logs.
- STRFTIME - gives the unix time, number of seconds from Jan 1 1970.

```sql
CREATE TABLE t (d1 TEXT, d2 TEXT, d3 REAL, d4 INT);
INSERT INTO t VALUES (DATETIME('now'), DATETIME('now', 'localtime'), JULIANDAY(), STRFTIME('%s', 'now'));
SELECT d1, TYPEOF(d1), d2, TYPEOF(d2), d3, TYPEOF(d3), d4, TYPEOF(d4) FROM t;
SELECT DATETIME(d3), DATETIME(d4, 'unixepoch') FROM t;
```

## Type of Function to Find out the data types

```sql
SELECT TYPEOF(a), TYPEOF(b), TYPEOF(c) FROM t;
```

## Data Type Casting
- Useful to display the data in a differnet way than the way it was stored.
- Good for dollar amounts, to preserve precision.
- The `AS` keyword will name the new view column as Dollars.

```sql
SELECT CAST(b AS REAL) / 100 AS Dollars FROM i;
SELECT TYPEOF(CAST (1 AS TEXT));
```

## Add data to the database table

```sql
CREATE TABLE a (a,b,c);
CREATE TABLE b (d,e,f);

INSERT INTO a (a,b,c) VALUES ('A','B','C');
INSERT INTO a VALUES ('a','b','c');
INSERT INTO a (b,c) VALUES('B','C');

INSERT INTO b SELECT c, b, a FROM a;
--- INSERT INTO b (f,e,d) SELECT * FROM a;
```

## Updating the data in the database
- Use the `UPDATE` command to update the value in the database.
- Make sure to specify `WHERE` otherwire it will overwritte all data.

```sql
UPDATE t SET quote = 'Updated Quote' WHERE id = 4;
UPDATE t SET quote = 'New Quote', byline = 'Author' WHERE id = 4;
```

## Delete data from the database
- Can use an ID or any other identifier.
- Must include the `WHERE` clause, otherwise all of the data will be deleted.

```sql
DELETE FROM t WHERE id = 5;
DELETE * FROM track WHERE title='Fake Track';

DELETE * FROM track; -- will delete the whole table.
```

## View data from the database - SELECT
- To view data from the database use select
- Use `ROWID`, `OID`, `_ROWID_` to see the unique row id for each row.

```sql
SELECT Name FROM Country;
SELECT * FROM Country;
SELECT ROWID, Name, Code FROM Country;
```

Simple Selects:
```sql
SELECT * FROM SQLITE_MASTER;
SELECT * FROM album;
SELECT title, artist, label FROM album;
SELECT 'Hello, World' AS 'Bob';
SELECT id FROM album WHERE artist IN ('Jimi Hendrix', 'Johnny Winter');
```

Sub Select:
```sql
-- Sub Select
SELECT * FROM track WHERE album_id IN (
  SELECT id FROM album WHERE artist IN ('Jimi Hendrix', 'Johnny Winter')
);
```

Pseudo Join:
```sql
-- Pseudo Join
SELECT a.title AS album, t.title AS track, t.track_number
  FROM album AS a, track As t
  WHERE a.id = t.album_id
  ORDER BY a.title, t.track_number;
```

## Database Join
- Access relationship between tables in a relational database.
- Join uses 2 clauses - `JOIN` the table to join and `ON` the condition.
- Additional arguments can br `WHERE` for greater specificity.
- To order the data view in a particulat manner (alpha, numeric) use `ORDER BY`.

```sql
SELECT c.Name, l.Language
  FROM CountryLanguage AS l
  JOIN Country AS c
    ON l.CountryCode = c.Code
  WHERE c.Name = 'United States'
  ORDER BY l.Language
```

```sql
SELECT a.artist, a.title AS album, t.title AS track, t.track_number
  FROM track as t
  JOIN album as a
    ON t.album_id = a.id
  ORDER BY a.artist, album, t.track_number;
```

## Database Count Function
- Count the amount of matching results.

```sql
SELECT COUNT(*) FROM track;
```

## Database Index
- Creates an index for faster join operations
- Makes the writes slower

```sql
CREATE INDEX IF NOT EXISTS co_code ON Country (Code);
-- This statement is commented out.
```

## Delete a Table from the Database

```sql
DROP TABLE t;
DROP TABLE IF EXISTS t;
```

## SQLITE 3 Expressions
- Anythig that will return a value in SQLite.
- Expressions can be used anywhere a value can be used.
- Expression use values and operators.
    - Literal values can be integers, floating point numbers, strings, BLOBs, or NULLs.
    - Operators: `||` for string concatenation.
    - Arithmetic Operators: `* / % + -`
    - Comparison Operators: `<  >= = == != `
    - Boolean Operators: `AND OR`
    - Special Operators: 
        - `IS` and `IS NOT` for comparisons, 
        - `LIKE` and `GLOB` for pattern matching, 
        - `BETWEEN` for comparisons: `X BETWEEN Y AND Z` is equivalent to `X >= y AND X  100000000 ORDER BY Population DESC;

```sql
SELECT Name, Population FROM Country WHERE Population BETWEEN 5000000 AND 10000000 ORDER BY Population DESC;
SELECT Name FROM Country WHERE Name BETWEEN 'G' AND 'R' ORDER BY Name;
```

Expressions with `LIKE` and `GLOB`:

```sql
SELECT * FROM City WHERE Name LIKE 'z%' ORDER BY Name; -- Case insensitive
SELECT * FROM City WHERE Name LIKE '_w%' ORDER BY Name;
SELECT * FROM City WHERE Name GLOB '?w*' ORDER BY Name; -- Case sensitive and proprietary to SQLite
```

Expressions with Arithmetic:

```sql
SELECT Name, Population / 1000000 AS PopMM FROM Country
  WHERE PopMM > 100
  ORDER BY PopMM DESC;
```

Expressions with `IN`:

```sql
SELECT * FROM City WHERE CountryCode IN ('USA','GBR') ORDER BY Name;

SELECT * FROM City WHERE CountryCode IN
  ( -- Using a sub-select
    SELECT Code FROM Country WHERE Name IN ('United States', 'United Kingdom')
  )
  ORDER By Name;
```

Expressions with `CASE`:

```sql
CREATE TABLE booltest (a,b);
INSERT INTO booltest VALUES (0,1);
SELECT
  CASE WHEN a THEN 'TRUE' ELSE 'FALSE' END AS BoolA
  FROM booltest;
```

Expression with `||`

```sql
SELECT '$' || (CAST(1995 AS REAL) / 100);
```

## SQLite Core Functions

### Length
- Finding the length of the string.
- Can be used anywhere an expression can be used.

```sql
SELECT Name, Length(Name), Code FROM Country;
SELECT Name, LENGTH(Name) AS Len, Code FROM Country
  WHERE Len BETWEEN 10 AND 12
  ORDER BY Len DESC;
```

### Changing the Case of a String
- In SQLite all uppercase appear before the lowecase letters - binary collation.
- Can change the collation with `COLLATE NOCASE`.
- To change case use the `UPPER` and `LOWER` functions.

```sql
SELECT a, UPPER(a) FROM t;
SELECT LOWER(b) FROM t ORDER BY UPPER(a);
```

### Reading Parts of a String
- Use the `SUBSRT(COL, Start Index, Length of Substring)` function.
- The substring in SQLite is 1 based, starts with 1 and not 0.

```sql
SELECT SUBSTR(a, 1, 2) AS State, SUBSTR(a, 3) AS STValue;
```

### Replacing Parts of a String
- String marching replacements, no pattern or regex.
- Use the `REPLACE(COL, 'Thing', 'Other')` function.

```sql
SELECT REPLACE(a, 'Thing', 'Other') FROM t;
```

### Trimming Blank Spaces
- Use the `TRIM(a)` - for trimming the blank spaces both sides of the string.
- `LTRIM(a)` - trims only the left side of a string.
- `RTRIM(a)` - trims only the right side of a string.

```sql
SELECT TRIM(a) FROM t;
```

### Absolute Values of Numbers
- To get an absolute value of a number use the `ABS(a)`

```sql
SELECT a,b FROM t ORDER BY ABS(a);
```

### Rounding Numbers
- To round numbers use the `ROUND(a)` function to 0 decimal places.
- To round to 2 decimal places use the second argument - `ROUND(a,2)`

```sql
SELECT ROUND(b, 2) FROM t;
```

### Finding the Type Of a Value.
- Beacuse of the manifest typing of SQLite it is useful to find the type of a string.
- Use the `TYPEOF(a)` function.

```sql
SELECT a, TYPEOF(a) FROM t;
```

### Finding the Last Inserted Row ID
- Use the `LAST_INSERT_ROWID()`.
- Does not rely on the Primary Key, uses the SQLite internal Row ID.

```sql
SELECT LAST_INSERT_ROWID();
```

### Getting the Version of the SQLite Library
- Use the `SQLITE_VERSION()` function.
- Useful for feature detection, returns a string with the value.

```sql
SELECT SQLITE_VERSION();
```

### Writing User Defined Functions
- Written in C or the user defined language - eg PHP.


## SQLite Aggregate Function
- Functions that operate on multiple rows at a time.
- Example the `COUNT`, `WHERE` functions.
- The `GROUP BY` clause may be used with aggregates.
- The `HAVING` clause is like `WHERE` for aggregates.

```sql
SELECT CountryCode, AVG(Population) FROM City GROUP BY CountryCode;
SELECT CountryCode, AVG(Population) as AvgPop FROM City GROUP BY CountryCode HAVING AvgPop > 1000000;
```

### Counting Rows
- To count how many rows use the `COUNT(a)` functions.
- Usually `COUNT` does not count the rows that contain NULL, use the `*` to count them too.

```sql
SELECT COUNT(*) FROM City;
SELECT District, COUNT(*) FROM City GROUP BY District;
SELECT District, COUNT(*) AS Count FROM City GROUP BY District HAVING Count > 10 ORDER By Count DESC;
```

### Adding the Numeric Vlues in a Column
- To add the numer value of a column use the `SUM(a)` function.
- To get a floating point sum use the SQLite specific function `TOTAL(a)`.

```sql
SELECT SUM(Population) FROM Country;
SELECT TOTAL(Population) FROM Country;
SELECT Continent, SUM(Population) AS Pop FROM Country GROUP BY Continent ORDER BY Pop DESC;
```

### Finding Maximum and Minimum Values
- To find the maximum use the `MAX(a)` function.
- To find the minimum use the `MIN(a)` function.

```sql
SELECT Continent, MAX(SurfaceArea) FROM Country GROUP BY Continent;

SELECT c.Name, csa.Continent, csa.MaxSA FROM
  (SELECT Continent, MAX(SurfaceArea) AS MaxSA FROM Country GROUP By Continent) AS csa
  JOIN Country AS c
    ON c.SurfaceArea = csa.MaxSA
  ORDER BY MaxSA DESC;
```

### Finding Averages within AVG
- Finds the average in a numeric column.

```sql
SELECT AVG(Population) FROM City;

SELECT District, AVG(Population) AS AVGPop 
  FROM City 
  GROUP BY District 
  HAVING AVGPop > 1000000
  ORDER BY AVGPop DESC;
```

### Grouping Results
- Grouping the results with the `GROUP BY expression` function.
- All the rows that have the same result for the expression will be grouped.
- The name on the left side of the select and the group by should be the same to correspond to the results correctly.

```sql
SELECT District, COUNT(*) FROM City GROUP BY District;
```

### Select for Aggregation with HAVING
- `HAVING` to aggregate is like `WHERE` to rows.
- If `WHERE` is used, a syntax error will be thrown.

```sql
SELECT District, AVG(Population) AS AVGPop 
  FROM City 
  GROUP BY District 
  HAVING AVGPop > 1000000
  ORDER BY AVGPop DESC;
```

## Collation
- Collation order or collation sequence is how SQLite compares or sorts data.
- SQLIte supports 3 collation orders:
    - BINARY - compares according to the numeric value of binary content.
    - NOCASE - 26 uppercase ASCII characters are treated as equivalent to their lowercase counterparts.
    - RTRIM - like BINARY, but ignores trailing spaces.
- Collation may be specified in the column definition:
- Collation may be specified using the `COLLATE` operator:

```sql
CREATE TABLE t (..., column_name TYPE COLLATE BINARY, ...)
SELECT * FROM t COLLATE BINARY;
```

### Sort Data
- To sort results use the `ORDER BY` function
- By default sorts small to large.
- Use the `DESC` to sort large to small.

```sql
SELECT * FROM Country ORDER BY Region, Population DESC;
```

### Removing Duplicates
- To ensure that the results are unique use the `DISTINCT` function.
- Operates on all of the expression in the clause, makes sure each row in the result is distinct.
- Like GROUP BY but without the aggregation.

```sql
SELECT DISTINCT Region FROM Country;
```

### Indexes
- Table is optimized for storage - many rows and columns.
- Index is optimized for seaching - many rows one column.
- Indexes take space and slow down INSERTs, its best to test to make sure that we get the best results possible.

```sql
CREATE INDEX co_code ON Country(Code);
CREATE INDEX ci_code ON City(CountryCode);

SELECT co.name, AVG(ci.Population) AS AvgPop
  FROM City AS ci
  JOIN Country AS co
    ON co.Code = ci.CountryCode
  GROUP BY ci.CountryCode
  ORDER BY AvgPop DESC;
```

### Primary Key Indexes
- Used to create a unique and priary key for the index.
- Only one unique primary key is allowed per table.
- The primary way that other tables will find records in this table.
- `NULL` values are not disallowed in priary key values - this is non standard and shoule be avoided.

```sql
CREATE TABLE t (code PRIMARY KEY, value TEXT, ycode UNIQUE);
CREATE TABLE x (code NOT NULL PRIMARY KEY, value TEXT, ycode UNIQUE);
```

### Integer Primary Key
- Each row in a table has a unique ID.
- Guaranteed to be unique and most of the time sequential.
- Row id can be defined explicitly by `id INTEGER PRIMARY KEY`
- Does not add anything else to the table, does not take any extra space.
- It's an alias to the row id that is already there.
- Can use the keyword `AUTOINCREMENT` to increment the values one higher that there ever was in the table, even if rows are deleted. Creates another table in the database - sqlite_sequence.

```sql
SELECT ROWID, a, b, c FROM t;
SELECT oid, a, b, c FROM t;

CREATE TABLE t (id INTEGER PRIMARY KEY AUTOINCREMENT, a, b, c);
SELECT _rowid_, a, b, c FROM t;
```

## Transactions
- Transaction ensure data integrity and increase the performance of databases.
- SQLite is ACID-compliant - Atomicity, Consistency, Isolation, Durability.
- SQLite accomplished this by using transactions.
    - When there are one or more operations
    - They are written to the database when it is complete
    - They are rolled back if it cannot be completed
    - They are locked while a transaction is in progress
- Transactions may be used to improve performance - one wite is faster than 100 writes.
- Transactions ensure that operations happen atomically - when multiple tables are affected if it fails, it fails on all. All done in one swoop. All or nothing.
- Use the `BEGIN;`, `COMMIT;`, and `ROLLBACK;` keywords.

```sql
BEGIN;
INSERT INTO sale (item_id, quantity, price) VALUES (4, 12, 19295);
UPDATE inventory SET quantity = ( SELECT quantity FROM inventory WHERE id = 4) - 12 WHERE id = 4;
COMMIT;
```

## Subselects and Views
- Shows the data in a differnt way that it is organized in the database.
- Subselects are nested SELECT statements, can be many levels deep.

```sql
SELECT * FROM trck WHERE album id IN
  (SELECT id FROM album WHERE artist = 'Jimi Hendrix');
```

- Subselects may be stored as VIEWS so they can be easily reused.
- A view may be used in place of subselect.
- Views can be used anywhere where any other query can be used.
- To view the stored viewed need to query the SQLITE_MASTER pseudo table.

```sql
CREATE VIEW JoinedAlbum AS
  SELECT a.artist AS artist, a.title AS album, t.track_number AS trackno, 
         t.title AS track, t.duration / 60 AS m, t.duration % 60 AS s
  FROM track AS t 
  JOIN album a ON a.id = t.album_id;
  
SELECT artist, album, tack, trackno,
  m || ':' CASE WHEN s<10 THEN &#039;0&#039; || s ELSE s END AS duration
  FROM JoinedAlbum;
  
  SELECT * FROM SQLITE_MASTER WHERE type=&#039;view&#039;;
```

- The best way to work with subselect is to break the problem into 2 parts: the inner select and the outer select.

```sql
SELECT co.Name, tt.CoValue FROM )
    SELECT SUBSTR(b, 1, 2) AS Country, SUBSTR(b, 3) AS CoValue FROM t
    ) as tt
    JOIN Country AS co ON tt.Country = co.Code2;
```