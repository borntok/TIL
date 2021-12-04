select * from customer;

select
	first_name,
	last_name,
	email
from
	customer;

select
	A.first_name,
	A.last_name,
	A.email
from
	customer A;
 ALIAS -> 코드의 가독성 -> sql 성능에 영향

 
 
--오름차순 정렬
 select
	first_name,
	last_name
from
	customer
order by
	first_name asc;


--내림차순 정렬
 select
	first_name,
	last_name
from
	customer
order by
	first_name desc;

select
	first_name,
	last_name
from
	customer
order by
	first_name asc,
	last_name desc;
         
select
	first_name,
	last_name
from
	customer
order by
	1 asc,
	2 desc;
         
        
        

drop table T1;  
--drop table: table 삭제 

create table T1(ID serial not null primary key, bcolor varchar, fcolor varchar);
insert
 into T1(bcolor, fcolor)
values
	('red','red'),
	('red','red'),
	('red', null),
	(null, 'red'),
	('red','green'),
	('red','blue'),
	('green','red'),
	('green','blue'),
	('green','green'),
	('blue','red'),
	('blue','green'),
	('blue','blue')
	;

commit;

select * from T1;


select 
	distinct bcolor
from t1
order by bcolor;
--distinct: bcolor 출력시 중복된 행 제거
--order by: 중복 제거된 컬럼값 기준으로 정렬


select 
	distinct bcolor, fcolor
from t1
order by bcolor, fcolor;
--distinct: bcolor+fcolor 출력시 중복된 행 제거
--order by: 중복 제거된 컬럼값 기준으로 정렬


select  
	distinct on (bcolor)bcolor, fcolor
from t1
order by bcolor, fcolor; 
--distinct on: bcolor 기준 중복 제거함, fcolor 값은 단 한 개의 값만 보여줌


select
    distinct on (bcolor)bcolor, fcolor
from t1
order by bcolor, fcolor desc;
--desc: fcolor컬럼 값을 보여줄 때 내림차순 정렬




select last_name, first_name
from customer
where first_name = 'Jamie';
--first_name이 Jamie인 행을 출력



select
	last_name,
	first_name
from
	customer
where
	first_name = 'Jamie'
and last_name = 'Rice';
--first_name이 Jamie이면서 last_name이 Rice인 행을 출력



select
	customer_id,
	amount,
	payment_date
from
	payment
where
	amount <= 1
 or amount >= 8;
--aomount가 1이하 또는 8이상 행 출력



select * from film;

select
	film_id,
	title,
	release_year
from
	film
order by
	film_id
limit 5;
--film_id로 정렬, 정렬 값 중에서 결과 건수는 5건으로 제한



select
	film_id,
	title,
	release_year
from
	film
order by
	film_id
limit 4 offset 3;
--film_id로 정렬, 정렬한 값 중에서 결과 건수는 4건으로 제한
--film_id로 정렬한 값 중에서 출력행의 시작 위치는 3
--(시작 위치 3은 0,1,2,3 즉 4번째 행부터 시작)


select
	film_id,
	title,
	rental_rate
from
	film
order by
	rental_rate desc
limit 10;
--remtal_rate를 내림차순으로 정렬
--정렬한 값중 10건만 출력


select
	film_id,
	title,
	rental_rate
from
	film
order by
	film_id asc
limit 10 offset 5;




select
	film_id,
	title
from
	film
order by
	title 
fetch first row only;
--title로 정렬한 집합중에서 최초로 단 한 건의 행을 리턴


select
	film_id,
	title
from
	film
order by
	title 
offset 5 rows
fetch first 5 row only;
--title로 정렬한 집합 중에서 6번째 행부터 5건의 행을 리턴




select * from rental;

select
	customer_id,
	rental_id,
	return_date
from
	rental
where
	customer_id in (1, 2)
order by
	return_date desc;
--customer_id가 1또는 2인 행을 출력
--그 결과를 return_date 내림차순으로 출력

select
	customer_id,
	rental_id,
	return_date
from
	rental
where
	customer_id = 1
 or customer_id = 2
order by
	return_date desc;
--customer_id가 1또는 2인 행을 출력
--그 결과를 return_date 내림차순으로 출력
--IN 연산자는 'OR' && '='와 같음
--옵티마이저의 특성상 IN 조건이 성능상 유리, 가독성이 더 좋음


select
	customer_id,
	rental_id,
	return_date
from
	rental
where
	customer_id not in (1, 2)
order by
	return_date desc;
--customer_id가 1또는 2가 아닌(1과 2를 제외한 나머지 전부) 행을 출력
--그 결과를 return_date 내림차순으로 출력

select
	customer_id,
	rental_id,
	return_date
from
	rental
where
	customer_id <> 1
and customer_id <> 2
order by
	return_date desc;
--NOT IN 연산자는 'AND'&&'<>'와 같음



select
	customer_id
from
	rental
where
	cast (return_date as date)= '2005-05-27';


select
	first_name,
	last_name
from
	customer
where customer_id in (
	select
		customer_id
	from
		rental
	where
		cast(return_date as date)= '2005-05-27');
--return_date가 2005-05-27인 customer_id의 first_name, last_name을 출력

	
	
	
select * from payment ;


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount between 8 and 9;
--aomont가 8과 9 사이인 집합을 출력


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount >= 8
and amount <= 9 ;
--BETWEEN 연산자와 결과값이 같음


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount not between 8 and 9;
--amount가 8과 9 사이가 아닌 모든 값을 출력

select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount < 8
 or amount > 9;
 --NOT BETWEEN 연산자와 출력값이 같음


select
	customer_id,
	payment_id,
	amount,
	payment_date
from
	payment
where
	cast(payment_date as date) 
between '2007-02-07' and '2007-02-15';
--payment_date가 2007년 2월 7일부터 2007년 2월 15일까지인 데이터를 출력


select
	customer_id,
	payment_id,
	amount,
	payment_date
from
	payment
where
	to_char(payment_date, 'YYYY-MM-DD')
between '2007-02-07' and '2007-02-15';
--위 SQL과 결과값이 동일


select
	customer_id,
	payment_id,
	amount,
	payment_date,
	cast(payment_date as date),
	to_char(payment_date, 'yyyy-mm-dd') 
from
	payment
where
	to_char(payment_date, 'YYYY-MM-DD')
between '2007-02-07' and '2007-02-15';



 
select
	first_name,
	last_name
from
	customer
where
	first_name like 'Jen%';
--firts_name이 'Jen'으로 시작하는 집합 출력


select 
'JYR' like 'JYR',
'JYR' like 'J%',
'JYR' like '_Y_',
'JYR' like 'J_';


select
	first_name,
	last_name
from
	customer
where
	first_name like '%er%';
--first_name에 'er'이 존재하는 모든 데이터 출력


select
	first_name,
	last_name
from
	customer
where
	first_name like '_her%';
--첫번쨰 문자가 어떠한 문자로 시작 가능하지만 그 다음이 'her'이어야 하고 그 다음에는 어떤 문자 혹은 문자열이어도 상관없는 데이터 출력


select
	first_name,
	last_name
from
	customer
where
	first_name not like 'Jen%';
--first_name이 'Jen'으로 시작하지 않는 데이터 출력

drop table contacts;

create table contacts 
( 
 ID int generated by default as identity,
 first_name varchar(50) not null,
 last_name varchar(50) not null,
 email varchar(255) not null,
 phone varchar(15),
 primary key(ID) 
 );

insert 
 into 
  contacts(first_name,last_name,email,phone)
values
 ('John','Doe','john.doe@example.com',null),
 ('Lily','Bush','lily.bush@example.com','(408-234-2764')
;

commit;

select * from contacts;

select
	id,
	first_name,
	last_name,
	email,
	phone
from
	contacts
where
	phone = null;
--공집합


select
	id,
	first_name,
	last_name,
	email,
	phone
from
	contacts
where
	phone is null;
	

select
	id,
	first_name,
	last_name,
	email,
	phone
from
	contacts
where
	phone is not null;





--실습1
--payment 테이블에서 단일 거래의 amount의 액수가 가장 많은 고객들의 customer_id를 추출하라
--단, customer_id의 값은 유일해야 한다

select * from payment;

select amount
from payment
order by amount desc;

select  
	distinct customer_id, amount 
from payment
where amount >= 11;

select  
	distinct customer_id 
from payment
where amount >= 11;	

--실습1 문제풀이

select 
	distinct customer_id
from payment
where amount in (
                 select amount
                 from payment
                 order by amount desc
                 limit 1
                 );
                 
                 
SELECT 
	DISTINCT A.CUSTOMER_ID
FROM PAYMENT A 
WHERE A.AMOUNT = (
                 SELECT K.AMOUNT
                 FROM PAYMENT K
                 ORDER BY K.AMOUNT DESC
                 FETCH FIRST 1 ROW ONLY
                 );
                

                
                
--실습2
--고객들에게 단체 이메일을 전송하고자 한다
--customer 테이블에서 고객의 email 주소를 추출하고, 이메일 형식에 맞지 않는 이메일 주소는 제외시켜라.
--(이메일 형식은 '@'가 존재해야 하고 '@'로 시작하지 않고 '@'로 끝나지도 않아야 한다.)

                
select * from customer;


select
	email
from
	customer
where
	    email     like '%@%'
	and email not like '@%'
	and email not like '%@'
	;
	