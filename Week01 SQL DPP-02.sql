-- Section -01:

# creating database:
create database ecommerce_db;
use ecommerce_db;

# creating table:
create table orders (
order_id int primary key,
customer_id int,
product_name varchar(50),
order_date date
);

# listing values inside the table:
insert into orders (order_id, customer_id, product_name, order_date) values
(101, 200, 'Laptop', '2025-01-15'),
(102, 201, 'Phone', '2025-01-16'),
(103, 202, 'Laptop', '2025-01-17'),
(104, 200, 'Tablet', '2025-01-18'),
(105, 203, 'Phone', '2025-01-19'),
(106, 204, 'Laptop', '2025-01-20');

# displaying:
select * from orders;

-- question 1:
# Unique Products: Write a SQL query that will return a list of unique products ordered by customers (i.e., without duplicates)
select distinct product_name from orders;

-- question 2:
# Unique Customers: Write a SQL query to find out how many unique products were ordered by each customer. 
# The result should show the customer’s ID and the number of distinct products they’ve ordered
select customer_id, count(distinct product_name) as uni_product from orders
group by customer_id;

-- question 3:
# Distinct Product Count: Write a query to count the number of distinct products ordered on the platform.
# This should return a single number
select count(distinct product_name) as total_product
from orders;

-- question 4:
# Sorting by Most Recent Orders: Write a SQL query that returns the most recent distinct products ordered,
# sorted by the order date in descending order. Limit the result to the top 3 most recent products.
select distinct product_name, order_date
from orders
order by order_date desc
limit 3;


-- Section-02:

# inserting 2 more rows into the table:
insert into orders (order_id, customer_id, product_name, order_date) values
(107, 205, 'Phone', '2025-02-01'),
(108, 206, 'Tablet', '2025-02-02');

select * from orders;

-- question 1:
# Top Products in the Last Month: Write a SQL query to return the top 2 most ordered distinct products from
# the last month. Sort the results by order date in descending order and limit the output to the top 2
select distinct product_name, order_date
from orders
where order_date >= DATE_SUB(CURDATE(), interval 1 month)
order by order_date desc
limit 2;

-- question 2:
# Unique Products for Specific Customer: Write a SQL query to return the distinct products ordered by
#customer 200, sorted by the order date in descending order. Limit the result to 3 products
select distinct product_name, order_date
from orders
where customer_id = 200
order by order_date desc
limit 3;

-- question 3:
# Top N Products: Write a SQL query to retrieve the top 5 most ordered products based on the number of
# distinct orders, sorted by product name in ascending order. Limit the result to the top 5
select product_name, count(distinct order_id) as distinct_orders
from orders
group by product_name
order by product_name asc
limit 5;

-- question 4:
# Unique Orders for Each Product: Write a SQL query to count the distinct number of orders placed for each
# product. Sort the results by the number of distinct orders in descending order.
select product_name, count(distinct order_id) as unique_order
from orders
group by product_name
order by unique_order desc;


-- Section-03:

-- question 1:
# Optimizing Query with DISTINCT: Given a large dataset, write a SQL query to retrieve the distinct products
# ordered in the last month. Suggest an optimization strategy using indexes. What columns would you index to make this query faster?
select distinct product_name, order_date
from orders
where order_date >= date_sub(curdate(), interval 1 month);

-- suggesting an optimized strategy by indexing order_date and product_name
create index in_product_date on orders(order_date, product_name);

-- question 2:
# Performance Consideration: Why is using DISTINCT on large datasets computationally expensive? What impact does it have on query performance?

#ANS] Using DISTINCT on large datasets is computationally expensive due to the operations required to identify and eliminate duplicate rows.
#This has a significant impact on query performance.

use ecommerce_db;
-- QUESTION 3:
# Efficient Query Writing: Write a SQL query that retrieves only the top 3 distinct products ordered by customer 200.
# Use LIMIT and ORDER BY efficiently, and explain why the query is optimized for performance.
select distinct product_name
from orders
where customer_id = 200
order by product_name asc
limit 3;


-- Section-04:

-- question 1:
#Execution Plan Analysis: Write a SQL query that returns the most popular products ordered in the last 30 s.
#Use DISTINCT, LIMIT, and ORDER BY to fetch the top 10 products. Use the EXPLAIN keyword to analyze the execution plan and identify potential performance issues
explain
select product_name, count(order_id) as total_orders
from orders
where order_date >= date_sub(curdate(), interval 30 day)
group by product_name
order by total_orders desc
limit 10;

-- question 2:
# Optimizing Sorting and Filtering: If the database grows even further, which column(s) would you
# recommend indexing to improve the speed of queries involving ORDER BY, DISTINCT, and LIMIT]
create index idx_orders_optimized on orders (order_date, product_name, customer_id);
-- yes because this improves- Filtering (order_date), Sorting (product_name), distinct operations, and limit queries.

-- question 3: 
# Alternative Query Approaches: Write an optimized version of a query that retrieves the top 5 most ordered
# products in the last 30 s. Discuss why your query is more efficient than using DISTINCT without optimization.
select product_name, count(*) as total_orders
from orders
where order_date >= date_sub(curdate(), interval 30 day)
group by product_name
order by total_orders desc
limit 5;

-- section-05:

-- question 1:
# Complex Query Creation: Write a SQL query that retrieves the top 10 most recent distinct products ordered,
# sorted by the order date in descending order. Make sure to limit the result to 10 products
SELECT DISTINCT product_name, order_date
FROM orders
WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY order_date DESC
LIMIT 10;

-- question 2:
# Query Optimization: Discuss how you would optimize the query if the orders table had millions of rows.
# What indexing strategies would you apply to ensure efficient query execution]

-- ans] Optimization Strategies for Millions of Rows, creating the following indexes:
create index idx_date_product on orders (order_date, product_name);
explain
select product_name, order_date
from orders
where order_date >= date_sub(curdate(), interval 1 month)
order by order_date desc;

create index idx_product_customer on orders (product_name, customer_id);
explain
select *
from orders
where product_name = 'Laptop'and customer_id = 200;

-- question 3:
# Additional Enhancements: Imagine that the query needs to be enhanced to show the customer who made
# the most recent purchase for each product. How would you modify your query to include this information?
select o.product_name, o.customer_id, o.order_date
from orders o
join (select product_name, max(order_date) as last_order_date
from orders
group by product_name) t on o.product_name = t.product_name
and o.order_date = t.last_order_date
order by o.order_date desc
limit 10;







