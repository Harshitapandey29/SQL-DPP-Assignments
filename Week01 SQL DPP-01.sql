# 1 – Introduction to SQL and Basic Queries:
# Task 1: Setup a Database-
create database company_db;
use company_db;
# Task 2: Create a Table-
create table employees(
eid int primary key,
first_name varchar(100),
last_name varchar(100),
department varchar(100),
salary int 
);

# Task 3: Insert Data-
insert into employees (eid, first_name, last_name, department, salary) values
(101, "Mihir", "Negi", "Sales", 45000),
(102, "Naman", "Pandey", "HR", 55000),
(103, "Priya", "Singh", "IT", 60000),
(104, "Aman", "Gupta", "Finance", 23000),
(105, "Riya", "Patwal", "Marketing", 27000),
(106, "Seeta", "Kumari", "Sales", 52000 );

# Task 4: Basic SELECT Query-
select * from employees;


# 2 – Filtering Data Using WHERE Clause:
# Task 1: Basic Filtering- -- Write a query to retrieve all employees from the Sales department.
select * from employees where department = "Sales";

# Task 2: Comparison Operators- -- Write a query to find employees with a salary greater than 50000.
select * from employees where salary > 50000;

# Task 3: Logical Operators (AND, OR)- -- Retrieve all employees from the Sales department and whose salary is greater than 50000.
select * from employees where department = "Sales" and salary > 50000;

# Task 4: DISTINCT Keyword- -- Retrieve a list of unique departments from the employees table.
select distinct department from employees;


# 3 – Modifying Data (INSERT, UPDATE, DELETE):
# Task 1: Inserting Multiple Rows- -- Insert 3 more employees into the employees table using a single INSERT statement.
insert into employees( eid, first_name, last_name, department, salary) values
(107, "Emma", "David", "Marketing", 48000),
(108, "Prisha", "Sehgal", "IT", 62000),
(109, "sophia", "Wilson", "HR", 53000);

select * from employees;

# Task 2: Updating Data- -- Update the salary of the employee with eid = 102 (Naman Pandey) to 60000.
update employees set salary = 60000
where eid = 102;
select * from employees;

# Task 3: Deleting Data- --Delete the employee with eid = 1 (Mihir Negi).
delete from employees where eid = 101;
select * from employees;

# Task 4: Verify Changes- --Use SELECT * FROM employees; to verify the changes.
select * from employees;


# 4 – Using Constraints (NOT NULL, UNIQUE, DEFAULT, CHECK):
# Task 1: Create a Table with Constraints- -- Create a new table employees_v2 with NOT NULL, UNIQUE, and CHECK constraints.
create table employees_2 (
eid int primary key,
first_name varchar(100) not null,
last_name varchar(100) not null,
email varchar(100) unique,
department varchar(50) default 'General',
salary int check (salary > 0)
);

# Task 2: Insert Data with Constraints- -- Try inserting data into employees_v2, including a duplicate email to observe the UNIQUE constraint violation.
insert into employees_2 (eid, first_name, last_name, email, department, salary) values
(101, 'Aarav', 'Sharma', 'aarav@example.com', 'IT', 50000);
 
select * from employees_2;

