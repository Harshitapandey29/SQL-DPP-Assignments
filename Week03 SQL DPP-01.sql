create database retail_company;
use retail_company;

create table customers (
customer_id int primary key,
customer_name varchar(100),
city varchar (100)
);
insert into customers (customer_id, customer_name, city) values
(1, "Arjun Mehta", "Mumbai"),
(2, "Priya Sharma", "Delhi"),
(3, "Soham Mishra", "Bengaluru"),
(4, "Sneha Kapoor", "Pune"),
(5, "Karan Singh", "Jaipur");

create table orders (
order_id int primary key,
customer_id int,
order_date datetime,
amount int
);
insert into orders (order_id, customer_id, order_date, amount) values
(101, 1, "2024-09-01", 4500),
(102, 2, "2024-09-05", 5200),
(103, 1, "2024-09-07", 2100),
(104, 3, "2024-09-10", 8400),
(105, 7, "2024-09-12", 7600);

create table payments (
payment_id varchar(50),
customer_id int,
payment_date datetime,
amount int 
);
insert into payments (payment_id, customer_id, payment_date, amount) values
("P001", 1, "2024-09-02", 4500),
("P002", 2, "2024-09-06", 5200),
("P003", 3, "2024-09-11", 8400),
("P004", 4, "2024-09-15", 3000);

create table employee_s (
employee_id int primary key,
employee_name varchar(100),
manager_id int
);
insert into employee_s (employee_id, employee_name, manager_id) values
(1, "Amit Khanna", null),
(2, "Neha Joshi", 1),
(3, "Vivek Rao", 1),
(4, "Rahul Das", 2),
(5, "Isha Kulkarni", 2);

select * from customers;
select * from orders;
select * from payments;
select * from employee_s;


-- Question 1.
# Retrieve all customers who have placed at least one order.
select distinct c.customer_id, c.customer_name, c.city
from customers c
inner join Orders o
on c.customer_id = o.customer_id;

-- Question 2.
# Retrieve all customers and their orders, including customers who have not placed any orders.
select c.customer_name, o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id;

-- Question 3.
# Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
select c.customer_id, c.customer_name, o.Order_id
from customers c
right join Orders o
on c.customer_id = o.customer_id;

-- Question 4.
# Display all customers and orders, whether matched or not.
select * from customers c
left join orders o on c.customer_id = o.customer_id
union all
select * from customers c
right join orders o on c.customer_id = o.customer_id;

-- Question 5.
# Find customers who have not placed any orders.
select c.customer_id, c.customer_name, c.city
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- Question 6.
# Retrieve customers who made payments but did not place any orders.
select p.customer_id, c.customer_name, c.city
from payments p
left join orders o on p.customer_id = o.customer_id
left join customers c on p.customer_id = c.customer_id
where o.order_id is null;

-- Question 7.
# Generate a list of all possible combinations between Customers and Orders.
select * from customers
cross join orders;

-- Question 8.
# Show all customers along with order and payment amounts in one table.
select c.customer_id, c.customer_name, o.amount as OrderAmount, p.amount as PaymentAmount
from customers c
left join orders o on c.customer_id = o.customer_id
left join payments p on c.customer_id = p.customer_id;

-- Question 9.
# Retrieve all customers who have both placed orders and made payments.
select distinct c.customer_id, c.customer_name, c.city
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join payments p on c.customer_id = p.customer_id;

