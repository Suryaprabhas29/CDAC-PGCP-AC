CREATE DATABASE IF NOT EXISTS db_employees;
USE db_employees;

CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(60) NOT NULL UNIQUE,
    location        VARCHAR(60) NOT NULL
) ;

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NULL,
    job_title     VARCHAR(80) NOT NULL,
    salary        DECIMAL(10,2) NOT NULL,
    manager_id    INT NULL,
    joining_date  DATE NOT NULL,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments (department_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_employee_manager
        FOREIGN KEY (manager_id)
        REFERENCES employees (employee_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE shifts (
    shift_id   INT PRIMARY KEY,
    shift_name VARCHAR(30) NOT NULL UNIQUE,
    start_time TIME NOT NULL,
    end_time   TIME NOT NULL
);

CREATE TABLE salary_grades (
    grade_code VARCHAR(2) PRIMARY KEY,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_salary_grade_range
        CHECK (min_salary <= max_salary)
) ;

INSERT INTO departments
    (department_id, department_name, location)
VALUES
    (10, 'Engineering', 'Bangalore'),
    (20, 'Human Resources', 'Hyderabad'),
    (30, 'Sales', 'Mumbai'),
    (40, 'Finance', 'Pune'),
    (50, 'Research', 'Chennai');

INSERT INTO employees
    (employee_id, employee_name, department_id, job_title,
     salary, manager_id, joining_date)
VALUES
    (101, 'Asha',  10,   'Engineering Manager', 90000.00, NULL, '2018-04-16'),
    (102, 'Ravi',  10,   'Software Engineer',   72000.00, 101,  '2021-06-15'),
    (103, 'Neha',  20,   'HR Manager',          68000.00, 101,  '2019-08-05'),
    (104, 'Kiran', 30,   'Sales Executive',     85000.00, 103,  '2020-11-20'),
    (105, 'Imran', NULL, 'Independent Analyst', 55000.00, NULL, '2023-01-12');


INSERT INTO shifts
    (shift_id, shift_name, start_time, end_time)
VALUES
    (1, 'Morning', '08:00:00', '16:00:00'),
    (2, 'Evening', '14:00:00', '22:00:00');

INSERT INTO salary_grades
    (grade_code, min_salary, max_salary)
VALUES
    ('A',     0.00, 59999.99),
    ('B', 60000.00, 79999.99),
    ('C', 80000.00, 99999.99),
    ('D',100000.00,149999.99);
    
    
 -- 1 list all the employees whose salary is greater than average salary
 
 select employee_id, employee_name, salary
 from employees
 where salary > (select avg(salary) from employees); 
 
select * from employees;
 
 -- 2 list all the employees who belong to Sales department

 select *
 from employees
 where department_id=  (select department_id from departments where department_name="Sales"); 

-- 3 Employees who joined after the earliest Engineering joining date.
select * from 
employees
where joining_date > (select joining_date from employees order by joining_date limit 1);


-- 4 Departments having at least one employee.

select * from departments
where department_id in (select department_id from employees group by department_id having count(department_id) >= 1);

-- 5 Employees in departments located in Bangalore or Mumbai.

select *
from employees
where department_id in (select department_id from departments where location in('Bangalore', 'Mumbai'));

--  6 Employees earning more than their manager.

select * from employees e
where salary > (select salary from employees m where m.employee_id = e.manager_id);