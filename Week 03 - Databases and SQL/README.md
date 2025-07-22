# Week 3 - Databases and SQL

## Lab repos:
- [MySQL Database Creation](https://github.com/TebasMartinez/lab-sql-mysql-db-creation)
- [SQL Basic Queries](https://github.com/TebasMartinez/lab-sql-basic-queries)

- [Mini-project - SQL Database](https://github.com/TebasMartinez/mini-project-sql-database)

## Notes:

### Purpose of Databases
- Centralized storage.
- Data integrity.
- Efficient retrieval.
- Multiple user access.
- Data security.

### DBMS - Database Management System

### Relational Databases

Columns are generally called attributes.

In SQL, each row has to be unique. Primary keys make sure this requirement is met. This primary key is normally an auto-incremental int.

Every value has to be atomic, non-divisible. We can't have something like a list inside a value.

#### Normal Forms
1NF up to 6NF (normal form). \
- 1NF: all primery keys are unique and all values are atomic.

### SQL
SQL Sublanguages:
- **DDL** (Data Definition Language): CREATE and DELETE objects from the database.
- **DCL** (Data Control Language): GRANT or REVOKE.
- **TCL** (Transaction Control Language): COMMIT or ROLLBACK.
- **DML** (Data Manipulation Language): SELECT.

SQL is a language that follows a declarative [programming paradigm](https://www.geeksforgeeks.org/system-design/introduction-of-programming-paradigms/).