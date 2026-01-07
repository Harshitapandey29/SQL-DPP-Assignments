
-- Question 1
# What is the syntax of a window function?
-- Ans] The syntax of window function is:
          # WINDOW_FUNCTION(column) OVER (PARTITION BY column_name ORDER BY column_name)
          

-- Question 2
# What is the purpose of the FIRST_VALUE() and LAST_VALUE() functions?
-- Ans] 1) FIRST_VALUE() : Returns the value from the first row in the specified window frame.
	--  2) LAST_VALUE() : Returns the value from the last row in the specified window frame.
    
    
# Create a Table in SQL and then solve the following questions:

create database session27_AdvSQL;
use session27_AdvSQL;

create table table1(
employee_id int primary key,
ename char(50),
department char(50),
salary int,
hire_date datetime
);
insert into table1(employee_id, ename, department, salary, hire_date) values
(1, 'Alice', 'HR', 55000, '2020-01-15'),
(2, 'Bob', 'HR', 80000, '2019-05-16'),
(3, 'Charlie', 'HR', 70000, '2018-07-30'),
(4, 'Dev', 'Finance', 48000, '2021-01-10'),
(5, 'Imran', 'IT', 68000, '2017-12-25'),
(6, 'Jack', 'Finance', 60000, '2019-11-05'),
(7, 'Jason', 'IT', 45000, '2018-03-15'),
(8, 'Kiara', 'IT', 70000, '2022-06-18'),
(9, 'Michael', 'IT', 42000, '2019-05-20'),
(10, 'Nalini', 'Finance', 41000, '2021-08-24'),
(11, 'Nandani', 'Finance', 52000, '2017-03-25');

create table table2 (
department_id int primary key,
department_name char(50),
location char(50)
);
insert into table2 (department_id, department_name, location) values
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago');

select * from table1;
select * from table2;

-- Question 3
# Write an SQL query to assign a unique rank to each employee based on salary (highest first) using ROW_NUMBER().
select *,
row_number() over(order by salary desc) as rn
from table1;

-- Question 4
# Write a query to find each employee's department and their department-wise rank based on salary.
select *,
rank() over(partition by department order by salary desc) as r
from table1;

-- Question 5
# What will happen if we use DENSE_RANK() instead of RANK() ?
-- Ans] 1) DENSE_RANK() gives the same rank to same value and doesn't skip the ties.
     -- 2) RANK() gives the same rank to same value and skip the ties.
     
-- Qustion 6
# Write a query to calculate a running total of salaries across all employees (ordered by hire_date).
select *, 
sum(salary) over(order by hire_date desc) as running_total
from table1;

-- Question 7
# Write a query to show each employee’s salary and the difference from the highest salary in their department.
select employee_id, ename, department, salary,
(max(salary) over (partition by department) - salary) as difference_from_max
from table1;

-- Question 8
# Write a query to compute a 3-period moving average of salaries based on hire date.
select employee_id, salary,
avg(salary) over (order by hire_date rows between 2 preceding and current row) as moving_avg
from table1;

-- Question 9
# Write a query using cume_dist() to find the cumulative distribution of salaries.
select employee_id, salary,
cume_dist() over (order by salary) as cumulative_distribution
from table1;


-- Question 10
# Write a query to retrieve the last hired employee in each department using last_value .
with cte1 as (
select employee_id, ename, department, hire_date,
last_value(ename) over (partition by department order by hire_date rows between unbounded preceding and unbounded following)
as last_hired_employee,
last_value(hire_date) over (partition by department order by hire_date rows between unbounded preceding and unbounded following)
as last_hire_date
from table1)
select * from cte1;


-- Question 11
# What happens when you use instead of in a window function? Provide an example query.



-- Question 12
# Write an SQL query to list employees whose salary is above their department’s average salary. Use a subquery with a window function.
select * from (
select employee_id, ename, department, salary,
avg(salary) over (partition by department) as dept_avg
from table1) t
where salary > dept_avg;


-- Question 13
# Write a query to join the and tables and calculate each employee’s rank within their department based on salary. (Hint: Use Table 2 )
select t1.employee_id, t1.ename, t2.department_name, t1.salary,
rank() over (partition by t2.department_name order by t1.salary desc) as dept_rank
from table1 t1
join table2 t2
on t1.employee_id = t2.department_id;








