create table customers(
    customer_id integer primary key,
    customer_name text, city text,
    state text, join_date date
);

create table products (
    product_id integer primary key,
    product_name text,
    category text,
    unit_price decimal (10,2)
);

create table orders (
    order_id integer primary key,
    customer_id integer,
    order_date date,
    product_id integer,
    quantity integer,
    status text,
    foreign key (customer_id) references customers (customer_id)
    foreign key (product_id) references products (product_id)
);

create table employees(
    employee_id integer primary key,
    employee_name text,
    department text,
    job_title text,
    salary decimal (10,2)
);

INSERT INTO customers VALUES
(101, 'Arun Kumar', 'Chennai', 'Tamil Nadu', '2024-01-05 '),
(102, 'Priya Sharma', 'Bengaluru', 'Karnataka', '2024-01-12'),
(103, 'Rahul Singh', 'Madurai', 'Tamil Nadu', '2024-02-01'),
(104, 'Meena Nair', 'Kochi', 'Kerala', '2024-02-18'),
(105, 'Vijay Raj', 'Chennai', 'Tamil Nadu', '2024-03-03'),
(106, 'Anita Das', 'Kolkata', 'West Bengal', '2024-03-15'),
(107, 'Karthik Rao', 'Hyderabad', 'Telangana', '2024-04-10'),
(108, 'Sneha Patel', 'Mumbai', 'Maharashtra', '2024-04-22'),
(109, 'Suresh Kumar', 'Coimbatore', 'Tamil Nadu', '2024-05-08'),
(110, 'Divya Menon', 'Pune', 'Maharashtra', '2024-05-20');

INSERT INTO products VALUES
(201, 'Laptop', 'Electronics', 75000),
(202, 'Smartphone', 'Electronics', 45000),
(203, 'Monitor', 'Electronics', 32000),
(204, 'Office Chair', 'Furniture', 5200),
(205, 'Office Desk', 'Furniture', 12000),
(206, 'Keyboard', 'Accessories', 2500),
(207, 'Mouse', 'Accessories', 1500),
(208, 'Tablet', 'Electronics', 28000),
(209, 'Headphones', 'Accessories', 6500),
(210, 'Printer', 'Electronics', 18000);

INSERT INTO orders VALUES
(1001, 101, '2024-06-01', 201, 1, 'Completed'),
(1002, 102, '2024-06-03', 204, 2, 'Completed'),
(1003, 103, '2024-06-05', 202, 1, 'Completed'),
(1004, 104, '2024-06-08', 205, 1, 'Pending'),
(1005, 105, '2024-06-10', 203, 2, 'Completed'),
(1006, 106, '2024-06-12', 208, 1, 'Completed'),
(1007, 107, '2024-06-15', 206, 3, 'Completed'),
(1008, 108, '2024-06-18', 209, 2, 'Cancelled'),
(1009, 109, '2024-06-20', 210, 1, 'Completed'),
(1010, 110, '2024-06-22', 201, 1, 'Completed'),
(1011, 101, '2024-06-25', 207, 2, 'Completed'),
(1012, 103, '2024-06-27', 202, 1, 'Pending'),
(1013, 105, '2024-06-28', 205, 2, 'Completed'),
(1014, 107, '2024-06-29', 209, 1, 'Completed'),
(1015, 109, '2024-06-30', 208, 2, 'Completed');

INSERT INTO employees VALUES
(301, 'Ravi Kumar', 'Finance', 'Financial Analyst', 65000),
(302, 'Anjali Sharma', 'Marketing', 'Marketing Manager', 85000),
(303, 'Sanjay Rao', 'IT', 'Data Analyst', 72000),
(304, 'Priya Nair', 'HR', 'HR Manager', 78000),
(305, 'Vikram Singh', 'Sales', 'Sales Executive', 55000),
(306, 'Deepa Menon', 'Finance', 'Senior Analyst', 92000),
(307, 'Arjun Patel', 'IT', 'Software Engineer', 95000),
(308, 'Neha Das', 'Marketing', 'Marketing Analyst', 62000);

select * from customers;

select product_name, unit_price
from products
order by unit_price desc
limit 3;

select 
count (*) as total_orders,
sum(quantity) as total_quantity,
avg(quantity) as total_quantity
from orders;

select c.customer_name,
o.order_id,
o.order_date,
o.status
from customers c
join orders o on c.customer_id = o.customer_id;

select p.product_name,
sum(o.quantity * p.unit_price) as revenue
from orders o
join products p
on o.product_id = p.product_id
where o.status = 'Completed'
group by p.product_name
order by revenue desc;

select employee_name, department, salary
from employees
order by salary desc;

select customer_name, city, state, join_date 
from customers
order by join_date desc;

select status, count (*) as number_of_orders
from orders
group by status;

select department, count(*) as no_of_employees,
avg(salary) as average_salary
from employees
group by department;

select state, count(*) as no_of_customers
from customers
group by state;

select product_id, sum(quantity) as total_units_sold
from orders
where status = 'Completed'
group by product_id;

select p.product_name, sum(o.quantity) as total_units_sold
from orders o
join products p
on o.product_id = p.product_id
where o.status = 'Completed'
group by p.product_name
having sum(o.quantity) > 2;

select department, avg (salary) as average_salary
from employees
group by department
having avg(salary) > 75000;

select customer_id, count(*) as no_of_orders
from orders
group by customer_id
having count (*) > 1;

select category, count(*) as no_of_products, avg(unit_price) as average_price
from products
group by category
having avg (unit_price) > 20000;

select c.customer_name, sum(o.quantity * p.unit_price) as total_spending
from orders o
join customers c on o.customer_id = c.customer_id
join products p on o.product_id = p.product_id
where o.status = 'Completed'
group by c.customer_name
having sum(o.quantity * p.unit_price) > 50000;

select c.customer_name, o.order_id, o.order_date, o.status
from customers c
inner join orders o
on c.customer_id = o.customer_id; 
select c.customer_id, c.customer_name, o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

select c.customer_id, o.order_id, p.product_name, p.category, o.quantity, p.unit_price, o.quantity * p.unit_price as sales_amount
from orders o
inner join customers c
on o.customer_id = c.customer_id
inner join products p
on o.product_id = p.product_id;

select o.order_id, c.customer_name, p.product_name, o.quantity * p.unit_price as sales_amount,
case
when o.quantity * p.unit_price >= 50000 then 'High value'
when o.quantity * p.unit_price >= 20000 then 'Medium value'
else 'low value'
end as order_category
from orders o
inner join customers c
on o.customer_id = c.customer_id
inner join products p
on o.product_id = p.product_id;

select avg(unit_price) from products;

select product_name, category, unit_price
from products
where unit_price > (
select avg(unit_price)
from products
);

select c.customer_name, sum(o.quantity * p.unit_price) as total_spending
from customers c
inner join orders o
on c.customer_id = o.customer_id
inner join products p
on o.product_id = p.product_id
where o.status = 'Completed'
group by c.customer_id, c.customer_name
having sum(o.quantity * p.unit_price) > 50000;
