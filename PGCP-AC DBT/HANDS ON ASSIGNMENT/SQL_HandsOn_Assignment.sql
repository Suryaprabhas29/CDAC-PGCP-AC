CREATE DATABASE IF NOT EXISTS dml_practice;
USE dml_practice;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(100) NOT NULL,
 department VARCHAR(40) NOT NULL,
 job_title VARCHAR(60) NOT NULL,
 city VARCHAR(40) NOT NULL,
 salary DECIMAL(10,2) NOT NULL,
 joining_date DATE NOT NULL,
 experience_years INT NOT NULL,
 performance_rating DECIMAL(2,1) NOT NULL,
 employment_status VARCHAR(15) NOT NULL
);

INSERT INTO employees
(employee_id, employee_name, department, job_title, city, salary,
joining_date, experience_years, performance_rating, employment_status)
VALUES
(101, 'Aarav Mehta', 'IT', 'Software Engineer', 'Bangalore', 78000.00, '2021-06-15', 4, 4.3, 'Active'),
(102, 'Bhavna Rao', 'HR', 'HR Executive', 'Hyderabad', 52000.00, '2022-03-10', 3, 4.0, 'Active'),
(103, 'Charan Das', 'Finance', 'Financial Analyst', 'Chennai', 68000.00, '2020-11-20', 5, 4.2, 'Active'),
(104, 'Diya Kapoor', 'IT', 'Data Engineer', 'Pune', 92000.00, '2019-08-05', 7, 4.7, 'Active'),
(105, 'Eshan Nair', 'Sales', 'Sales Executive', 'Bangalore', 61000.00, '2023-01-12', 2, 3.8, 'Probation'),
(106, 'Farah Khan', 'Marketing', 'Content Specialist', 'Mumbai', 58000.00, '2021-09-27', 4, 4.1, 'Active'),
(107, 'Gaurav Iyer', 'Finance', 'Accountant', 'Bangalore', 64000.00, '2018-04-16', 8, 3.9, 'Active'),
(108, 'Harini Shah', 'IT', 'Software Engineer', 'Hyderabad', 85000.00, '2020-02-24', 6, 4.5, 'Active'),
(109, 'Ishaan Gupta', 'Operations', 'Operations Analyst', 'Delhi', 57000.00, '2022-07-18', 3, 3.7, 'Notice'),
(110, 'Jaya Menon', 'HR', 'Recruiter', 'Chennai', 55000.00, '2021-12-06', 4, 4.4, 'Active');

INSERT INTO employees
(employee_id, employee_name, department, job_title, city, salary,
joining_date, experience_years, performance_rating, employment_status)
VALUES
(111, 'Karan Verma', 'Sales', 'Sales Manager', 'Mumbai', 96000.00, '2017-05-30', 9, 4.6, 'Active'),
(112, 'Lavanya Reddy', 'IT', 'QA Engineer', 'Bangalore', 72000.00, '2022-10-14', 3, 4.0, 'Active'),
(113, 'Manish Jain', 'Marketing', 'Marketing Manager', 'Delhi', 88000.00, '2019-03-22', 7, 4.3, 'Active'),
(114, 'Neha Bhat', 'Finance', 'Financial Analyst', 'Pune', 74000.00, '2023-06-01', 2, 4.1, 'Probation'),
(115, 'Om Prakash', 'Operations', 'Process Executive', 'Hyderabad', 49000.00, '2024-01-08', 1, 3.6, 'Probation'),
(116, 'Pooja Sinha', 'IT', 'Data Analyst', 'Kolkata', 81000.00, '2020-09-17', 6, 4.8, 'Active'),
(117, 'Rahul Bose', 'Sales', 'Sales Executive', 'Chennai', 63000.00, '2021-02-11', 5, 3.9, 'Notice'),
(118, 'Sneha Kulkarni','HR', 'Training Executive', 'Pune', 59000.00, '2022-05-25', 3, 4.2, 'Active'),
(119, 'Tarun Malhotra','Operations', 'Operations Manager', 'Bangalore', 91000.00, '2018-12-03', 8, 4.5, 'Active'),
(120, 'Ananya Roy', 'Marketing', 'SEO Specialist', 'Mangalore', 62000.00, '2023-08-21', 2, 4.0, 'Active');

SELECT COUNT(*) AS inserted_records FROM employees;

SELECT * FROM employees ORDER BY employee_id;

-- 1. Display all employees whose salary is greater than 70000. 
SELECT * FROM employees WHERE salary>70000;
-- 2. Display employee_id, employee_name, department and salary for employees working in the Finance department.
SELECT employee_id,employee_name,department,salary FROM employees WHERE department='Finance';
-- 3. Display all employees whose employment_status is Active and whose performance_rating is at least 4.0. 
SELECT * FROM employees WHERE employment_status='Active' AND performance_rating>=4;
-- 4. Display employees whose names begin with the letter A.
SELECT * FROM employees WHERE employee_name LIKE 'a%';
-- 5. Display employees working in cities whose names end with 'ore'. 
SELECT * FROM employees WHERE city LIKE '%ore';
-- 6. Display employees whose job title contains the word 'Engineer'. 
SELECT * FROM employees WHERE job_title LIKE '%engineer%';
-- 7. Display employees who work in the IT department AND earn more than 75000. 
SELECT * FROM employees WHERE department='IT' AND salary>75000;
-- 8. Display employees who work in Bangalore OR Hyderabad. 
SELECT * FROM employees WHERE city='Bangalore' OR city='Hyderabad';
-- 9. Display employees who do NOT belong to the HR department and whose employment_status is Active. 
SELECT * FROM employees WHERE department!='HR' AND employment_status='Active';
-- 10. Display employees whose salary is BETWEEN 60000 and 80000, including both boundary values. 
SELECT * FROM employees WHERE salary BETWEEN 60000 AND 80000;
-- 11. Display employees who joined BETWEEN '2020-01-01' and '2022-12-31'. Show employee_name and joining_date.
SELECT employee_name,joining_date FROM employees WHERE joining_date BETWEEN '2020-01-01' AND '2022-12-31';
-- 12. Display employees whose department is IN IT, Finance or Marketing. 
SELECT * FROM employees WHERE department IN ('IT','Finance','Marketing');
-- 13. Display employees located IN Bangalore, Pune or Chennai and whose employment_status is Active. 
SELECT * FROM employees WHERE city IN ('Bangalore','Pune','Chennai') AND employment_status='Active';
-- 14. Display the first five employee records when arranged by employee_id in ascending order. 
SELECT * FROM employees ORDER BY employee_id LIMIT 5 OFFSET 0;
-- 15. Display the three employees with the highest salary. Show employee_name, department and salary. 
SELECT employee_name,department,salary FROM employees ORDER BY salary DESC LIMIT 3 OFFSET 0;
-- 16. Find the total number of employees. Name the result column employee_count. 
SELECT count(*) AS employee_count FROM employees;
-- 17. Calculate the average salary of all employees and round the result to two decimal places. Name the result column average_salary.
SELECT AVG(salary) AS average_salary FROM employees;
-- 18. Display the minimum salary, maximum salary and total salary paid to all employees using suitable aliases. 
SELECT MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary, SUM(salary) AS total_salary FROM employees;
-- 19. Count the number of employees in each department. Display department and employee_count. 
SELECT department,count(department) AS employee_count FROM employees GROUP BY department;
-- 20. Calculate the average salary for each city. Display city and average_salary, with the highest average shown first.
SELECT city, AVG(salary) AS average_salary FROM employees GROUP BY city ORDER BY average_salary DESC;
-- 21. For each job title, display the number of employees and the maximum salary. Use meaningful aliases.
SELECT job_title, COUNT(*) AS total_employees, MAX(salary) AS max_salary FROM employees GROUP BY job_title;
-- 22. Display only those departments that have more than two employees. 
SELECT department FROM employees GROUP BY department HAVING COUNT(*)>2;
-- 23. Display cities whose average employee salary is greater than 70000. Show city and average_salary.
SELECT city, AVG(salary) AS average_salary FROM employees GROUP BY city HAVING average_salary>70000;
-- 24. Display job titles for which the maximum salary is greater than 90000. Show job_title and maximum_salary. 
SELECT job_title, MAX(salary) AS maximum_salary from employees GROUP BY job_title HAVING maximum_salary>90000;
-- 25. Among Active employees, display departments whose total salary is BETWEEN 150000 and 400000. Show department, employee_count and total_salary. 
SELECT department, COUNT(*) AS employee_count, SUM(salary) AS total_salary from employees
WHERE employment_status='Active'
GROUP BY department
HAVING total_salary BETWEEN 150000 AND 400000;

