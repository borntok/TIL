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
 ALIAS -> �ڵ��� ������ -> sql ���ɿ� ����

 
 
--�������� ����
 select
	first_name,
	last_name
from
	customer
order by
	first_name asc;


--�������� ����
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
--drop table: table ���� 

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
--distinct: bcolor ��½� �ߺ��� �� ����
--order by: �ߺ� ���ŵ� �÷��� �������� ����


select 
	distinct bcolor, fcolor
from t1
order by bcolor, fcolor;
--distinct: bcolor+fcolor ��½� �ߺ��� �� ����
--order by: �ߺ� ���ŵ� �÷��� �������� ����


select  
	distinct on (bcolor)bcolor, fcolor
from t1
order by bcolor, fcolor; 
--distinct on: bcolor ���� �ߺ� ������, fcolor ���� �� �� ���� ���� ������


select
    distinct on (bcolor)bcolor, fcolor
from t1
order by bcolor, fcolor desc;
--desc: fcolor�÷� ���� ������ �� �������� ����




select last_name, first_name
from customer
where first_name = 'Jamie';
--first_name�� Jamie�� ���� ���



select
	last_name,
	first_name
from
	customer
where
	first_name = 'Jamie'
and last_name = 'Rice';
--first_name�� Jamie�̸鼭 last_name�� Rice�� ���� ���



select
	customer_id,
	amount,
	payment_date
from
	payment
where
	amount <= 1
 or amount >= 8;
--aomount�� 1���� �Ǵ� 8�̻� �� ���



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
--film_id�� ����, ���� �� �߿��� ��� �Ǽ��� 5������ ����



select
	film_id,
	title,
	release_year
from
	film
order by
	film_id
limit 4 offset 3;
--film_id�� ����, ������ �� �߿��� ��� �Ǽ��� 4������ ����
--film_id�� ������ �� �߿��� ������� ���� ��ġ�� 3
--(���� ��ġ 3�� 0,1,2,3 �� 4��° ����� ����)


select
	film_id,
	title,
	rental_rate
from
	film
order by
	rental_rate desc
limit 10;
--remtal_rate�� ������������ ����
--������ ���� 10�Ǹ� ���


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
--title�� ������ �����߿��� ���ʷ� �� �� ���� ���� ����


select
	film_id,
	title
from
	film
order by
	title 
offset 5 rows
fetch first 5 row only;
--title�� ������ ���� �߿��� 6��° ����� 5���� ���� ����




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
--customer_id�� 1�Ǵ� 2�� ���� ���
--�� ����� return_date ������������ ���

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
--customer_id�� 1�Ǵ� 2�� ���� ���
--�� ����� return_date ������������ ���
--IN �����ڴ� 'OR' && '='�� ����
--��Ƽ�������� Ư���� IN ������ ���ɻ� ����, �������� �� ����


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
--customer_id�� 1�Ǵ� 2�� �ƴ�(1�� 2�� ������ ������ ����) ���� ���
--�� ����� return_date ������������ ���

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
--NOT IN �����ڴ� 'AND'&&'<>'�� ����



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
--return_date�� 2005-05-27�� customer_id�� first_name, last_name�� ���

	
	
	
select * from payment ;


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount between 8 and 9;
--aomont�� 8�� 9 ������ ������ ���


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount >= 8
and amount <= 9 ;
--BETWEEN �����ڿ� ������� ����


select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount not between 8 and 9;
--amount�� 8�� 9 ���̰� �ƴ� ��� ���� ���

select
	customer_id,
	payment_id,
	amount
from
	payment
where
	amount < 8
 or amount > 9;
 --NOT BETWEEN �����ڿ� ��°��� ����


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
--payment_date�� 2007�� 2�� 7�Ϻ��� 2007�� 2�� 15�ϱ����� �����͸� ���


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
--�� SQL�� ������� ����


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
--firts_name�� 'Jen'���� �����ϴ� ���� ���


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
--first_name�� 'er'�� �����ϴ� ��� ������ ���


select
	first_name,
	last_name
from
	customer
where
	first_name like '_her%';
--ù���� ���ڰ� ��� ���ڷ� ���� ���������� �� ������ 'her'�̾�� �ϰ� �� �������� � ���� Ȥ�� ���ڿ��̾ ������� ������ ���


select
	first_name,
	last_name
from
	customer
where
	first_name not like 'Jen%';
--first_name�� 'Jen'���� �������� �ʴ� ������ ���

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
--������


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





--�ǽ�1
--payment ���̺��� ���� �ŷ��� amount�� �׼��� ���� ���� ������ customer_id�� �����϶�
--��, customer_id�� ���� �����ؾ� �Ѵ�

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

--�ǽ�1 ����Ǯ��

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
                

                
                
--�ǽ�2
--���鿡�� ��ü �̸����� �����ϰ��� �Ѵ�
--customer ���̺��� ���� email �ּҸ� �����ϰ�, �̸��� ���Ŀ� ���� �ʴ� �̸��� �ּҴ� ���ܽ��Ѷ�.
--(�̸��� ������ '@'�� �����ؾ� �ϰ� '@'�� �������� �ʰ� '@'�� �������� �ʾƾ� �Ѵ�.)

                
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
	