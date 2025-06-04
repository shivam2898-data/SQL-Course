use test;
-- not null
create table  xyz1(id int not null, fname varchar(20));
insert into xyz1 values(1,'tushar');
select * from xyz1;

-- unique
create table  xyz2(id int not null, fname varchar(20) unique);
insert into xyz2 values(1,'tushar');
insert into xyz2 values(2,'tushar'); -- error of unique value
insert into xyz2 values(2,null);
select * from xyz2;

-- default
create table  xyz3(id int , fname varchar(20) default 'regex');
insert into xyz3 values(1,'tushar');
insert into xyz3(id) values(2); 
select * from xyz3;

-- datetimes default
create table  xyz4(dob datetime  default now());
insert into xyz4 values('2024-10-09');
insert into xyz4() values(); 
select * from xyz4;

-- primary key 
create table  xyz5(id int primary key );
insert into xyz5 values(1);
insert into xyz5 values(1); -- druplicate value error
insert into xyz5 values(null);-- can not be null error
select * from xyz5;


-- foreign key and primary key
CREATE TABLE school (
    addmission_id INT,
    clg_name VARCHAR(20),
    stdid INT,
    FOREIGN KEY (stdid) REFERENCES student(stdid)
);
insert into school values
(10,'IIS',101),
(11,'NPS',102),
(12,'DPS',103);
select * from school;

select * from school;
create table student(std_name varchar(20), stdid int primary key );
insert into student values
('aman',101),
('ajay',102),
('ravi',103);
select * from student;


create table students(studentid int primary key, name varchar(20),age int, grade int, city varchar(20));

create table marks( studentid int , subject varchar(20), marks int,
 FOREIGN KEY (studentid) REFERENCES students(studentid)
);

-- usinf the subquery create the table, delete the record
use sakila;
create table test99 as
  select actor_id, first_name from actor;
 select * from test99;
 
 -- delete that actor_id whose is actor_id is the same as that of first_name of penelope?
select actor_id from test99 where first_name='penelope';
 delete  from test99
 where actor_id in( select actor_id from actor where first_name='penelope');
 
 delete from test99 where actor_id ='penelope';
 
select * from payment;
create table temp as 
select payment_id, customer_id,amount from payment;
select * from temp;

select amount from temp where payment_id=2;
select * from temp where customer_id=1 and amount = (select amount from temp where payment_id=2);