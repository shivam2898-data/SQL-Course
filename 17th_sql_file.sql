-- transaction
select @@autocommit;
set @@autocommit=0;

create database tushar;
use tushar;
create table test(id int);
insert into test values (1);
select * from test;

-- transaction start=> DMl, start tranction
-- transaction end=> commit, rollback, DDL, DCL

create table test1(id int);
insert into test1 values (3),(4);
commit;  -- save into my database
select * from test1;
insert into test1 values(500);
update test1 set id=99;
select * from test1;
rollback;-- discard the changes
select * from test1;

insert into test1 values(600);
create table y1(a int);
rollback;
select * from test1;
commit;
select * from test1;
insert into test1 values(90),(91);
delete from test1 where id=3;
savepoint test1_chpoint;
update test1 set id=10000;
rollback to test1_chpoint;
select * from test1;
commit;

set @@autocommit=1;
start transaction;
update test1 set id=999999;
rollback;
select * from test1;

-- view=> virtul
-- complex query easy
-- database (no data is store)
-- virtual data=> query of the base table
-- data access()

use tushar;
create table t_actor as 
select * from sakila.actor limit 20;

create view actor_view1 as select actor_id, first_name from t_actor;
select * from actor_view1;

-- updattable view
select * from t_actor;
create view actor_view as select * from t_actor;
select * from actor_view;
delete from actor_view where actor_id=1;
select * from actor_view;

-- non updattable view
create view actor_view4 as select lower(first_name) from t_actor where actor_id = 5 ;
select * from actor_view4;

delete from actor_view4 where actor_id=3; -- error show 