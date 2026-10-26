CREATE DATABASE CompanyDBMS;
USE CompanyDBS;

-- Part 1: Database & Table Creation --

CREATE TABLE Employeee(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(15) NULL,
hire_date DATE NOT NULL,
salary DECIMAL(10,2) NOT NULL,
department VARCHAR(50) NOT NULL);

-- Part 2: Data Insertion --

INSERT INTO Employeee( emp_id,first_name,last_name,email,phone,hire_date,salary,department)
VALUES ( '101' ,'nikhil','langipalli','nikhil@gmail.com','9126123456','2026-08-15','75000','IT'),
	   ( '102' , 'harsha','gali','harsha@gmail.com','9226123456','2025-07-14' ,'65000','Sales'), 
       ( '103' , 'manoj','cherkuri' , 'manoj@gmail.com', '9326123456','2024-06-13','55000','HR'),
       ( '104' , 'ajay','tekkali' , 'ajay@gmail.com','9426123456','2023-05-12','45000','Marketing'),
       ( '105' , 'sriman','banka', 'sriman@gmail.com','9526123456','2022-04-11','35000','Creator');

-- Part 3:  Basic Queries --

SELECT * FROM Employeee;

SELECT * FROM Employeee
WHERE salary > 50000;

SELECT * FROM Employeee
WHERE hire_date >  2022-01-01;

SELECT * FROM Employeee
WHERE department = 'IT';

SELECT * FROM Employeee;

UPDATE Employeee SET salary = salary+(salary*0.1)
WHERE emp_id=103;

SELECT * FROM Employeee;

DELETE FROM Employeee
WHERE emp_id = 105;


