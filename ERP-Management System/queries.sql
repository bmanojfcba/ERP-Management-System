USE erp;

-- Display all employees.

select * from employees;

-- Show employee names and salaries only.

select emp_name, salary from employees;

-- List all departments.

select dept_name from departments;

-- Display all products with price greater than 10,000.

select product_name,price from products where price > 10000;

-- Show all customers from Chennai.

select * from customers where address = "Chennai, India";

-- List all orders with status = 'Delivered'.

select * from orders where status = 'Delivered';

-- Display total number of employees.

select count(emp_id) from employees;

-- Show unique order statuses.

select distinct status from orders;

-- List all suppliers.

select * from suppliers;

-- Display products sorted by price (high to low).

select * from products order by price desc;

-- Show employees who belong to IT department.

select * from employees as e inner join departments as d on
e.dept_id = d.dept_id where dept_name = 'IT';

-- Display orders placed after '2024-01-01'.

select * from orders where order_date > '2024-01-01';

-- Show all invoices.

select * from invoices;

-- Count total number of products.

select count(product_id) from products;

-- Display employee names and phone numbers.

select emp_name, phone from employees;

-- Display employee name with department name.

select e.emp_name, d.dept_name from employees as e inner join departments as d
on e.dept_id = d.dept_id;

-- Show product name with category name.

select p.product_name,  c.category_name from products as p inner join categories as c
on p.category_id = c.category_id;

-- List order id, customer name and order date.

select o.order_id, c.customer_name, o.order_date from orders as o inner join customers as c 
on o.customer_id = c.customer_id;

-- Display total salary paid to all employees.

select sum(salary) as Total_Salary from employees;

-- Show department-wise employee count.

select count(*) from employees as e inner join departments as d
on e.dept_id = d.dept_id group by d.dept_id;

-- Find average salary of employees

select avg(salary) as Average_salary from employees;

-- Display total sales amount from the payments table.

select sum(amount) as Total_sales from payments;

-- Show number of orders placed by each customer.

select c.customer_name, count(o.order_id) from customers as c inner join orders as o
on c.customer_id = o.customer_id group by c.customer_name;

-- Display products which are out of stock (stock < 50).

select * from products where stock < 50;

-- Show employees whose salary is greater than average salary.

select * from employees where salary > (select avg(salary) from employees);

-- Display order id and total order amount.

select order_id, sum(price*quantity) from order_details group by order_id;

-- Show supplier name and number of products supplied.

select s.supplier_name, count(p.product_id) from products as p inner join suppliers as s
on p.supplier_id = s.supplier_id group by s.supplier_name;

-- Display customers who placed more than 1 order.

select * from customers;
select * from orders;

select c.customer_name from customers as c inner join orders as o
on c.customer_id = o.customer_id group by customer_name having count(o.order_id) > 1;

-- Show highest product price.

select product_name,price from products order by price desc limit 1;

-- Display employee name and role name.

select * from employees;
select * from employee_roles;
select * from roles;

select e.emp_name, ro.role_name from employees as e inner join employee_roles as er
on e.emp_id = er.emp_id inner join roles as ro on er.role_id = ro.role_id;

-- Display department name with highest total salary.

select * from departments;
select * from employees;

select d.dept_name, sum(e.salary) as total_sal from departments as d inner join employees as e
on d.dept_id = e.dept_id group by d.dept_name order by total_sal desc limit 1; 

-- Show customer who spent the maximum amount.

select c.customer_name, sum(p.amount) from customers as c inner join orders as o
on c.customer_id = o.customer_id inner join payments as p group by c.customer_name order by sum(p.amount) desc limit 1; 

-- Find top 3 most sold products based on quantity.

select p.product_name, sum(o.quantity) from products as p inner join order_details as o 
on p.product_id = o.product_id group by product_name order by sum(o.quantity) desc limit 3;

-- Display monthly total sales.

select month(payment_date) as m , sum(amount) from payments group by m ;

-- Show employees who have never taken attendance.

select e.emp_id, e.emp_name from employees as e inner join attendance as a
on e.emp_id = a.emp_id where a.check_in is not null;

-- display products that were never ordered

select p.product_id, p.product_name
from products as p
left join order_details as od
on p.product_id = od.product_id
where od.product_id is null;

-- show orders which have no payment entry

select o.order_id
from orders as o
left join payments as p
on o.order_id = p.order_id
where p.order_id is null;

-- display employees who work more than 8 hours

select e.emp_id, e.emp_name, a.work_hours
from employees as e
inner join attendance as a
on e.emp_id = a.emp_id
where a.work_hours > 8;

-- show department-wise average salary greater than 50000

select d.dept_name, avg(e.salary) as avg_salary
from departments as d
inner join employees as e
on d.dept_id = e.dept_id
group by d.dept_name
having avg(e.salary) > 50000;

-- display customers who never placed an order

select c.customer_id, c.customer_name
from customers as c
left join orders as o
on c.customer_id = o.customer_id
where o.customer_id is null;

-- show supplier whose products have highest total stock

select s.supplier_name, sum(p.stock) as total_stock
from suppliers as s
inner join products as p
on s.supplier_id = p.supplier_id
group by s.supplier_name
order by total_stock desc
limit 1;

-- display order id where payment amount does not match invoice amount

select p.order_id, p.amount, i.total_amount
from payments as p
inner join invoices as i
on p.order_id = i.order_id
where p.amount <> i.total_amount;

-- show employees who have more than one role

select e.emp_id, e.emp_name, count(er.role_id) as total_roles
from employees as e
inner join employee_roles as er
on e.emp_id = er.emp_id
group by e.emp_id, e.emp_name
having count(er.role_id) > 1;

-- display most frequently returned product

select p.product_name, count(r.return_id) as total_returns
from returns as r
inner join orders as o
on r.order_id = o.order_id
inner join order_details as od
on o.order_id = od.order_id
inner join products as p
on od.product_id = p.product_id
group by p.product_name
order by total_returns desc
limit 1;

-- show orders that were returned within 7 days

select r.order_id, o.order_date, r.return_date
from returns as r
inner join orders as o
on r.order_id = o.order_id
where datediff(r.return_date, o.order_date) <= 7;

-- display running total of sales using window function

select payment_date, amount,
sum(amount) over(order by payment_date) as running_total
from payments;

-- rank employees based on salary within each department

select emp_name, dept_id, salary,
rank() over(partition by dept_id order by salary desc) as salary_rank
from employees;

-- display second highest salary in each department

select emp_name, dept_id, salary
from (
    select emp_name, dept_id, salary,
    dense_rank() over(partition by dept_id order by salary desc) as rnk
    from employees
) as x
where rnk = 2;

-- use a subquery to find employees earning more than department average

select e.emp_id, e.emp_name, e.salary, e.dept_id
from employees as e
where e.salary > (
    select avg(e2.salary)
    from employees as e2
    where e2.dept_id = e.dept_id
);

-- create a view to show monthly sales report

create view monthly_sales_report as
select month(payment_date) as month_no,
sum(amount) as total_sales
from payments
group by month(payment_date);

