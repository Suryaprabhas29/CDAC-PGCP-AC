-- Create and select the database

CREATE DATABASE IF NOT EXISTS db_employees;
USE db_employees;

-- Remove old tables

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salary_grades;
DROP TABLE IF EXISTS shifts;
DROP TABLE IF EXISTS departments;

-- Create tables

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

-- Insert sample data

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


-- Ranges do not overlap, so each employee matches one grade.

INSERT INTO salary_grades
    (grade_code, min_salary, max_salary)
VALUES
    ('A',     0.00, 59999.99),
    ('B', 60000.00, 79999.99),
    ('C', 80000.00, 99999.99),
    ('D',100000.00,149999.99);

-- Validate the setup

SELECT * FROM departments ORDER BY department_id;
SELECT * FROM employees ORDER BY employee_id;
SELECT * FROM shifts ORDER BY shift_id;
SELECT * FROM salary_grades ORDER BY min_salary;


-- SECTION A - INNER AND EQUI JOINS

#1. Display the employee ID, employee name, department name and department location for employees who have a matching department.

SELECT e.employee_id,e.employee_name,d.department_name,d.location
FROM employees e 
JOIN departments d
    ON e.department_id=d.department_id;

#2. Display the employee name, job title and department name for employees working in the Engineering department.

SELECT employee_name,job_title,d.department_name
FROM employees e
JOIN departments d 
ON e.department_id=d.department_id
WHERE d.department_name='Engineering';

#3. Display the employee name, salary and department name for matched employees whose salary is greater than 70000.

SELECT employee_name,salary,department_name
FROM employees e 
JOIN departments d 
ON e.department_id=d.department_id
WHERE salary>70000;

#4. Write an equi join between employees and departments using department_id. Display employee_name, department_id and department_name.

SELECT employee_name,d.department_id,department_name
FROM employees e 
JOIN departments d 
ON e.department_id=d.department_id;


-- SECTION B - LEFT AND RIGHT OUTER JOINS

#5. Display every employee along with the corresponding department name. An employee without a department must also appear.

SELECT e.employee_name,d.department_name
FROM employees e 
LEFT JOIN departments d 
ON e.department_id=d.department_id;

#6. Find employees who do not have a matching department. Display employee_id and employee_name.

SELECT employee_id,employee_name
FROM employees e
LEFT JOIN departments d
ON e.department_id=d.department_id
WHERE d.department_id IS NULL;

#7. Use RIGHT JOIN to display every department and any employees assigned to it. Include departments that do not have employees.

SELECT department_name,employee_name
from employees e 
RIGHT JOIN departments d
ON e.department_id=d.department_id;

#8. Use LEFT JOIN to display every department and any employees assigned to it. Include departments that do not have employees.

SELECT department_name,employee_name
from departments d 
LEFT JOIN employees e 
ON e.department_id=d.department_id;

#9. Find departments that do not have any employees. Display department_id, department_name and location.

SELECT d.department_id,department_name,location
FROM departments d
LEFT JOIN employees e 
ON e.department_id=d.department_id
WHERE e.department_id IS NULL;


-- SECTION C - FULL OUTER AND CROSS JOINS

#10. Produce a full outer join result between employees and departments in MySQL. The result must include matched rows, employees without departments,and departments without employees. Use LEFT JOIN, RIGHT JOIN and UNION ALL.

select employee_id, employee_name, d.department_id, department_name
from employees e 
left join departments d
on e.department_id = d.department_id
union
select employee_id, employee_name, d.department_id, department_name
from employees e 
right join departments d
on e.department_id = d.department_id;


-- 11.  Generate every possible employee and shift combination. Display
-- employee_name, shift_name, start_time and end_time.
    
    SELECT employee_name,shift_name,start_time,end_time 
    from employees as e
    CROSS JOIN shifts as s;
    
    
--    12. Generate employee-shift combinations only for employee IDs 101, 102 and 103.
--     Sort the result by employee_id and shift_id.

	SELECT employee_id, shift_id 
    from employees as e
    CROSS JOIN shifts as s
    WHERE employee_id IN (101,102,103);
    
    
--    13. Calculate the expected number of rows produced when all employees are
  --  CROSS JOINed with all shifts. Display employee_count, shift_count and
 --   expected_combinations.
 
    
    select count(DISTINCT employee_id) employee_count, count(DISTINCT shift_name) shift_count, count(*) expected_combinations
    from employees 
    cross join shifts;    
    
-- 14. Use a self join to display employees who have a manager. Show the employee name and manager name.

select e.employee_name, m.employee_name manager_name
from employees e
join employees m 
on e.manager_id = m.employee_id;

-- 15. Modify the self join so that all employees appear, including employees
--     without a manager. Display "No manager" for a missing manager.

select e.employee_name, coalesce(m.employee_name, 'No Manager') manager_name
from employees e
left join employees m
on e.manager_id = m.employee_id;

-- 16. Use a non-equi join to assign every employee to a salary grade. Display
--     employee_name, salary and grade_code.
select employee_name, salary, s.grade_code
from employees e
join salary_grades s 
on e.salary between  s.min_salary and  s.max_salary;

select * from salary_grades;

-- 17. Use NATURAL JOIN to display employee_id, employee_name, department_id and
--     department_name for matched employees.

	SELECT employee_id, employee_name, e.department_id ,m.department_name 
    FROM employees as e
    JOIN departments as m
    ON e.department_id=m.department_id;


-- 18. Write a LEFT JOIN that preserves every employee but matches department
--     details only when the department name is Engineering. Put the department
--     filter inside the ON clause.
	
    select employee_id, employee_name, d.department_id, department_name
    from employees e 
    left join departments d
    on e.department_id = d. department_id and department_name = 'Engineering';
    
 --    19. Write a LEFT JOIN that preserves every employee but matches department
--     details only when the department name is Engineering. Using WHERE 
	
    select employee_id, employee_name, d.department_id, department_name
    from employees e 
    left join departments d
    on e.department_id = d. department_id 
    where department_name = 'Engineering';
    
-- 20. Count the number of employees in every department. Departments with no
--     employees must appear with employee_count equal to zero.

select department_name, count(employee_id) 
from employees e 
right join departments d
on e.department_id = d.department_id
group by department_name;

-- 21. Calculate the average employee salary for every department. Include empty
--     departments and display zero as their average salary.

select department_name, coalesce(avg(salary), 0)
from employees e
right join departments d
on e.department_id = d.department_id
group by department_name;

-- 22. Display only departments that have at least two employees. Show
--     department_name and employee_count.

SELECT department_name,COUNT(e.department_id) as count
from employees as e
RIGHT JOIN departments as d
ON e.department_id=d.department_id
GROUP BY department_name
HAVING count>=2;

-- 23. Display each department's total salary expense. Include empty departments
--     and display zero for their total salary.

select department_name,  coalesce(sum(salary), 0) as total_salary
from employees e
right join departments d 
on e.department_id = d.department_id
group by department_name;

-- 24. Display employee_id, employee_name, department_name and manager_name for
--     every employee. Employees without a department or manager must remain in
--     the result.

select e.employee_id, e.employee_name, coalesce(d.department_name, 'No Department') AS department_name, coalesce(m.manager_id, 'No Manager')
from employees e 
left join employees m
on e.manager_id = m.employee_id
left join departments d
on e.department_id = d.department_id;

-- 25. Display every department with its highest employee salary. Departments
--     without employees must appear with zero as highest_salary.

select department_name, coalesce(max(salary), 0) max_salary
from employees e
right join departments d
on e.department_id = d.department_id
group by department_name;







