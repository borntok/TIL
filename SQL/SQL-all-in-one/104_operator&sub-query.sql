--01 union 연산
--union:중복된 데이터 제거

create table sales2007_1 
(
 name varchar(50),
 amount numeric(15, 2)
 );
 
insert into sales2007_1
values
 ('Mike', 150000.25),
 ('Jon', 132000.75),
 ('Mary', 100000)
 ;
 
create table sales2007_2
(
 name varchar(50),
 amount numeric(15, 2)
 );
 
insert into sales2007_2
values
 ('Mike', 120000.25),
 ('Jon', 142000.75),
 ('Mary', 100000)
 ;
 
commit;

select * from sales2007_1;
select * from sales2007_2;


select * 
  from sales2007_1
union
select * 
  from sales2007_2;
  
select name
  from sales2007_1
union
select name
  from sales2007_2;
  
select amount
  from sales2007_1
union
select amount
  from sales2007_2;
  
 
 select * 
  from sales2007_1
union
select * 
  from sales2007_2
order by amount desc ;



--02 union all 연산
--중복된 데이터도 모두 출력
select * from sales2007_1;
select * from sales2007_2;


select * 
  from sales2007_1
union all
select * 
  from sales2007_2;
  
select name
  from sales2007_1
union all
select name
  from sales2007_2;
  
select amount
  from sales2007_1
union all
select amount
  from sales2007_2;
 
 select * 
  from sales2007_1
union all
select * 
  from sales2007_2
order by amount desc ;





--03 intersect 연산
--교집합을 리턴

drop table employees ;

create table employees
(
 employee_id serial primary key,
 employee_name varchar(255) not null
 );


create table keys
(
 employee_id int primary key,
 effective_date date not null,
 foreign key (employee_id)
 references employees (employee_id)
 );
 
create table hipos
(
 employee_id int primary key,
 effective_date date not null,
 foreign key (employee_id)
 references employees (employee_id)
 );
 
insert into employees (employee_name)
values 
 ('Joyce Edwards'),
 ('Diane Collins'),
 ('Alice Stewart'),
 ('Julie Sanchez'),
 ('Heather Morris'),
 ('Teresa Rogers'),
 ('Doris Reed'),
 ('Gloria Cook'),
 ('Evelyn Morgan'),
 ('Jean Bell')
 ;
 
insert into keys
values
 (1, '2000-02-01'),
 (2, '2001-06-01'),
 (5, '2002-01-01'),
 (7, '2005-06-01')
 ;
 
insert into hipos
values
 (9, '2000-01-01'),
 (2, '2002-06-01'),
 (5, '2006-06-01'),
 (10, '2005-06-01')
 ;
 

select * from employees;
select * from keys;
select * from hipos;


select employee_id
from keys 
 intersect
select employee_id
from hipos;
--inner join 연산과 동일

select employee_id
from keys 
 intersect
select employee_id
from hipos
 order by employee_id desc;
--inner join 연산과 동일




--04 except 연산
--A와 B의 차집합 리턴

select * from inventory ;
select * from film;


select 
	distinct a.film_id,
			 b.title
from inventory a 
inner join film b 
  on b.film_id = a.film_id 
order by b.title 
;
--재고가 존재하는 영화의 film_id, title 추출 (dicinct로 중복값 제거)

select 
	film_id,
	title
from film 
except
select
	distinct a.film_id,
			 title
from inventory a 
inner join film b
on b.film_id = a.film_id
order by title 
;
--전체 영화에서 재고가 존재하는 영화를 뺀다
--재고가 없는 영화 film_id, title 출력

select * from inventory
where film_id = 33 ;





--05 서브쿼리

select * from film;

select
	film_id,
	title,
	rental_rate
from film 
where rental_rate >
 (
  select
  	avg (rental_rate)
  from film	
  );
  
 
 select 
 	a.film_id,
 	a.title,
 	a.rental_rate
 from film a,  
 	 ( 
 	  select 
 	  	avg(rental_rate) as avg_rental_rate
 	  from film ) b 	  
 where a.rental_rate > b.avg_rental_rate
 ;
 

select 
	a.film_id,
	a.title,
	a.rental_rate
from 
( 
 select 
 	a.film_id,
 	a.title,
 	a.rental_rate,
 	(
 	 select
 	 	avg(l.rental_rate)
 	 from film l 
 	 ) as avg_rental_rate
 from film a 
 ) a 
 where a.rental_rate > a.avg_rental_rate
 ;
 



--06 any 연산자
--서브쿼리의 값이 어떠한 값이라도 만족을 하면 조건 성립

select * from film;
select * from film_category ;

select 
	title,	length
from 
	film 
where length >= any 
 (
  select max(length)
  from film a, film_category b 
  where a.film_id = b.film_id 
  group by b.category_id
  );

 
 
select 
	title,	length
from 
	film 
where length = any 
 (
  select max(length)
  from film a, film_category b 
  where a.film_id = b.film_id 
  group by b.category_id
  );
-- = any와 in은 동일
 
select * from film;
select * from film_category ; 
 
 
select 
	title,	length
from 
	film 
where length in 
 (
  select max(length)
  from film a, film_category b 
  where a.film_id = b.film_id 
  group by b.category_id
  );
	
 
 

 
 
--07 all 연산자
--서브쿼리의 모든 값을 만족해야만 조건이 성립
select 
	title,	length
from 
	film 
where length >= all 
 (
  select max(length)
  from film a, film_category b 
  where a.film_id = b.film_id 
  group by b.category_id
  );
 
 
select round(avg(length), 2)
from film 
group by rating ;

select 
	film_id, title, length
from
	film 
where length > all
 (
  select round(avg(length), 2)
  from film
  group by rating 
  )
order by length;



--08 exist 연산자
--서브쿼리 내에 집합이 존재하는지 여부만 판단, 연산시 부하 감소
select * from customer ;
select * from payment ;

select
	c.first_name,
	c.last_name
from customer c 
where 
 exists
  (
   select 1
   from payment p
   where p.customer_id = c.customer_id
     and p.amount > 11
   )
order by first_name, last_name 
;


select
	c.first_name,
	c.last_name
from customer c 
where 
 not exists
  (
   select 1
   from payment p
   where p.customer_id = c.customer_id
     and p.amount > 11
   )
order by first_name, last_name 
;







--09 실습문제 1
--아래 sql문은 film 테이블을 2번이나 스캔하고 있다. film 테이블을 한번만 스캔하여 동일한 결과 집합을 구하는 sql문을 작성하라

select 
	film_id,
	title,
	rental_rate
from film 
where rental_rate >
 (
  select
  	avg(rental_rate)
  from film
 );



select 
	film_id ,
	title ,
	rental_rate 
from
 (
  select 
	film_id,
	title,
	rental_rate,
	avg(rental_rate) over() as avg_rental_rate
  from film
  ) a 
 where rental_rate > avg_rental_rate
 ;
 



--10 실습문제2
--아래 sql문은 except 연산을 사용하여 재고가 없는 영화를 구하고 있다. 해당 sql문은 except 연산을 사용하지 말고 같은 결과를 도출하라

select 
	a.film_id, 
	title
from film a 
except
select 
	distinct b.film_id,
	title
from inventory b 
inner join film a 
on a.film_id = b.film_id 
order by title;



--내가 푼거
select 
	distinct a.film_id, 
	title
from film a 
left join inventory b 
on b.film_id = a.film_id 
where b.film_id is null 
;

--문제풀이
select 
	a.film_id,
	a.title
from film a 
where not exists 
 (
  select 1
  from inventory b, film c 
  where b.film_id = c.film_id 
  and a.film_id = c.film_id 
  )
 ;