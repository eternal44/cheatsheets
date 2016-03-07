#######################
# PICKING A DB SCHEMA #
#######################

Can start with a very simple ghettoDB or firebase, development an idea
for a schema, and migrate to another DB

############
# POSTGRES #
############
$ createdb <database name>
$ psql

> \c <database name>

show tables
> \dt

list databases
> \l

drop database
> drop database truu;

import schema from sql file
$ sudo -u postgres psql < create_db.sql // might not need 'sudo -u postgres'


##########
# SQLITE #
##########
sqlite3 [sqlite file]

> .database
> .tables

#########
# MYSQL #
#########

CREATE DATABASE [james]

# SETUP #
stop all MYSQL servers

```sql
sudo service mysql stop
```

start MYSQL server
```sql
sudo service mysql start
```

Log in
```sql
mysql -u root [-p]
```

# NAVIGATE #
```sql
show databases
use <database-name>
show tables
desc <table-name>
```

# SELECT #

```sql
 SELECT [ALL | DISTINCT] column1[,column2] FROM table1[,table2] [WHERE
"conditions"] [GROUP BY "column-list"] [HAVING "conditions] [ORDER BY
"column-list" [ASC | DESC] ]


select "column1"
  [,"column2",etc]
  from "tablename"
  [where "condition"];
  [] = optional

```

* SELECT options
```sql
MIN - returns the smallest value in a given column
MAX - returns the largest value idean a given column
SUM - returns the sum of the numeric values in a given columnolumn
AVG - returns the average value of a given column
COUNT - returns The total number of values in a given column
COUNT(*) - returns the number off rows in a table

> EXAMPLES
SELECT AVG(salary)

FROM employee

WHERE title = 'Programmer';

```

# HAVING #
```sql
SELECT column1, 
SUM(column2)

FROM "list-of-tables"

GROUP BY "column-list"

HAVING "condition";


>example - gets avg salray of employees that get paid $20k+

SELECT dept, avg(salary)

FROM employee

GROUP BY dept

HAVING avg(salary) > 20000;
```

# ORDER BY #
```sql
>example
SELECT employee_id, dept, name, age, salary


FROM employee_info

WHERE dept = 'Sales'

ORDER BY salary, age DESC;
```

# CONDITION & BOOLEAN #
```sql
SELECT employeeid, firstname, lastname, title, salary

FROM employee_info

WHERE (salary >= 45000.00) AND (title = 'Programmer')
```


# BETWEEN / NOT BETWEEN #
```sql
SELECT col1, SUM(col2)

FROM "list-of-tables"

WHERE col3 IN 
       (list-of-values);

SELECT col1, SUM(col2)


FROM "list-of-tables"

WHERE col3 BETWEEN value1 
AND value2;


>example

SELECT employeeid, lastname, salary

FROM employee_info


WHERE lastname IN ('Hernandez', 'Jones', 'Roberts', 'Ruiz');
```


# MATH #
```sql
+addition
-subtraction
*multiplication
/division
%modulo


ABS(x) - returns the absolute value of x
SIGN(x) - returns the sign of input x as -1, 0, or 1 (negative, zero, or positive respectively)
MOD(x,y)modulo - returns the integer remainder of x divided by y (same
as x%y)
FLOOR(x) - asreturns the largest integer value that is less than or equal to x
CEILING(x) or CEIL(x) - returns the smallest integer value that is greater than or equal to x
POWER(x,y) - returns the value of x raised to the power of y
ROUND(ROUNDx) - returns the value of x rounded to the nearest whole integer
ROUND(x,ROUNDd) - returns the value of x rounded to the number of decimal places specificfied by the value d
SQRT(x) - returns the square-root value of x

```



# GROUP BY #
```sql
SELECT column1,
SUM(column2)

FROM "list-of-tables"

GROUP BY "column-list";

> EXAMPLE - selects the highest paid employee from each department
SELECT max(salary), dept
 
FROM employee 
 
GROUP BY dept;
```

# DISTINCT | ALL #
Selects all unique (distinct) ages in employee__info column
```sql
SELECT DISTINCT age

FROM employee_info;
```

# Conditional selections used in the where clause #
=Equal
>EqualGreater than
<http://LessGreater than or equal
<=Less than or EqualGreaterl
<>Not equal to
LIKE

# LIKE #
The LIKE pattern matching operator can also be used in the conditional
selection of the where clause. Like is a very powerful operator that
allows you to select only rows that are "like" what you specify. The
percent sign "%" can be used as a wild card to match any possible
character that might appear before or after the characters specified.
For example:

```sql
select first, last, city
   from empinfo
   where first LIKE 'Er%';
```

This SQL statement will match any first names that start with 'Er'.
Strings must be in single quotes.

Or you can specify,

```sql
select first, last
   from empinfo
   where last LIKE '%s';
```
This statement will match any last names that end in a 's'.

```sql
select * from empinfo
   where first = 'Eric';
```
This will only select rows where the first name equals 'Eric' exactly.


##############
# INNER JOIN #
##############
has one and belongs to many (ex: user & blog posts)

```sql
SELECT "list-of-columns"

FROM table1,table2 > omitting 'INNER JOIN' in place of the comma.  Some flavors will complain about syntax

WHERE "search-condition(s)"


> EXAMPLE

SELECT customer_info.firstname, customer_info.lastname, purchases.item

FROM customer_info, purchases

WHERE customer_info.customer_number = purchases.customer_number;
```

###################
# LEFT OUTER JOIN #
###################

```sql
select messages.id, messages.text, messages.roomname from messages \
left outer join users on (messages.userid = users.id) \
order by messages.id desc
```


######################
# LOOKUP WITH PARAMS #
######################

```sql
isert into messages(text, userid, roomname) \
values (?, (select id from users where username = ? limit 1), ?)";
```


######################
# NON SELECT PORTION #
######################

# CREATE #
```sql
create table employee
(first varchar(15),
 last varchar(20),
 age number(3),
 address varchar(30),
 city varchar(20),
 state varchar(20));
```

# INSERT #
```sql
insert into "tablename"
 (first_column,...last_column)
  values (first_value,...last_value);
```

# UPDATE #
```sql
update "tablename"
set "columnname" =
    "newvalue"
 [,"nextcolumn" =
   "newvalue2"...]
where "columnname"
  OPERATOR "value"
 [and|or "column"
  OPERATOR "value"];

 [] = optional
```

# DELETE #
```sql
delete from "tablename"

where "columnname"
  OPERATOR "value"
[and|or "column"
  OPERATOR "value"];

[ ] = optional
```

Note: if you leave off the where clause, all records will be deleted!

```sql
delete from employee;

delete from employee
  where lastname = 'May';

delete from employee
  where firstname = 'Mike' or firstname = 'Eric';
```

# DROP TABLE #
```sql
drop table "tablename"
```

# Examples:

```sql
update phone_book
  set area_code = 623
  where prefix = 979;

update phone_book
  set last_name = 'Smith', prefix=555, suffix=9292
  where last_name = 'Jones';

update employee
  set age = age+1
  where first_name='Mary' and last_name='Williams';
```

# MYSQL NAV #
Start SQL and set user name to 'root'
mysql -u root < server/schema.sql


#########
# TERMS #
#########

CAP - for distributed datastores.  Can only choose 2 of the 3
* consistency: if perfectly consistent - data is current any time I query
* availability: availability of data for query
* partition tolerance: able to split data into a great number of places
    ex: one piece of data on multiple servers

ACID - for DB management systems
* atomicity: it can't be split.  If it has high atomicity the queries
  that happen can't be completed unless it completey finishes that
  query.  If the db goes down or the query is incomplete: it cancels the
  query
* isolation: you want your read & writes to happen in isolation
* durability: how well data doesn't get lost on the db

CRUD - create, read, update, delete


scaled vertically - upgrade computer hardware to make processing time faster
  SQL scales better this way
scaled horizontally - throw more computers into DB
  NoSQL scale better this way

#######
# SQL #
#######
Not partition tolerant


#########
# NoSQL #
#########

# graph databases
good for:
  * highly relational data
  * data with complex relationships
  * edges hold meta data about relationship

bad for:
  * non-relational data
  * tree & list-like data

# document stores
ex: mongoDB
* object with key / value pair
* can have values or references to other objects / documents

good for:
  * lookups by one index
  * tree or list-like data
bad for:
  * finding relationships - looking up multiple indices
  * high write/read ratio

# key-value stores
* like document stores but can only have primitive values.
ex: redis - instagram

good for:
  * simple data
  * massively scaleable

bad for:
  * complex / highly relational data
  * low number of complex queries
