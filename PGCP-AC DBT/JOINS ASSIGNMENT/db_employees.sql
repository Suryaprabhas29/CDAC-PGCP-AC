
-- ==================================================================
-- 1. CREATE AND SELECT THE DATABASE
-- ==================================================================

CREATE DATABASE IF NOT EXISTS db_employees;
USE db_employees;


-- ==================================================================
-- 2. REMOVE OLD TABLES
-- Drop child tables before parent tables so the script can be rerun.
-- ==================================================================

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salary_grades;
DROP TABLE IF EXISTS shifts;
DROP TABLE IF EXISTS departments;


-- ==================================================================
-- 3. CREATE TABLES
-- ==================================================================

-- Parent table used in most join examples.
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(60) NOT NULL UNIQUE,
    location        VARCHAR(60) NOT NULL
) ;


-- Employee has two relationships:
--   department_id references departments
--   manager_id references another employee
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


-- Used to demonstrate CROSS JOIN.
CREATE TABLE shifts (
    shift_id   INT PRIMARY KEY,
    shift_name VARCHAR(30) NOT NULL UNIQUE,
    start_time TIME NOT NULL,
    end_time   TIME NOT NULL
);


-- Used to demonstrate a non-equi range join.
CREATE TABLE salary_grades (
    grade_code VARCHAR(2) PRIMARY KEY,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    CONSTRAINT chk_salary_grade_range
        CHECK (min_salary <= max_salary)
) ;


-- ==================================================================
-- 4. INSERT SAMPLE DATA
-- ==================================================================

INSERT INTO departments
    (department_id, department_name, location)
VALUES
    (10, 'Engineering', 'Bangalore'),
    (20, 'Human Resources', 'Hyderabad'),
    (30, 'Sales', 'Mumbai'),
    (40, 'Finance', 'Pune'),
    (50, 'Research', 'Chennai');


-- Managers are inserted before employees who reference them.
-- Imran has no department to create an unmatched employee row.
-- Finance and Research have no employees to create unmatched departments.
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


-- ==================================================================
-- 5. VALIDATE THE SETUP
-- ==================================================================

SELECT * FROM departments ORDER BY department_id;
SELECT * FROM employees ORDER BY employee_id;
SELECT * FROM shifts ORDER BY shift_id;
SELECT * FROM salary_grades ORDER BY min_salary;
