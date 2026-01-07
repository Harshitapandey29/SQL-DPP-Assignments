create database company_2db;
use company_2db;

create table employee_2 (
emp_id int primary key,
e_name varchar (100),
department_id int,
salary int
);
insert into employee_2 (emp_id, e_name, department_id, salary) values
(101, "Abhishek", 1, 60000),
(102, "Shubham", 2, 50000),
(103, "Adyut", 1, 70000),
(104, "Shashank", 3, 55000),
(105, "Naresh", 2, 72000),
(106, "sakshi", 3, 48000),
(107, "Kusum", 1, 41000),
(108, "Sejal", 2, 56000),
(109, "Bhomika", 1, 69000),
(110, "Vikash", 1, 71000),
(111, "Vikram", 3, 59000),
(112, "Anku", 2, 54000),
(113, "Jimmy", 1, 64000),
(114, "Hritik", 3, 52000),
(115, "Swapnil", 2, 54000);

create table department (
department_id int primary key,
department_name varchar(50)
);
insert into department (department_id, department_name) values
(1, "IT"),
(2, "HR"),
(3, "Sales");

create table sale (
sale_id int primary key,
emp_id int,
sale_amount int,
sale_date datetime
);
insert into sale (sale_id, emp_id, sale_amount, sale_date) values
(4, 104, 4500, "2024-01-09"),
(5, 105, 8000, "2024-01-11"),
(6, 106, 2500, "2024-01-12"),
(7, 107, 3000, "2024-01-15"),
(8, 108, 4200, "2024-01-16"),
(9, 109, 6500, "2024-01-18"),
(10, 110, 3100, "2024-01-19"),
(11, 111, 4400, "2024-01-22"),
(12, 112, 6000, "2024-01-23"),
(13, 113, 6700, "2024-01-25"),
(14, 114, 5100, "2024-01-29"),
(15, 115, 4900, "2024-01-31");

-- BASIC LEVEL:
-- 1- Retrieve the names of employees who earn more than the average salary of all employees,
select e_name from employee_2 
where salary > (select avg(salary) from employee_2);

-- 2- Find the employees who belong to the department with the highest average salary,
select e_name from employee_2 
where department_id = (select department_id from employee_2
group by department_id 
order by avg(salary) desc
limit 1);

-- 3- List all employees who have made at least one sale,
select distinct e_name from employee_2
where emp_id in (select emp_id from sale);

-- 4- Find the employee with the highest sale amount.
select e_name from employee_2 where emp_id = (select emp_id 
from sale
order by sale_amount desc
limit 1);

-- 5- Retrieve the names of employees whose salaries are higher than Shubham's salary.
select e_name from employee_2
where salary > (select salary from employee_2
where e_name = 'Shubham');


-- INTERMEDIATE LEVEL
-- 1- Find employees who work in the same department as Abhishek.
select e_name from employee_2 
where department_id = ( select department_id from employee_2
where e_name = 'Abhishek');

-- 2- List departments that have at least one employee earning more than $60,000.
select distinct department_name from department
where department_id in ( select department_id from employee_2
where salary > 60000);

-- 3- Find the department name of the employee who made the highest sale.
select department_name from department 
where department_id = (select department_id from employee_2
where emp_id = (select emp_id from sale 
order by sale_amount desc
limit 1));

-- 4- Retrieve employees who have made sales greater than the average sale amount.
select distinct e.e_name from employee_2 as e
join sale s on e.emp_id = s.emp_id
where s.sale_amount >(select avg(sale_amount) from sale);

-- 5- Find the total sales made by employees who earn more than the average salary.
select sum(sale_amount) as total_sale from sale
where emp_id in (select emp_id from employee_2
where salary > (select avg(salary) from employee_2));


-- ADVANCED LEVEL:
-- 1- Find employees who have not made any sales.
select e_name from employee_2 
where emp_id not in (select emp_id from sale);

-- 2- List employees who work in departments where the average salary is above $55,000.
select e_name from employee_2 
where department_id in ( select department_id from employee_2
group by department_id having avg(salary) > 55000);

-- 3- Retrieve department names where the total sales exceed $10,000.
select department_name from department
where department_id in ( select e.department_id from employee_2 as e
join sale s on e.emp_id = s.emp_id
group by e.department_id
having sum(s.sale_amount)>10000);

-- 4- Find the employee who has made the second-highest sale.
select e_name from employee_2
where emp_id = (select emp_id from sale
order by sale_amount desc
limit 1 offset 1);

-- 5- Retrieve the names of employees who have a salary greater than the highest sales amount recorded.
select e_name from employee_2
where salary >(select max(sale_amount) from sale);













