--02 inner조인
create table basket_A ( 
    id int primary key,
 fruit varchar (100) not null );

create table basket_b ( 
    id int primary key,
  fruit varchar (100) not null );
  
insert into basket_A (id, fruit)
values (1, 'Apple'),
       (2, 'Orange'),
       (3, 'Banana'),
       (4, 'Cucumber')
;
commit;

insert into basket_B (id, fruit)
values (1, 'Orange'),
       (2, 'Apple'),
       (3, 'Watermelon'),
       (4, 'Pear')
;
commit;


select * from basket_a ;

select * from basket_b ;


SELECT
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A
INNER JOIN BASKET_B B 
      ON   A.FRUIT = B.FRUIT;
--basket_A 테이블과 basket_B 테이블을 fruit 기준으로 교집합인 데이터 출력
     

     
select * from customer;
select * from payment;

select
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
from
	CUSTOMER A 
inner join 
    PAYMENT B
on	A.CUSTOMER_ID = B.CUSTOMER_ID ;
--customer 테이블과 payment 테이블을 customer_id를 기준으로 조인
select count(*) from payment ;

 
select 
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE
from
	CUSTOMER A
inner join 
    PAYMENT B
on	A.CUSTOMER_ID = B.CUSTOMER_ID
where A.CUSTOMER_ID = 2;
--customer 테이블과 payment 테이블을 customer_id를 기준으로 조인
--customer_id가 2인 데이터만 출력


select * from staff;

SELECT
	A.CUSTOMER_ID,
	A.FIRST_NAME,
	A.LAST_NAME,
	A.EMAIL,
	B.AMOUNT,
	B.PAYMENT_DATE,
	C.FIRST_NAME AS S_FIRST_NAME,
	C.LAST_NAME AS S_LAST_NAME
FROM
	CUSTOMER A
INNER JOIN PAYMENT B ON
	A.CUSTOMER_ID = B.CUSTOMER_ID
INNER JOIN STAFF C ON
	B.STAFF_ID = C.STAFF_ID ;
	




--03 outer조인
select * from basket_a ;
select * from basket_b ;


select
	A.ID as ID_A,
	A.FRUIT as FRUIT_A,
	B.ID as ID_B,
	B.FRUIT as FRUIT_B
from
	BASKET_A A
left join BASKET_B B on
	A.FRUIT = B.FRUIT;


select
	A.ID as ID_A,
	A.FRUIT as FRUIT_A,
	B.ID as ID_B,
	B.FRUIT as FRUIT_B
from
	BASKET_A A
left join BASKET_B B on
	A.FRUIT = B.FRUIT
where B.ID is null;
--left only



SELECT
	A.ID AS ID_A,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT;
	

SELECT
	A.ID AS ID_A,
	A.FRUIT AS FRUIT_A,
	B.ID AS ID_B,
	B.FRUIT AS FRUIT_B
FROM
	BASKET_A A
RIGHT JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT
WHERE A.ID IS NULL;
--right only



--04 self 조인
drop table employee;

CREATE TABLE EMPLOYEE 
(
  EMPLOYEE_ID INT PRIMARY KEY,
  FIRST_NAME VARCHAR (255) NOT NULL,
  LAST_NAME VARCHAR (255) NOT NULL,
  MANAGER_ID INT,
FOREIGN KEY (MANAGER_ID)
REFERENCES EMPLOYEE (EMPLOYEE_ID)
ON DELETE CASCADE
);

insert into employee (
employee_id,
first_name,
last_name,
manager_id
)
values
(1, 'Windy', 'Hays', null),
(2, 'Ava', 'Christensen',1),
(3, 'Hassan', 'Conner', 1),
(4, 'Anna', 'Reeves', 2),
(5, 'Sau', 'Norman', 2),
(6, 'Kelsie', 'Hays', 3),
(7, 'Tory', 'Goff', 3),
(8, 'Salley', 'Lester', 3)
;

select * from employee;


select 
e.first_name || ' ' || e.last_name employee,
m.first_name || ' ' || m.last_name manager
from
employee e 
inner join employee m 
on m.employee_id = e.manager_id	
order by manager;
--각 직원의 상위 관리자를 출력함
--최고 관리자인 'Windy Hays'는 결과 집합에 포함되지 않음


select 
e.first_name || ' ' || e.last_name employee,
m.first_name || ' ' || m.last_name manager
from
employee e 
left join employee m 
on m.employee_id = e.manager_id
order by manager;
--각 직원의 상위 관리자를 출력
--최고 관리자인 'Windy Hays'가 결과 집합에 포함


select * from film;

select 
	f1.title, 
	f2.title, 
	f1.length
from film f1
inner join film f2
on f1.title <> f2.title 
and f1.length = f2.length;



--05 full outer 조인
select
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
from
	BASKET_A A
full outer join BASKET_B B on
	A.FRUIT = B.FRUIT;
	

select
	A.ID ID_A,
	A.FRUIT FRUIT_A,
	B.ID ID_B,
	B.FRUIT FRUIT_B
FROM
	BASKET_A A 
FULL OUTER JOIN BASKET_B B ON
	A.FRUIT = B.FRUIT 
WHERE A.ID IS NULL  --right outer
   OR B.ID IS NULL; --left outer
   
   
   
   
 
create table
if not exists departments
(
 department_id serial primary key,
 department_name varchar (255) not null
 );

drop table employees;

create table
if not exists employees
(
 employee_id serial primary key,
 employee_name varchar (255),
 department_id integer
 );

insert into departments (department_name)
values
('Sales'),
('Marketing'),
('HR'),
('IT'),
('Production')
;

insert into employees (
employee_name,
department_id)
values
('Bette Nicholson', 1),
('Christian Gable', 1),
('Joe Swank', 2),
('Fred Coster', 3),
('Sandra Kilmer', 4),
('Julia Mcqueen', null)
; 

select * from departments ;
select * from employees ;


select
	e.employee_name,
	d.department_name
from
	employees e
full outer join departments d on
	d.department_id = e.department_id ;



select
	e.employee_name,
	d.department_name
from 
	employees e
full outer join departments d on
	d.department_id = e.department_id
where
	e.employee_name is null; --소속된 직원이 없는 부서
--full outer + right only

select
	e.employee_name,
	d.department_name
from 
	employees e 
right join departments d on
	d.department_id = e.department_id
where 
	e.employee_name is null ;
--right outer + right only


select
	e.employee_name,
	d.department_name
from 
	employees e
full outer join departments d on
	d.department_id = e.department_id
where
	d.department_id is null; --소속된 부서가 없는 직원
--full outer + left only
	
	
select
	e.employee_name,
	d.department_name
from 
	employees e
left outer join departments d on
	d.department_id = e.department_id
where
	d.department_id is null; --소속된 부서가 없는 직원
--left outer + left only
	
	
	
--06 cross 조인
create table cross_t1
(
 label char(1) primary key);
 
create table cross_t2
(
 score int primary key);
 
insert into cross_t1 (label)
values
('A'),
('B');

insert into cross_t2 (score)
values
(1),
(2),
(3);

select * from cross_t1 
cross join cross_t2 
order by label;

select * 
from cross_t1 , cross_t2
order by label ;

select label, 
	case when label = 'A' then sum(score)
		 when label = 'B' then sum(score) * -1
		 else 0
		 end as calc
from cross_t1 
cross join cross_t2 
group by label 
order by label 
;




--07 natural 조인
create table categories
(
 category_id serial primary key,
 category_name varchar (255) not null
 );
 
create table products
(
 product_id serial primary key,
 product_name varchar (255) not null,
 category_id int not null,
 foreign key (category_id)
 references categories (category_id)
 );
 
insert into categories 
 (category_name)
values 
 ('Smart Phone'),
 ('Laptop'),
 ('Tablet')
;

insert into products
 (product_name, category_id)
values 
 ('iPhone', 1),
 ('Samsung Galaxy', 1),
 ('HP Elite', 2),
 ('Lenovo Thinkpad', 2),
 ('iPad', 3),
 ('Kindle Fire', 3)
 ;
 
select * from categories;
select * from products;

select * from products a 
natural join categories b;
--natural 조인은 inner 조인의 또 다른 sql 작성 방식
--조인 칼럼을 명시하지 않아도 됨
--자동으로 조인되기 때문에 안정성이 낮아 실무에서 잘 사용하진 않음

select 
	a.category_id,
	a.product_id,
	a.product_name,
	b.category_name
from 
	products a 
inner join 
	categories b 
 on a.category_id = b.category_id
;

select 
	a.category_id,
	a.product_id,
	a.product_name,
	b.category_name
from 
	products a, 
	categories b 
where
	a.category_id = b.category_id
;


select * from city;
select * from country;

select * from city a 
natural join country b;
--두 테이블 간에 동일한 이름으로 존재하는 컬럼이 country_id와 last_update이다
--이런 경우 natural join시에는 last_update 컬럼까지 inner join에 성공해야만 결과값이 나옴

select * from city a 
inner join country b 
on a.country_id = b.country_id;




--08 group by절
select * from payment;

select 
	customer_id
from
	payment
group by
	customer_id ;
	

select 
	distinct customer_id
from payment;

--거래액이 가장 많은 고객순으로 출력
select 
	customer_id,
	sum (amount) as amount_sum
from payment 
group by customer_id 
order by sum (amount) desc;

select 
	customer_id,
	sum (amount) as amount_sum
from payment 
group by customer_id 
order by amount_sum desc;

select * from customer
where customer_id = 148;



select 
	staff_id,
	count(payment_id) as count
from payment
group by staff_id ;

select * from staff
where staff_id = 1;

select 
	a.staff_id,
	b.staff_id ,
	b.first_name ,
	b.last_name ,
	count(a.payment_id) as count
from payment a, staff b
where a.staff_id = b.staff_id 
group by
	a.staff_id,
	b.staff_id ,
	b.first_name ,
	b.last_name ;
	


--09 Having절

select 
	customer_id,
	sum (amount) as amount_sum
from payment 
group by customer_id 
having sum (amount) > 200;


select 
	a.customer_id,
	b.email, 
	sum (a.amount) as amount_sum
from 
	payment a,
	customer b
where 
	a.customer_id = b.customer_id 
group by 
	a.customer_id,
	b.email 
having 
	sum (a.amount) > 200;
	

select 
	store_id,
	count(customer_id) as count
from customer
group by store_id;

select 
	store_id,
	count(customer_id) as count
from customer
group by store_id
having count(customer_id) > 300;




--10 grouping set절
create table sales	
(
 brand varchar not null,
 segment varchar not null,
 quantity int not null,
 primary key (brand, segment)
 )
;

insert into sales (brand, segment, quantity)
values 
	('ABC', 'Premium', 100),
	('ABC', 'Basic', 200),
	('XYZ', 'Premium', 100),
	('XYZ', 'Basic', 300);
	
select * from sales;

select 
	brand,
	segment,
	sum (quantity)
from sales
group by
	brand,
	segment ;	
	
select 
	brand,
	sum (quantity)
from sales
group by brand ;

select 
	segment,
	sum (quantity)
from sales
group by segment ;

select sum (quantity)
from sales ;

--동일한 테이블을 4번이나 읽음으로써 성능저하 가능성 있음
--sql문이 너무 길어져 유지보수가 용이하지 않음
select 
	brand,
	segment,
	sum (quantity)
from sales 
group by
	brand,
	segment
union all
select 
	brand,
	null,
	sum (quantity)
from sales 
group by
	brand
union all
select 
	null,
	segment,
	sum (quantity)
from sales 
group by
	segment
union all 
select 
	null,
	null,
	sum (quantity)
from sales 
;


select 
	brand,
	segment,
	sum (quantity)
from sales 
group by 
grouping sets (
	(brand, segment),
	(brand),
	(segment),
	()
);


--grouping : 해당 칼럼이 집계에 사용되었으면 0, 사용되지 않았으면 1을 리턴
select
	grouping(brand) grouping_brand,
	grouping(segment) groping_segment,
	brand,
	segment,
	sum (quantity)
from sales 
group by 
grouping sets (
	(brand, segment),
	(brand),
	(segment),
	()
)
order by brand, segment;


select
	case when grouping(brand) = 0 and grouping(segment) = 0 then '브랜드별+등급별'
		 when grouping(brand) = 0 and grouping(segment) = 1 then '브랜드별'
		 when grouping(brand) = 1 and grouping(segment) = 0 then '등급별'
		 when grouping(brand) = 1 and grouping(segment) = 1 then '전체합계'
		 else ''
		 end as "집계기준",
	brand,
	segment,
	sum (quantity)
from sales 
group by 
grouping sets (
	(brand, segment),
	(brand),
	(segment),
	()
)
order by brand, segment;




--11 roll up절

select * from sales;

select 
	segment,
	sum (quantity)
from sales 
group by segment;

select 
	segment,
	sum (quantity)
from sales 
group by
	rollup (segment)
order by segment;


select 
	brand,
	segment,
	sum (quantity)
from sales 
group by brand, segment
order by brand, segment;

select 
	brand,
	segment,
	sum (quantity)
from sales 
group by
	 rollup (brand, segment)
order by
	brand, segment;

select 
	segment,
	brand,
	sum (quantity)
from sales 
group by
	 rollup (segment, brand)
order by
	segment, brand;

select
	segment,
	brand,
	sum (quantity)
from sales
group by segment,
  rollup (brand)
order by 
	segment, brand;
--부분 roll up시 전체 합계는 구하지 않는다

select 
	brand,
	segment,
	sum (quantity)
from sales 
group by brand,
	 rollup (segment)
order by
	brand, segment;




--12 cube절
select * from sales;

select 
	brand,
	segment,
	sum (quantity)
from sales
group by
	cube (brand, segment)
order by brand, segment;

select 
	brand,
	segment,
	sum (quantity)
from sales
group by
	rollup (brand, segment)
order by brand, segment;


select 
	brand,
	segment,
	sum (quantity)
from sales 
group by brand,
	cube (segment)
order by brand, segment;




--13 분석함수
drop table product_group ;

create table product_group 
( 
 group_id serial primary key,
 group_name varchar (255) not null
 );
 
drop table product;

create table product
(
 product_id serial primary key,
 product_name varchar (255) not null,
 price decimal (11, 2),
 group_id int not null,
 foreign key (group_id)
 references product_group (group_id)
 );
 
insert into product_group (group_name)
values 
 ('Smartphone'),
 ('Laptop'),
 ('Tablet')
 ;
 
insert into product
 (product_name, group_id, price)
values
 ('Microsoft Lumia', 1, 200),
 ('HTC One', 1, 400),
 ('Nexus', 1, 500),
 ('iPhone', 1, 900),
 ('HP Elite', 2, 1200),
 ('Lenovo Thinkpad', 2, 700),
 ('Sony VAIO', 2, 700),
 ('Dell Vostro', 2, 800),
 ('iPad', 3, 700),
 ('Kindle Fire', 3, 150),
 ('Samsung Galaxy Tab', 3, 200)
 ;
 
select * from product_group ;
select * from product;


select count(*)
from product;

select 
	count(*) over(), A.*
from 
	product A;
	

--14 avg함수
select * from product_group;
select * from product;

select 
	avg (price)
from product;

select 	
	b.group_name,
	avg (a.price)
from 
	product a 
inner join 
	product_group b 
 on (a.group_id = b.group_id)
group by
	b.group_name;



select 
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over(partition by b.group_name)
from 
	product a 
inner join
	product_group b
 on (a.group_id = b.group_id);
 


select 
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over(partition by b.group_name order by b.group_name)
from 
	product a 
inner join
	product_group b
 on (a.group_id = b.group_id);
 


select 
	a.product_name,
	a.price,
	b.group_name,
	avg(a.price) over(partition by b.group_name order by a.price) --누적집계
from 
	product a 
inner join
	product_group b
 on (a.group_id = b.group_id);



--15 row_number, rank, dense_rank
select * from product_group ;
select * from product;


select 
	a.product_name,
	b.group_name,
	a.price,
	row_number () over (partition by b.group_name order by a.price desc) 
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 

select 
	a.product_name,
	b.group_name,
	a.price,
	rank () over (partition by b.group_name order by a.price)
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 

select 
	a.product_name,
	b.group_name,
	a.price,
	dense_rank () over (partition by b.group_name order by a.price)
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 


--16 first_value, last_value
select * from product_group ;
select * from product;

select 
	a.product_name,
	b.group_name,
	a.price,
	first_value (a.price) 
		over (partition by b.group_name order by a.price) 
		as lowest_price_per_group
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 

select 
	a.product_name,
	b.group_name,
	a.price,
	last_value (a.price) 
		over (partition by b.group_name order by a.price 
			  range between unbounded preceding
			  and unbounded following)
		as highest_price_per_group
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 

--17 Lag, Lead
select * from product_group ;
select * from product;

select 
	a.product_name,
	b.group_name,
	a.price,
	lag (a.price, 1) 
		over (partition by b.group_name order by a.price) 
		as prev_price,
	a.price - lag (a.price, 1) 
		over (partition by b.group_name order by a.price) 
		as cur_prev_diff
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 

select 
	a.product_name,
	b.group_name,
	a.price,
	lead (a.price, 1) 
		over (partition by b.group_name order by a.price) 
		as next_price,
	a.price - lead (a.price, 1) 
		over (partition by b.group_name order by a.price) 
		as cur_next_diff
from product a 
inner join product_group b 
 on (a.group_id = b.group_id);
 


--18 실전문제1
--rental 테이블을 이용하여 연,연월,연월일,전체 각각의 기준으로 rental_id 기준 렌탈이 일어난 횟수 출력 (전체 데이터 기준으로 모든 행을 출력)

select * from rental;
	
select
	to_char(rental_date, 'yyyy'),
	count(*)
from rental 
group by to_char(rental_date, 'yyyy'); 

select
	to_char(rental_date, 'yyyymm'),
	count(*)
from rental 
group by to_char(rental_date, 'yyyymm')
order by to_char(rental_date, 'yyyymm');

select
	to_char(rental_date, 'yyyymmdd'),
	count(*)
from rental 
group by to_char(rental_date, 'yyyymmdd')
order by to_char(rental_date, 'yyyymmdd');

select count(*)
from rental ;

--roll up 활용

select 
 	to_char(rental_date, 'yyyy'),
 	to_char(rental_date, 'mm'),
 	to_char(rental_date, 'dd'),
 	count(*)
from rental 
group by
 rollup(
 	to_char(rental_date, 'yyyy'),
 	to_char(rental_date, 'mm'),
 	to_char(rental_date, 'dd')
 	); 
 	
 
 --19 실습문제2
 --rental과 customer 테이블을 이용하여 현재까지 가장 많이 rental을 한 고객의 고객id, 렌탈순위, 누적렌탈회수, 이름을 출력하라
 --나는 짱이다
  
select * from rental;
select * from customer;
 
 
 select 
 	a.customer_id as customer_id,
  	rank () over(order by count(a.customer_id)desc ) as rental_rank,
 	count(a.rental_id) as rental_count, 
 	b.first_name,
 	b.last_name 
 from rental a 
 inner join customer b 
 on (a.customer_id = b.customer_id)
 group by
 	a.customer_id,
	b.first_name,
 	b.last_name
 limit 1
 ;
 
