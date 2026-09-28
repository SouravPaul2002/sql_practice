-- employees(emp_id, name, department_id, salary, manager_id, hire_date)
-- departments(department_id, department_name)
-- orders(order_id, customer_id, order_date, amount)
-- customers(customer_id, name, city)

-- 1. Find all employees with a salary greater than 50,000.
-- 2. Count the number of employees in each department.
-- 3. Find the difference between WHERE and HAVING, and write one query that uses both.
-- 4. Get the names of employees who joined in the last 6 months.
-- 5. Find customers who have never placed an order.

USE sql_practice;

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(250)
);

-- hii

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(250),
    city VARCHAR(250)
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(8,2),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(250),
    department_id INT,
    salary DECIMAL(10,2),
    manager_id INT,
    hire_date DATE,
    FOREIGN KEY(department_id) REFERENCES departments(department_id)
);


-- INSERT INTO departments(department_name) VALUES ("CSE"),("IT"),("MATHS"),("CHEMISTRY"),("MBA");

-- INSERT INTO customers(name,city) VALUES 
-- ("sourav", "Naihati"),
-- ("sudip", "kolkata"),
-- ("rita", "kalyani"),
-- ("anjali", "belgharia"),
-- ("KB", "howrah"),
-- ("tuli", "shyamnagar");

-- INSERT INTO orders(customer_id, order_date, amount) VALUES (1, '2025-09-27', 25500.09),
-- (1, '2026-01-10', 15000.00),
-- (1, '2026-03-15', 8500.00),
-- (2, '2026-02-20', 12000.00),
-- (3, '2026-04-05', 25000.00),
-- (4, '2026-05-12', 7000.00),
-- (5, '2026-06-18', 18000.00),
-- (6, '2026-07-22', 9500.00),
-- (6, '2026-08-10', 30000.00);

-- INSERT INTO employees(name, department_id, salary, manager_id, hire_date) VALUES
-- ('Sourav Paul', 1, 75000.00, NULL, '2024-01-15'),
-- ('Rahul Sen', 1, 60000.00, 1, '2025-03-10'),
-- ('Priya Roy', 1, 45000.00, 1, '2026-06-15'),

-- ('Amit Das', 2, 55000.00, NULL, '2023-08-20'),
-- ('Sneha Gupta', 2, 42000.00, 4, '2026-04-10'),

-- ('Arjun Sharma', 3, 80000.00, NULL, '2022-11-05'),
-- ('Neha Singh', 3, 52000.00, 6, '2026-05-20'),

-- ('Rohan Bose', 4, 48000.00, NULL, '2025-07-15'),
-- ('Ananya Das', 4, 65000.00, 8, '2026-07-01'),

-- ('Vikram Roy', 5, 70000.00, NULL, '2024-09-12'),
-- ('Kavita Sen', 5, 45000.00, 10, '2026-08-05');

-- 1 
-- SELECT * from employees WHERE salary > 50000;

-- 2. Count the number of employees in each department.
-- SELECT d.department_name , COUNT(e.emp_id) FROM departments d JOIN employees e ON d.department_id = e.department_id GROUP BY e.department_id;

-- 3. Find the difference between WHERE and HAVING, and write one query that uses both.
SELECT d.department_name , COUNT(e.emp_id) AS Employees_Count FROM departments d JOIN employees e on d.department_id = e.department_id WHERE e.salary > 50000 GROUP BY d.department_id having count(e.emp_id)>=2;

-- 4. Get the names of employees who joined in the last 6 months.
select name from employees where hire_date >= date_sub(curdate(), interval 6 month);

-- 5. Find customers who have never placed an order.
select c.customer_id, c.name from customers c left join orders o on c.customer_id = o.customer_id where o.customer_id is NULL;