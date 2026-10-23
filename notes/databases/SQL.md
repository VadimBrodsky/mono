# SQL

## PostgreSQL

### Exposes commands in shell:
- `createdb`
- `dropdb`
- `psql`

### Postgres Interactive Terminal

```shell
psql <dbname> -C   # run a single SQL command
psql -U <username> # connect to server with a given user
```

### Listing Databases and Tables
- `\list` or `\l` list all databases
- `\connect` or `\c` to connect to a database
- `\dt` to list tables

### Quotes in SQL
- Usually table names, column names and keywords are case insensitive
- Single quotes are used for string literals
- Double quotes or backticks (mysql only) for words that conflict with SQL keywords, or when case sensitivity is desired

```sql
SELECT id from Employee;
SELECT Id from Employee;
SELECT 'id' from Employee;
SELECT "Id" from Employee;
```

### SELECT
- Returns a result set
- `FROM` allows one or more elements to be returned from a relation
- Elements are returned in the order the are asked for
- Generally a bad form to select `*`
  - Future schema changes will not affect results
  - Developer intent is clear
  - Less I/O

### AS
- The `AS` keyword can be used to give a table or column a local name or "alias"
- Only impacts the current query

```sql
SELECT p.productname AS title FROM Product AS P;
```

### WHERE
- Used to filter result set with a condition
- The condition is a predicate what evaluates to true, false or undefined

```sql
SELECT firstname, lastname FROM Employees WHERE lastname = 'Leverling';
```

#### Conditions

```sql
-- `<`, `>`, `>=`, `<=`, `=`
age > 21

-- Not equal: `<>`, or `!=`
isDeleted != TRUE

-- Within a range
temperature BETWEEN 68 AND 75

-- Member of a set
companyname IN ('Microsoft', 'LinkedIn')

-- String ends with
email LIKE '%.gov'

-- String includes
summary LIKE '%spicy%'

-- String length
blilling_state LIKE '__'

-- Case insensitive ILIKE (Postgres only)
email ILIKE '%gmail.com'
```

#### Boolean
- Boolean logic operators
- Operate on conditions
- Brackets for clarity

```sql
SELECT productname FROM Product WHERE (unitprice > 60 AND unitsinstock > 20);
```

### Core Functions
- Each database set of core functions is slightly different
- Some work across databases `lower, max, min, count, substr, etc...`
- Can be used in a comparison or as an additional column

```sql
SELECT productname FROM Product WHERE lower(productname) LIKE '%dried%';
SELECT lower(productname) AS label FROM Product;
```

### Debugging Conditions
- Conditions can be evaluated directly with a `SELECT` statement

```sql
SELECT 'jonathan@example.com' LIKE '%@example.com'; -- TRUE
SELECT 'jonathan@gmal.com' LIKE '%@example.com';    -- FALSE
```

### Sorting
- An `ORDER BY` clause declares the desired sorting of the result set
- Specify sort direction as `ASC` or `DESC`
- Multiple sorts and directions may be provided, separated by commas

```sql
SELECT productname, unitprice FROM Product ORDER BY unitprice DESC;

SELECT productname, unitprice
FROM Product
WHERE unitprice BETWEEN 9.6 AND 11
ORDER BY unitprice ASC, productname DESC;
```

### Limiting
- When dealing with large result sets, sometimes we just want the first N rows
- A `LIMIT` clause allows us to specify how many we want
- Performance can be much higher, if the database doesn't have to examine each record for sorting purposes

```sql
SELECT productname, unitprice
FROM Product
ORDER BY unitprice DESC
LIMIT 3;
```

### Offsetting
- Means to start with the Nth result
- We can paginate over a set of results using a `LIMIT` and `OFFSET`

```sql
SELECT productname, unitprice
FROM Product
ORDER BY unitprice DESC
LIMIT 3
OFFSET 3;
```

### JOIN: Assemble tables together
- The `JOIN`ing is done on a related column between the tables
- Four types of join, that differ in terms of how "incomplete" matches are handled
- `LEFT`, `RIGHT` and `FULL JOIN` are sometimes referred to as `OUTER` joins
- In general, an `OUTER` join allows for the possibility that one or more rows may be partially empty, due to not having a corresponding match in the other table
- `SELECT *` is generally a bad idea, and it's particularly dangerous in the context of a `JOIN`
- Choose columns with care, and alias any duplicates


#### INNER JOIN
- Only rows that have "both ends" of the match will be selected
- Incomplete matches will not be selected

```sql
SELECT *
FROM CustomerOrder AS o
INNER JOIN Customer AS c
ON o.customerId = c.id;
```

```sql
SELECT o.id, o.customerid, o.amount, c.name
FROM CustomerOrder AS o
INNER JOIN Customer AS c
ON o.customerid = c.id;
```

#### LEFT JOIN
- Rows from LEFT of join will be selected no matter what

```sql
SELECT *
FROM CustomerOrder AS o
LEFT JOIN Customer AS c
ON c.id = o.customerId;
```

#### RIGHT JOIN
- Rows from RIGHT of join will be selected no matter what

```sql
SELECT *
FROM CustomerOrder AS o
RIGHT JOIN Customer AS c
ON o.customerId = c.id;
```

#### FULL JOIN
- All rows in both tables are selected

```sql
SELECT *
FROM CustomerOrder AS o
FULL JOIN Customer AS c
ON o.customerId = c.id;
```

### Aggregate Functions
- Perform a calculation on a set of values, to arrive at a single value
- Each RDBMS has its own functions, but they all generally have a foundational set:
  - `SUM` Adds values together
  - `COUNT` Counts the number of values
  - `MIN`/`MAX` Find the min/max values
  - `AVG` Calculates the mean of the values

```sql
SELECT sum((1 - discount) * unitprice * quantity)
AS revenue
FROM OrderDetail;
```

#### Aggregate Functions and GROUP BY
- Imagine we have this JOIN query, and we total amount per customer
- This involves finding the relevant rows to consolidate and summing them up
- A relational DB is perfect for this tasks
- When you `SELECT`, aggregate and `GROUP BY` must agree

```sql
SELECT c.id, c.name, o.amount
FROM CustomerOrder AS o
INNER JOIN Customer AS c
ON o.customerid = c.id;
```

- We can specify which rows to consolidate via a `GROUP BY` clause
- Then we can `SELECT` an aggregate function, describing what to do on the groups of rows

```sql
SELECT c.id, c.name, sum(o.amount)
FROM CustomerOrder AS o
INNER JOIN Customer AS c
ON o.customerid = c.id
GROUP BY c.id;
```

#### Concatenating In Aggregate
- Concatenating string together can be done in most databases

```SQL
-- MySQL
SELECT group_concat(productname ORDER BY productname DESC SEPARATOR ', ') FROM PRODUCT;

-- SQLite
SELECT group_concat(productname, ', ') FROM Product;

-- PG
SELECT string_agg(productname, ', ') FROM Product;
```

#### Filtering grouped results
- A `WHERE` clause is used to examine individual rows
- It cannot be used with an aggregate function
- A `HAVING` clause is used to examine groups, and include or exclude them from the result set
- It fine to use both in the same query, sometimes increasing performance of the query
  - `WHERE` to disregard irrelevant rows
  - `HAVING` to disregard irrelevant groups

```sql
-- error: column "month_sum" does not exist
SELECT month, sum(amount) A SS month_sum
FROM CustomerOrder
WHERE month_sum >= 300
GROUP BY month;
```

```sql
-- HAVING instead of WHERE which  happens after the grouping
SELECT month, sum(amount) AS month_sum
FROM CustomerOrder
GROUP BY month
HAVING sum(amount) >= 300;
```

### Subquery
- A `SELECT` query can be nested in another query
- Useful when results from the database are needed in order to define "outer" query
- Inner query cannot  mutate data
- Sometimes the RDBMS doesn't support `ORDER BY` within the subquery (MySQL)

```sql
SELECT *
FROM Product
WHERE categoryid=(
  SELECT id
  FROM Category
  WHERE categoryname='Beverages'
);
```

Group by multiple rows

```sql
SELECT cusomerid, month, sum(amount)
FROM CustomerOrder
GROUP BY month, customerid;
```

### Creating Records
- Add new records to a table via an `INSERT INTO` statement, indicating the table to insert into
- This must be followed by a `VALUES` expression, with an array containing the corresponding data
- In the order aligned with the table columns
- Anytime new data is added to the database it must be sanitized to avoid SQL injection attacks
- SQL driver / library helps to avoid SQL injection, by adding placeholders in the query that get sanitized

```sql
INSERT INTO Customer VALUES (8424, 'Johny Appleseed', 'Likes apples');
INSERT INTO Customer (name, notes) VALUES ('Johny Appleseed', 'Likes apples');
```

```javascript
db.exec(`INSERT INTO Customer (name, notes) VALUES ($1, $2)`, ['Johny Appleseed', 'Likes apples']);
```

### Deleting Records
- Delete a table completely, including column definitions, indices, etc...
- Delete all records from a table, while leaving the structure and indices intact
- One or more rows can be deleted while leaving the rest intact, via a `WHERE` clause

```sql
DROP TABLE Customer;
DELETE FROM Customer;
DELETE FROM Customer WHERE name = 'Juicero';
```

### Transactions
- Sometimes we need to perform a multi-statement operations (create an `Order` and several `OrderDetail` items)
- What would happen if the `Order` was created, but something went wrong with creating one of the `OrderDetails`s?
- A half valid state of inserting a row is worse than failing completely
- Surround multiple statements with `BEGIN` and `COMMIT` to include them in a transaction
- Can include multiple rounds of communication between the database and the server

```sql
INSERT INTO CustomerOrder ...; -- create new order
INSERT INTO OrderDetail   ...; -- add order item to it
INSERT INTO OrderDetail   ...; -- something goes wrong
```

```sql
BEGIN;
INSERT INTO CustomerOrder ...; -- create new order
INSERT INTO OrderDetail   ...; -- add order item to it
INSERT INTO OrderDetail   ...;
INSERT INTO OrderDetail   ...;
COMMIT;                        -- save
```

```sql
BEGIN;
INSERT INTO CustomerOrder ...; -- create new order
INSERT INTO OrderDetail   ...; -- add order item to it
INSERT INTO OrderDetail   ...; -- something goes wrong
ROLLBACK;                      -- revert
```

#### ACID
Principles that guarantee data consistency, even when things go wrong:
- Atomic - All of the operations are treated as a single "all or nothing" unit
- Consistent - Changes from one valid state to another (never halfway)
- Isolated - How visible are particulars of a transaction before it is complete? When? To whom?
- Durable - Once it completes, the transaction's results are  stored permanently in the system

##### Transaction Isolation Levels
- The degree to which other  queries to the database can see, or be influenced by an in-progress transaction
- Often this a concurrency vs safety and consistency trade-off
- Fist described in the ANSI SQL-92  standard
- Read Uncommitted - Dirty reads are possible
- Reads Committed - Write locks are obtained across the whole transaction, read locks are obtained only for the duration of a `SELECT`. Dirty reads are not possible
- Repeatable Read - Read and write locks are obtained across the whole transaction
- Serializable- Read and write locks are obtained on selected data, range locks are obtained for `WHERE` clauses, highest level of isolation
- Externally consistent - Google Spanner / CockroachDB

##### Read Phenomena: Dirty Reads
- Able to read the isolated private state in a different SQL statement
- Reading the values of row while its being in a transaction that rolled back
- Reads committed isolation makes this impossible

```sql
BEGIN;
SELECT month FROM CustomerOrder WHERE id = 21;

-- meanhile
BEGIN;
UPDATE CustomerOrder SET month=4 WHERE id = 21;

-- dirty read
SELECT month FROM CustomerOrder WHERE id = 21;

-- rollback the update
ROLLBACK;
```

##### Read Phenomena: Non-Repeatable Reads
- Long running transaction sees changes that another transaction committed to the database
- Repeatable read isolation makes this impossible

```sql
BEGIN;
SELECT month FROM CustomerOrder WHERE id = 21;

-- meanwhile
BEGIN;
UPDATE CustomerOrder SET month=4 WHERE id = 21;
COMMIT;

-- non-repeatable read
SELECT month FROM CustomerOrder WHERE id = 21;
```

##### Read Phenomena: Phantom Reads
- Long running transaction that aggregates data from a range get inconsistent result due another transaction inserting data in to the range
- Serializable isolation makes this impossible

```sql
BEGIN;
SELECT sum(amount) FROM CustomerOrder WHERE month BETWEEN 10 and 12;

-- meanwhile
BEGIN;
INSERT INTO CustomerORder(cusomer_id, amount, month) VALUES (22, 40000, 3);
COMMIT;

-- phantom read
-- gets different result
SELECT sum(amount) FROM CustomerOrder WHERE month BETWEEN 10 and 12;
COMMIT;
```

#### Databases & Storage Engines
- PostgreSQL - MVCC storage engine, and possible changes in v12
- MYSQL
  - InnoDB - supports transactions, and is the best default choice
  - MyISAM - no transactions, faster and smaller in some cases
- SQLite


### Updating Records
- One or more records may be updated at a time
- Sometimes we want to use current values to calculate new ones

```sql
UPDATE OrderDetail SET discount = 0.15 WHERE orderid = 10793;
```

```sql
-- cannot be applied multiple times
UPDATE OrderDetail SET discount = 0.15, unitprice = (1 - 0.15) * unitprice
WHERE orderid = 10793;
```

```sql
-- idempotnent, be able to run multiple times with the same result
UPDATE OrderDetail SET discount = 0.15, unitprice = (1 - 0.15) * (
  SELECT unitprice FROM Product WHERE id = OrderDetail.productid
) WHERE orderid = 10793;
```

### Insert or Update (Upsert)
- Many RDBMS's allow for some sort of Insert or Update command
- Widely different implementations and usage - not standard SQL
- PostgreSQL (10.x) is the most flexible
- SQLite (3.22.x) only allows Insert or Replace
- MySQL (4.1) On conflict


### Changing the schema
- We usually have at least one DB per environment (dev, test, staging, prod)
- Applications that connect to a DB have a hard dependency on a particular schema
- Having reproducible versions includes the database
- A happy state, a given git commit (or a set of commits) = reproducible version

#### Migrations
- Incremental changes to a database
- Ideally, reversible
- May start with an initial seed script
- Applied migrations are stored in a special DB table
- Ideally backwards compatible

#### Migrations in Node
- A simple and popular solutions: db-migrate/node-db-migrate
- Migrations are named and prefixed by time stamp (chronological sorting)
- Can be purely JS based, or JS that runs SQL scripts
- ENV var `DATABASE_URL` takes precedence

```shell
# generate a migration
./node_modules/.bin/db-migrate create MyMigration --sql-file
```

```shell
# running forward
./node_modules/.bin/db-migrate -e pg up
```

```shell
# running down
./node_modules/.bin/db-migrate -e pg down
```

### Indices - Memory for time trade-off
- Extra bookkeeping performed on records for quick retrieval later
- Useful to use `EXPLAIN` on a SQL query to see the performance and the impact of indices
- Indices can be created on multiple columns
- When creating indices the goal is to reduce and possibly eliminate the exhaustive searching done for common or performance sensitive queries

```sql
CREATE INDEX orderdetail_oid ON OrderDetail(orderid);
```

```sql
CREATE INDEX orderdetail_order_customer
ON OrderDetail(orderid, cusomer_id);
```

### Column Constraints - Types
- One of the ways we can constrain values placed in particular columns by types
- Names and properties of these types may vary from system to system
- Choice of column type impacts performance and options for indexing and filtering

#### Creating a Table
- Creating a table gives us the opportunity to define columns as names / type pairs
- We can forbid null values for one or more column by adding `NOT NULL`
- A uniqueness constraint may be added to a column via `UNIQUE`, creates an index behind the scenes
- Primary Key - a combination of `NOT NULL` and `UNIQUE` constraint
- Often will have one identity column  in each table that serves as the id for each addressable record
- Often we want the IDs to auto-increment
  - In MySQL we have to specify `AUTO_INCREMENT`
  - In PostreSQL we create a `SEQUENCE` as our source of incrementing values, the `SERIAL` types does this automatically
  - In SQLite an implicit `rowid` column, unless explicitly opt out, but can run into id reuse problems wen we delete rows and add new ones
- Foreign keys - used to enforce the other end of a relationship, validates against a column in a foreign table

```sql
CREATE TABLE UserPreferences (
  id             INT PRIMARY KEY NOT NULL, -- an interger
  favorite_color CHAR(6), --exactly 6 characters
  age            SMALLINT, -- a small integer
  birth_date     DATE NOT NULL, -- date (may or may not include time)
  notes          VARCHAR(255), -- up to 255 characters
  is_active      BOOLEAN NOT NULL -- boolean
);
```

```sql
CREATE TABLE UserAccount (
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255)
);
-- manually create the index
CREATE UNIQUE INDEX u_email ON UserAccount(email);
```

```sql
-- MySQL
CREATE TABLE UserAccount (
  email VARCHAR(255) PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
);
```

```sql
-- PostgreSQL
CREATE SEQUENCE UserAccount_id_seq;
CREATE TABLE UserAccount (
  id INTEGER PRIMARY KEY DEFAULT nextval('UserAccount_id_seq'),
  name VARCHAR(255)
);
ALTER SEQUENCE UserAccount_id_seq OWNED BY UserAccount.id;
```

```sql
-- PostgreSQL
CREATE TABLE UserAccount(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
);
INSERT INTO UserAccount(name) VALUES ('foo');
```

```sql
-- SQLite
CREATE TABLE UserAccount (name TEXT);
INSERT INTO UserAccount(name) VALUES ('foo'), ('bar'), ('baz');

SELECT rowid, name FROM UserAccount;
```

```sql
-- SQLite using AUTOINCEMENT to avoid reusing ids
CERATE TABLE UserAccount (
  id INTEGER PRIMARY KEY AUTOINCEMENT,
  name TEXT
);
```

```sql
-- Foregin keys
CREATE TABLE Customer (id SERIAL PRIMARY KEY), name VARCHAR(255)
CREATE TABLE CustomerOrder (
  id SERIAL PRIMARY KEY,
  customerid INTEGER NOT NULL REFERENCES Customer(id),
  amount REAL,
  month INTEGER DEFAULT 5 NOT NULL
);
```

### Triggers
- A function stored in the database, bound to the table it operates on
- Executed either before or after several specific events (Insert, Update, Delete, etc...)
- Can run on a per-statement or per-row basis
- May be mysterious if database consumers don't know a trigger exists

```sql
-- MySQL
CREATE TRIGGER LogPermissionChange
  AFTER UPDATE ON User
  FOR EACH ROW
BEGIN
  IF OLD.permissions != NEW.permissions THEN
    INSERT INTO UserPermissionsLog (userid, before, after, changed_at)
    VALUES (OLD.id, OLD.permissions, NEW.permissions, NOW());
  END IF;
END;
```

```sql
---PostgreSQL
CREATE TRIGGER LogPermissionChange
  AFTER UPDATE ON User
  FOR EACH ROW EXECUTE PROCEDURE log_user_permissions();

-- reuse the same stored procedure on INSERT
CREATE TRIGGER LogPermissionChange
  AFTER EACH INSERT ON User
  FOR EACH ROW EXECUTE PROCEDURE log_user_permissions();

-- create the stored procedure
-- also can CREATE OR REPLACE FUNCTION
CREATE FUNCTION log_user_permissions()
  RETURNS trigger AS
$$
BEGIN
  IF OLD.permissions != NEW.permissions THEN
    INSERT INTO UserPermissionLog (userid, before, after, changed_at)
    VALUES (OLD.id, OLD.permissions, NEW.permissions, NOW());
  END IF;
  RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';
```

Stored procedures can be used for more than just triggers

```sql
CREATE FUNCTION addition(a INTERGER, b INTEGER) RETURNS INTEGER AS
$$
BEGIN
  RETURN a + b;
END;
$$
LANGUAGE 'plpgsql';

-- used
SELECT add_numbers(3, 5) AS the_answer;
```

### Views
- Named `SELECT` query that is stored in the database
- DRY principle works for databases too
- Re-calculated each time they run
- User access can be restricted

```sql
CREATE VIEW top_product_sales AS
  SELECT p.id, p.productname, sum(od.quantity * od.unitprice) AS sales
  FROM Product AS p
  LEFT JOIN OrderDetail AS od ON od.productid = p.id
  GROUP BY p.id
  ORDER BY sales DESC LIMIT 4;

-- use the view
SELECT * FROM top_product_sales;
```

### Prepared Statements
- Often DB driven applications involve many very similar calls to the database
- Each of these has to to be parsed as if it's a completely new query
- Pre-parsed SQL queries without values
- Sent to the database in binary format for direct use along with values
- Security benefit: queries are parsed without involving untrusted values
- Client side prepared statements live in memory and need to be re-established each time we make a new connection to the database

```javascript
// example js implementation
const setupPreparedStatementes = async (db) => ({
  getCustomers: await db.prepare('SELECT * FROM Customer'),
});
// use
let customers = await db.statments.getCustomers.all();
```

### Materialized Views
- Like views, the query that defines it lives in the database
- Results are not re-calculated on each query
  - Temporary read-only table
  - containing the view's result set
  - have to deliberately refresh it
- Support
  - PostgreSQL officially supports it
  - Not supported in SQLite
  - Not supported in MySQL officially, there is a hack
- Refreshing a materialized view  is usually done in a trigger

```sql
-- PostgreSQL
CREATE MATERIALIZED VIEW MV_ExampleAccounts AS
  SELECT * FROM UserAccount WHERE lower(email) LIKE '%example.com';

-- use it
SELECT email FROM MV_ExampleAccoutns;

-- refresh
REFRES MATERIALIZED VIEW MV_ExampleAccounts;
```

#### MySQL - Materialized Views
- Not officially supported
- Can build a polyfill
  - Query is stored in the DB
  - Results are cached and can be queried against
  - Run SQL to update the cached data

```sql
-- MySQL
-- Step 1: Define a regular view  to store the query
CREATE IF NOT EXISTS VIEW V_CustomerStats AS
  SELECT ...;

-- Step 2: Create a new table based on the view result set
CREATE TABLE MV_CustomerStats AS SELECT * FROM V_CustomerStats;
CREATE INDEX MV_CustomerStatsId ON MV_CusomerStats(id);

-- Step 3: Get the table's result set
SELECT * FROM MV_CusomerStats;

-- Step 4: Refresh the data in the table, using RENAME query
-- Create a new table for the updated result set
CREATE TABLE MV_CustomerStats_new AS SELECT * FROM V_CustomerStats;
CREATE INDEX MV_CUstomerStatsId ON MV_CustomerStats_new(id);

-- Move the new table into position and the old one out of position
-- in the same RENAME query
RENAME TABLE MV_CustomerStats TO MV_CustomerStats_old, 
             MV_CustomerStats_new TO MV_CustomerStats;

-- Get rid of the old data
DROP TABLE MV_CustomerStats_old;
```

### NoSQL
- Includes things like wide-column stores (hbase), key value stores (redis, dynamodb), document stores (mongodb)
- Often sacrifice consistency in favor of availability, cluster-ability and speed

#### NoSQL: Document Stores
- Instead of tuples being stored in relations, we have documents in stores
- Common examples: INdexedDB, MongoDB, CouchDB
- Document - JSON++ (binary values are usually ok)
- Often a much more efficient way to store sparse data

#### JSON and Array Column Types
- Much more than just stringified JSON stored in a column
- Ability to query deep into hierarchical objects
- Depending on RDBMs, deep indexing may be possible
- PostgreSQL 9.2+ support: very good
- MySQL 5.7.8+ support: Ok
- SQLite with JSON1 Extension: Meh

#### Creating a JSON column
- PostreSQL allows a default value, MySQL does not
- `NOT NULL` and `UNIQUE` apply as usual
- Lots of JSON functions for constructing, manipulating, searching and serializing JSON

```sql
-- MySQL
CREATE TABLE IF NOT EXISTS StoreItem (
  label TEXT NOT NULL,
  colors JSON
);

INSERT INTO StoreItem(label, colors)
VALUES('Hats', '{ "small": ["red", "blue"], "medium": ["green"], "large": [] }');
INSERT INTO StoreItem(label, colors)
VALUES('Flash Drives', '{"capacity64gb": ["silver"]}');

-- Create a JSON array ["one", "two", "three"]
SELECT JSON_ARRAY('one', 'two', 'three');

-- Create a JSON object {"a": "First", "b": "Second"}
SELECT JSON_OBJECT('a', 'First', 'b', 'Second');
```

#### MySQL and JSON: Searching
- `JSON_SEARCH` can be used for finding a value within a JSON object

```sql
-- MySQL
SELECT JSON_SEARCH(
  -- Check for the presence of a value within an array
  -- ["foo", "bar", "baz"]
  JSON_ARRAY('foo', 'bar', 'baz'),
  'all', -- find "one" or "all" results?
  'ba%'  -- thing to find, wildcard % is allowed
); -- ["$[1]", "$[2]"]

SELECT JSON_SEARCH(
  JSON_OBJECT('properties', JSON_ARRAY('foo', 'bar', 'baz')),
  'one',
  'ba%'
); -- ["$.properties[1]", "$.properties[2]"]
```

```sql
-- MySQL
SELECT * FROM StoreItem
WHERE JSON SEARCH(lower(colors->"$.small[*]")), 'one', lower('red') IS NOT NULL;
```

#### PostgreSQL and JSON
- Using JSONB type improves I/O performance and compressibility
- Lots of JSON functions for data processing

```sql
-- PostgreSQL
SELECT label FROM StoreItem
WHERE (colors->>'small')::jsonb @> '"purple"'::jsonb
```

#### PostgreSQL - JSON OPerators
- `->`, right operand `int`, JSON array element
  - Example: `'[{"a":"foo"},{"b":"bar"},{"c":"baz"}]'::json->2`
  - Result: `{"c": "baz"}`
- `->`, right operand `text`, JSON field by key
  - Example: `'{"a": {"b":"foo"}}'::json->'a'`
  - Result: `{"b": "foo"}`
- `->>`, right operand `int`, JSON array element as text
  - Example: `[1,2,3]::json->>2`
  - Result: `3`
- `->>`, right operand `text`, JSON field as text
  - Example: `'{"a":1,"b":2}'::json->>'b'`
  - Result: `2`
- `#>`, right operand `text[]`, JSON object at path
  - Example: `'{"a": {"b":{"c":"foo"}}}'::json#>'{a,b}'`
  - Result: `{"c":"foo"}`
- `#>>`, right operand `text[]`, JSON object at path as text
  - Example: `'{"a":[1,2,3],"b":[4,5,6]}'::json#>>'{a,2}'`
  - Result `3`

#### PostgreSQL - JSONB Operators
- `@>`, right operand `jsonb`, does the left JSON value contain within it the right value?
  - `'{"a":1,"b":2}'::jsonb @> '{"b":2}'::jsonb`
- `<@`, right operand `jsonb`, is the left JSON value contained within the right value?
  - `'{"b":2}'::jsonb <@ '{"a":1,"b":2}'::jsonb`
- `?`, right operand `text`, does the key/element string exist within the JSON value?
  - `'{"a":1,"b":"2"}'::jsonb ? 'b'`
- `?|`, right operand `text[]`, do any of these key/element strings exist?
  - `'{"a":1,"b":2,"c":3}'::jsonb ?| array['b', 'c']`
- `?&`, right operand `text[]`, do all of these key/element strings exist?
  - `'["a", "b"]'::jsonb ?& array['a', 'b']`
- `@>`, right operand `jsonb`, does the left JSON value contain within the right value?
 - `'{"a":1"b":2}'::jsonb @> '{"b":2}'::jsonb`

#### PostgreSQL - Arrays
- Multidimensional array type independent of JSON
- Works with existing types like `INTEGER`, `VARCHAR`, etc...
- Much simpler to work with than arbitrary JSON values

```sql
CREATE TABLE UserAccount (
  email VARCHAR(255) PRIMARY KEY,
  names TEXT[] NOT NULL,
  locations REAL[2][]
);

-- create values as strings
INSERT INTO UserAccount
VALUES('name@exampe.com', '{"John", "Doe"}', '{{39.983, 129.122}, {37.3433, 122.92733}')

-- or using the array type
INSERT INTO UserAccount
VALUES('name@example.com',
  ARRAY['John', 'Doe']
  ARRAY[[39.983, 129.122], [37.3433, 122.92733]]
);

-- square brackers to access elements by id in an array
SELECT (names[1] || ' ' || names[2]) AS fullname FROM UserAccount;

-- range
SELECT names[1:2] AS names FROM UserAccount;
SELCT names[:2] AS names FROM UserAccount;
```

#### PostgreSQL - Array Inclusion Check
- Use the `ANY` keyword to check whether a given value is present in an array
- Use the `&&` operator to check for an overlap between arrays

```sql
SELECT email FROM UserAccount WHERE 'Doe' = ANY(names);
SELECT ARRAY[4,5,6] && ARRAY[2,6,9,16]; -- true
```

### Full-Text Search
- Multiple words from the same root to be treated as a single concept
- Omit stop words
- Indexing instead of full-table scanning
- PostgreSQL support great
- MySQL support Ok
- SQLite support no
- May not need Lucene, Solr or Sphinx anymore
- Based around the idea of a reverse index
- Keep track of normalized keywords associated with each record
  - MySQL does this automatically in caching tables
  - PG recommended to create a new column

#### Precision vs. Recall
- Precision is the ratio of selected results that are relevant
- Recall is the ratio of the relevant results are selected

```sql
-- PostgreSQL
CREATE TABLE Whiskey (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  notes TEXT
);

ALTER TABLE Whiskey ADD COLUMN whiskey_fts tsvector;
UPDATE Whiskey SET whiskey_fts = to_tsvector('english', name || ' ' || notes);
```

#### Full-Text Search Indices
- In MySQL, create a `FULLTEXT `index on exactly the keys you will search against
- In PostgreSQL create a `GIN` index on a `tsvector`, concatenating where appropriate

```sql
-- MySQL
CREATE FULLTEXT INDEX whiskey_fts_idx ON Whiskey(name, notes);

-- PostgreSQL
CREATE INDEX whiskey_fts_idx ON Whiskey USING GIN (whiskey_fts);
```

#### Full-Text Search Selecting the Relevant Results
- In MySQL 5.7.6+ use the `MATCH...AGAINST()` syntax
  - `NATUARL LANGUAGE MODE` - is the default
  - `BOOLEAN MODE` -allows for operators: `+Android -Samsung`
  - Minimum search term length: 3 characters
- In PostgreSQL query against the special `whiskey_fts` column
  - Use the `to_tsquery()` function to convert a search term to a tsquery type
  - The `@@` operator checks for a match between a tsvector and tsquery
  - `&` (AND), `|` (OR) and `!` (NOT) operators may be used in search terms

```sql
-- MySQL
SELECT * FROM Whiskey
WHERE MATCH (name, notes) AGAINST ('sweet' IN BOOLEAN MODE);
```

```sql
-- PostgreSQL
SELECT * FROM Whiskey WHERE whiskey_fts @@ to_tsquery('dry');
```

### PubSub Messaging Pattern
- Publisher and Subscriber have no direct knowledge of each other
- Subscribe to, and publish a "topic"
- Different from Observable / Observer, in that neither side has knowledge of the other
- Results in improved scalability and loose coupling
- If you are not subscribed you miss the message
- PostgreSQL support is great, MySQL and SQLite do not support

```javascript
import * as pg from 'pg';

export async function setupPubSub(pool: pg.Pool): Promise<pg.Client> {
  const client = await pool.connect();

  client.on('notification', (message: pg.Notification) => {
    console.log('subscription fired', message.payload);
  });
  
  client.query('LISTEN table_update');

  return client;
}
```

#### Firing a Message
- Firing a message is done via the `NOTIFIY` command
- Or by using `pg_notify(<channel>, <message>)` function
- Payloads should be small, push a small signal and then pull something more substantial is response if necessary


```sql
NOTIFY 'message_channel', 'this is the message';
PERFORM pg_notify('message_channel', 'this is the message');
```

#### Control Flow in SQL
- MySQL has some limited support for control flow
- PostgreSQL has its own procedural language, very similar to Oracle's PL/SQL
- Use this in stored procedures and / or triggers

```sql
IF p.age >= 21 THEN SELECT * FROM Drinks WHERE hasAlcohol=false
ELSE SELECT * FROM Drinks
END IF
```


-----------


## Examples

```sql
SELECT * FROM Employee;
SELECT id, firstname, lastname FROM Employee;

/* Create the table */
CREATE DATABASE khan_academy;
CREATE TABLE groceries (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER );
/* Auto increments using SERIAL */
CREATE TABLE exercise_logs (id SERIAL PRIMARY KEY , type TEXT, minutes INTEGER, calories INTEGER, heart_rate INTEGER);

/* Inserts data */
INSERT INTO groceries VALUES (1, 'Bananas', 4);
INSERT INTO groceries VALUES (2, 'Peanut Butter', 1);
INSERT INTO groceries VALUES (3, 'Dark chocolate bars', 2);

/* Multiple rows in one insert */
INSERT INTO groceries VALUES (4, 'Butter', 1), (5, 'Apples', 8);

/* Specifying the columns */
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ('biking', 30, 100, 110);

/* Select */
SELECT * FROM groceries;
SELECT name FROM groceries ORDER BY quantity;
SELECT * FROM groceries WHERE quantity > 1 ORDER BY quantity;
SELECT * FROM exercise_logs WHERE calories > 50 ORDER BY calories;

/* Aggregate */
SELECT SUM(quantity) FROM groceries;
SELECT MAX(quantity) FROM groceries;
SELECT aisle, SUM(quantity) FROM groceries GROUP BY aisle;
SELECT aisle, SUM(quantity) FROM groceries GROUP BY aisle ORDER BY aisle;

/* AND */
SELECT * FROM exercise_logs WHERE calories > 50 AND minutes < 30;
SELECT title FROM songs WHERE mood = 'epic' AND released > 1990 AND duration < 240;

/* OR */
SELECT * FROM exercise_logs WHERE calories > 50 OR heart_rate > 100;
SELECT title FROM songs WHERE mood = 'epic' OR released > 1990;

/* IN */
SELECT * FROM exercise_logs WHERE type = 'biking' OR type = 'hiking' OR type = 'tree climbing' OR type = 'rowing';
SELECT * FROM exercise_logs WHERE type IN ('biking', 'hiking', 'tree climbing', 'rowing');

/* NOT IN */
SELECT * FROM exercise_logs WHERE type NOT IN ('biking', 'hiking', 'tree climbing', 'rowing');

/* IN subquery */
SELECT * FROM exercise_logs WHERE type IN (SELECT type FROM drs_favorites);

/* LIKE, inexact match && subquery */
SELECT * FROM exercise_logs WHERE type IN (SELECT type FROM drs_favorites WHERE reason LIKE '%cardiovascular%');

/* Group and Rename with AS */
SELECT type, SUM(calories) AS total_calories FROM exercise_logs GROUP BY type;

/* HAVING to apply the condition to a grouped value */
SELECT type, SUM(calories) AS total_calories FROM exercise_logs GROUP BY type HAVING SUM(calories) > 150;
SELECT type, AVG(calories) AS avg_calories FROM exercise_logs GROUP BY type HAVING AVG(calories) > 70; 
SELECT type FROM exercise_logs GROUP BY type HAVING COUNT(*) >= 2;

/* Calculations */
SELECT COUNT(*) FROM exercise_logs WHERE heart_rate > 220 - 30;

SELECT COUNT(*) FROM exercise_logs WHERE
    heart_rate >= ROUND(0.50 * (220-30)) 
    AND  heart_rate <= ROUND(0.90 * (220-30));

/* CASE to create a new clumns with conditional values */
SELECT type, heart_rate,
    CASE 
        WHEN heart_rate > 220-30 THEN 'above max'
        WHEN heart_rate > ROUND(0.90 * (220-30)) THEN 'above target'
        WHEN heart_rate > ROUND(0.50 * (220-30)) THEN 'within target'
        ELSE 'below target'
    END as hr_zone
FROM exercise_logs;

/* New column grouping */
SELECT COUNT(*),
    CASE 
        WHEN heart_rate > 220-30 THEN 'above max'
        WHEN heart_rate > ROUND(0.90 * (220-30)) THEN 'above target'
        WHEN heart_rate > ROUND(0.50 * (220-30)) THEN 'within target'
        ELSE 'below target'
    END as hr_zone
FROM exercise_logs
GROUP BY hr_zone;

SELECT COUNT(*), 
  CASE
    WHEN number_grade > 90 THEN 'A'
    WHEN number_grade > 80 THEN 'B'
    WHEN number_grade > 70 THEN 'C'
    ELSE 'F'
  END AS letter_grade
FROM student_grades GROUP BY letter_grade;

/* Cross join */
SELECT * FROM student_grades, students;

/* Inner join, implicit */
SELECT * FROM student_grades, students WHERE student_grades.student_id = students.id;

/* explicit inner join - JOIN */
SELECT * FROM students JOIN student_grades ON students.id = student_grades.student_id;

SELECT first_name, last_name, email, test, grade FROM students
    JOIN student_grades
    ON students.id = student_grades.student_id
    WHERE grade > 90;
```
