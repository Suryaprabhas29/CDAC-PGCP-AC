create database sqlassignment3;
use sqlassignment3;

-- creating students table
create table students(
student_id varchar(20) primary key,
student_name varchar(20),
email varchar(50),
age int, 
course varchar(20)
);
describe students;
select * from students;

-- adding a new column phone_number
alter table students add column phone_number varchar(20);

-- inserting 5 student details into table
INSERT INTO students(student_id,student_name,email,age,course,phone_number)
VALUES('20059','Harsha','harsha@cdac.in',23,'PGCP-AC',9502986671),
('20010','Sachin','sachin@cdac.in',25,'PGCP-AI',8976345210),
('20073','Surya','surya@cdac.in',23,'PGCP-AC',9354855574),
('20045','Rohit','rohit@cdac.in',17,'PGCP-ESD',9454567672),
('20025','Ram','ram@cdac.in',18,'PGCP-BDA',9866711877);

-- removing students whose age<18
DELETE FROM students WHERE age<18;



-- creating a courses table 
create table courses(
course_id varchar(20) primary key,
course_name varchar(100),
duration varchar(20),
fee decimal(10,3)
);
describe courses;
select * from courses;

-- modifying fee datatype
alter table courses modify column fee decimal(10,3);
-- renaming course_name into course_title
alter table courses rename column course_name to course_title;

-- inserting 5 course detais into table
INSERT INTO courses(course_id,course_title,duration,fee)
VALUES('101','PGCP-AC','6 Months',116000),
('102','PGCP-BDA','6 Months',125000),
('103','PGCP-AI','6 Months',150000),
('104','PGCP-ESD','6 Months',130000),
('105','PGCP-ITISS','6 Months',145000);

-- increasing fee by 10% on each course
UPDATE courses SET fee=fee+(fee*0.1);
-- removing all data from courses table
TRUNCATE courses;



-- creating enrollment table
create table enrollment(
enrollment_id varchar(20) primary key,
student_id varchar(20),
course_id varchar(20),
enroll_date date,
foreign key(student_id) references students(student_id) on update cascade,
foreign key(course_id) references courses(course_id) on update cascade
);
describe enrollment;
select * from enrollment;

-- dropping the enrollment table
drop table enrollment;