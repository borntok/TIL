--01 union ����
--union:�ߺ��� ������ ����

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



--02 union all ����
--�ߺ��� �����͵� ��� ���
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





--03 intersect ����
--�������� ����

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
--inner join ����� ����

select employee_id
from keys 
 intersect
select employee_id
from hipos
 order by employee_id desc;
--inner join ����� ����




--04 except ����
--A�� B�� ������ ����

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
--��� �����ϴ� ��ȭ�� film_id, title ���� (dicinct�� �ߺ��� ����)

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
--��ü ��ȭ���� ��� �����ϴ� ��ȭ�� ����
--��� ���� ��ȭ film_id, title ���

select * from inventory
where film_id = 33 ;





--05 ��������

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
 



--06 any ������
--���������� ���� ��� ���̶� ������ �ϸ� ���� ����

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
-- = any�� in�� ����
 
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
	
 
 

 
 
--07 all ������
--���������� ��� ���� �����ؾ߸� ������ ����
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



--08 exist ������
--�������� ���� ������ �����ϴ��� ���θ� �Ǵ�, ����� ���� ����
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







--09 �ǽ����� 1
--�Ʒ� sql���� film ���̺��� 2���̳� ��ĵ�ϰ� �ִ�. film ���̺��� �ѹ��� ��ĵ�Ͽ� ������ ��� ������ ���ϴ� sql���� �ۼ��϶�

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
 



--10 �ǽ�����2
--�Ʒ� sql���� except ������ ����Ͽ� ��� ���� ��ȭ�� ���ϰ� �ִ�. �ش� sql���� except ������ ������� ���� ���� ����� �����϶�

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



--���� Ǭ��
select 
	distinct a.film_id, 
	title
from film a 
left join inventory b 
on b.film_id = a.film_id 
where b.film_id is null 
;

--����Ǯ��
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