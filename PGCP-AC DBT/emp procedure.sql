create database if not exists db_employees;
use db_employees;

drop table if exists emp;

create table emp(
emp_id int primary key,
emp_name varchar(20),
sal decimal(10,2)
);
select * from emp;

delimiter //
create procedure SaveEmpRecords(
in p_emp_id int,
in p_emp_name varchar(20),
in p_sal decimal(10,2)
)
begin
insert into emp values(p_emp_id,p_emp_name,p_sal);
end //
delimiter ;

call SaveEmpRecords(101,'Harsha',4000);
call SaveEmpRecords(102,'Vardhan',2500);
call SaveEmpRecords(103,'Surya',3200);

DROP PROCEDURE IF EXISTS calculateSal;
DELIMITER //
create procedure calculateSal(in p_emp_id int)
begin
declare c_sal decimal(10,2);
declare c_count INT;

    SELECT COUNT(*)
    INTO c_count
    FROM emp
    WHERE emp_id = p_emp_id;
    
    IF c_count = 0 THEN
        SELECT 'Employee ID not found' AS message;
   else     
	select sal into c_sal from emp
	where emp_id=p_emp_id;
		if c_sal>=3000 then
		select 'High Salary' as message;
		else 
		select 'Low Salary' as message;
		end if;
	end if;
end //
delimiter ;

call calculateSal(101);
call calculateSal(102);
call calculateSal(104);



