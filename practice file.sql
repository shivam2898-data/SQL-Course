use regex;
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Finance'),
(4, 'Marketing');


CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees (emp_id, emp_name, dept_id, salary, hire_date) VALUES
(101, 'Alice', 1, 75000.00, '2019-05-10'),
(102, 'Bob', 1, 60000.00, '2020-06-15'),
(103, 'Charlie', 2, 50000.00, '2021-03-22'),
(104, 'Diana', 3, 55000.00, '2018-11-30'),
(105, 'Eve', 1, 80000.00, '2022-01-05'),
(106, 'Frank', 4, 45000.00, '2023-02-10'),
(107, 'Grace', 2, 62000.00, '2020-07-19');
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

INSERT INTO projects (project_id, project_name, start_date, end_date) VALUES
(201, 'Project Apollo', '2021-01-01', '2021-12-31'),
(202, 'Project Beacon', '2022-03-01', '2022-12-31'),
(203, 'Project Cypher', '2023-01-15', '2023-12-15'),
(204, 'Project Delta', '2022-06-01', '2023-06-01');


CREATE TABLE employee_projects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_projects (emp_id, project_id, role) VALUES
(101, 201, 'Developer'),
(101, 202, 'Team Lead'),
(102, 201, 'Tester'),
(103, 204, 'HR'),
(104, 202, 'Analyst'),
(105, 203, 'Developer'),
(105, 204, 'Project Manager'),
(106, 203, 'Marketer'),
(107, 204, 'HR Assistant');

select * from departments;
select * from employees;
select * from projects;
select * from employee_projects;

-- Find employees whose salary is greater than the average salary of all employees.
select avg(salary) , emp_id from employees group by emp_id;
select * from employees where salary > (select avg(salary) from employees );

-- List the names of departments that have employees earning more than 70,000?
select * from employees where salary > 70000;
select d.dept_name from departments as d join employees as e on d.dept_id = e.dept_id where e.salary > 70000;
-- using subquery
SELECT dept_name FROM departments WHERE dept_id IN (SELECT DISTINCT dept_id FROM employees WHERE salary > 70000);


-- Show employees who work on more than one project.
select emp_id from employee_projects group by emp_id  having  count(project_id)>1;
select emp_name from employees where emp_id in (select emp_id from employee_projects group by emp_id  having  count(project_id)>1);

-- Find employees who joined before any other employee in their department. (Correlated Subquery)?

