use sakila;
select * from actor;
select * from film_actor;


-- find the number of actor who have worked in fiml_id 40
select count(actor_id) from film_actor where film_id=40;
-- find out those actor who have worked in flim_id 40?
SELECT a.actor_id  FROM actor AS a JOIN film_actor AS f ON a.actor_id = f.actor_id 
WHERE f.film_id = 40;

-- get the total  number of movie done by eqach actor?
select count(actor_id) from film_actor group by actor_id;

-- get the number of actor who have worked in each movie?
select count(actor_id) ,film_id from film_actor group by film_id;


-- get only the film id where the number of actor worked is 2?
SELECT film_id FROM film_actor GROUP BY film_id HAVING COUNT(actor_id) = 2;

select * from payment;

-- get the number of staff serving each customer the total amoiunt and the avg amount spend by each customr?
select count(staff_id) , sum(amount) ,avg(amount) , customer_id from payment group by customer_id;

-- get the total amount spend by each staff memeber for each customer?
select sum(amount), customer_id ,staff_id from payment group by customer_id, staff_id;

-- total amount spent f0r eah month of the year?
select year(payment_date),month( payment_date),sum(amount) from payment group by year(payment_date),month( payment_date);

select month( payment_date),year(payment_date),sum(amount) from payment group by month( payment_date),year(payment_date);

select * from payment;

-- get all the columns whose payment date is greater than the payemtn date for id 3?
 select payment_date from payment where payment_id=3;
 select * from payment where payment_date > (select payment_date from payment where payment_id=3);
 
 -- get those informantion where the staff id and the amount is same as the  payment_id=2?
 -- multi_column_subquery
 select amount,staff_id from payment where payment_id=2;
 select * from payment where (staff_id,amount) =(select staff_id,amount from payment where payment_id=2);
 
 -- get those customer and the total number of payments done where the total number of payemtn done is greater then the total number od payment by customer_id=2?
 
 select count(payment_id) from payment where customer_id=2;
 select customer_id, count(payment_id) from payment group by customer_id having count(payment_id)>(select count(payment_id) from payment where customer_id=2);
 
 select * from payment;
 
 -- get the payment id ,customer id, amount from the payment table where the amount spend by the customer is greater than the avg amount done by the customer?
 select avg(amount) from payment group by customer_id;
 select payment_id, customer_id , amount from payment as p where amount>(select avg(amount) from payment as p1 where p.customer_id=p1.customer_id );
 
  select payment_id, customer_id , amount from payment as p where amount>(select avg(amount) from payment as p1 where p.payment_id=p1.payment_id group by customer_id)