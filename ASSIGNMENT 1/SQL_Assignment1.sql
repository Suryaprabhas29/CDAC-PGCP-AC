CREATE DATABASE company_db;
USE company_db;

-- creating employees table
CREATE table employees
(emp_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) NULL,
hire_date DATE NOT NULL,
salary DECIMAL(10,2) NOT NULL,
department VARCHAR(50) NOT NULL
);

-- inserting 5 employees details
INSERT INTO employees(first_name,last_name,email,phone,hire_date,salary,department)
VALUES('Harsha','Vardhan','harsha@gmail.com',9502986671,'2026-06-20',45000,'IT'),
('Sachin','Tendulkar','sachin@gmail.com',9876543210,'2026-05-20',72000.23,'HR'),
('Rohit','Sharma','rohit@gmail.com',8697493020,'2025-11-15',54500,'IT'),
('Gali','Mallikarjuna','malli019@gmail.com',9866711877,'2025-05-01',99900,'Manager'),
('Anjali','Dubey','anju@gmail.com',8505769320,'2026-04-24',48500,'Finance');
-- retrieving all employees details
SELECT * FROM employees;
-- retrieving employees details whose salary>50000
SELECT * FROM employees WHERE salary>50000;
-- retrieving employees details whose hired date after january 01,2026
SELECT * FROM employees WHERE hire_date>'2026-01-01';
-- retrieving employees details who belongs to IT department
SELECT * FROM employees WHERE department='IT';
-- counting number of employees details in employees table
select count(*) as total_employees from employees;
-- updating salary of an employee whose emp_id=3
UPDATE employees SET salary=salary+(salary*0.1) WHERE emp_id=3;
-- deleting the employee whose emp_id=5
DELETE FROM employees WHERE emp_id=5;






