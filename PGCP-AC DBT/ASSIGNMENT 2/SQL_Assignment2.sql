create database sqlassignment2;
use sqlassignment2;

-- DDL Commands

-- creating books table
create table Books(name varchar(50) not null,
author varchar(20) not null,
price decimal(10,2) not null,
writer varchar(20) not null
);

describe books;
select * from books; 

-- adding a new column published_year
alter table books add column published_year year;
-- modifying datatype of price column
alter table books modify column price decimal(10,3);
-- changing column name from writer to publisher
alter table books rename column writer to publisher;
-- removing entire published_year column structure 
alter table books drop column published_year;
-- removing entire structure of books table
drop table books;


-- DML Commands

-- inserting 5 books details into table
insert into books 
values ('wings of fire','abdul kalam',500,'abdul kalam'),
('python','james',400,'james'),
('java','harsha',600,'harsha') ,
('DBT','nikhil',300,'nikhil'),
('CPP','ajay',700,'ajay');

-- updating price of a specific book using name
SET SQL_SAFE_UPDATES = 0;
update books set price = 1000 where name = 'wings of fire';
-- deleting a particular named book from table
delete from books where name='CPP';
-- deleting all data from books table
truncate table books;


