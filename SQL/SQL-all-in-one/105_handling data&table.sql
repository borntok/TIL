-----01 insert 문


create table LINK (
ID serial primary key,
URL varchar (255) not null,
NAME varchar (255) not null,
DESCRIPTION varchar (255),
REL varchar (50));

insert
 into link 
 (url, name)
values 
 ('http://naver.com', 'Naver')
;

commit;

select * from link ;

insert 
 into link 
 (url, name)
values
 ('''http://naver.com''', '''Naver''')
 ;
 commit;
 
select * from link ;

insert 
 into link 
 (url, name)
values
 ('http://www.google.com', 'Google'),
 ('http://www.yahoo.com', 'Yahoo'),
 ('http://www.bing.com', 'Bing')
 ;
 commit;
 
select * from link ;



create table link_tmp as
select * from link where 0=1;

insert 
 into link_tmp
select *
 from link
;
commit;

select * from link_tmp ;

select * from link 
except
select * from link_tmp ;



-------02 update문


alter table link add column last_update date;
alter table link alter column last_update set default current_date ;

select * from link;	

update link 
  set last_update = default 
 where
	  last_update is null ;
commit;

update link 
   set rel = 'NO DATA';
commit;

update link 
   set description = name ;
commit;

select * from link;	





--------03 update join문

create table product_segment
(
 ID serial primary key,
 segment varchar not null,
 discount numeric (4, 2)
 );
 
insert into product_segment 
 (segment, discount)
values 
	('Grand Luxury', 0.05),
	('Luxury', 0.06),
	('Mass', 0.1);

commit;

drop table product ;

create table product
(
 ID serial primary key,
 name varchar not null,
 price numeric(10, 2),
 net_price numeric(10, 2),
 segment_id int not null,
 foreign key(segment_id)
 references product_segment(id)
);

insert into product (name, price, segment_id)
values 
	('K5', 804.89, 1),
	('K7', 228.55, 3),
	('K9', 366.45, 2),
	('SONATA', 145.33, 3),
	('SPARK', 551.77, 2),
	('AVANTE', 261.58, 3),
	('LOZTE', 519.62, 2),
	('SANTAFE', 843.31, 1),
	('TUSON', 254.18, 3),
	('TRAX', 427.78, 2),
	('ORANDO', 936.29, 1),
	('RAY', 910.34, 1),
	('MORNING', 208.33, 3),
	('VERNA', 985.45, 1),
	('K8', 841.26, 1),
	('TICO', 896.38, 1),
	('MATIZ', 575.74, 2),
	('SPORTAGE', 530.64, 2),
	('ACCENT', 892.43, 1),
	('TOSCA', 161.71, 3);

commit;

select * from product_segment ;  
select * from product;


update product a
   set net_price = a.price - (a.price * b.discount)
  from product_segment b 
 where a.segment_id = b.id;
 
select * from product;





----------04 delete문


select * from link;

delete 
  from link
 where id = 5;
 
commit;


select * from link;
select * from link_tmp ;

delete from
	link_tmp a 
using link b
where a.id = b.id;

commit;

delete from link;
commit;
delete from link_tmp ;
commit;

select count(*) from link;
select count(*) from link_tmp ;





-----------05 upsert문


create table customers 
(
 customer_id serial primary key,
 name varchar unique,
 email varchar not null,
 active bool not null default true
);

insert into customers (name, email)
values
 ('IBM', 'contact@ibm.com'),
 ('Microsoft', 'contact@microsoft.com'),
 ('Intel', 'contact@intel.com');
 
commit;

select * from customers;


insert into customers (name, email)
values 
 ('Microsoft', 'hotline@microsoft.com')
on conflict (name)
do nothing;

commit;

select * from customers;


insert into customers (name, email)
values 
 ('Microsoft', 'hotline@microsoft.com')
on conflict (name)
do update 
   set email = excluded.email ||
                          ';' ||
              customers.email
              ;
             
commit;

select * from customers;






-------------06 export 작업 (테이블의 데이터를 다른 형태의 데이터로 추출)


select * from category ;

copy category (category_id, name, last_update)
to 'C:\tmp\DB_CATEGORY.csv'
delimiter ','
csv header;

copy category (category_id, name, last_update)
to 'C:\tmp\DB_CATEGORY.txt'
delimiter '|'
csv header;

copy category (category_id, name, last_update)
to 'C:\tmp\DB_CATEGORY_2.csv'
delimiter ','
csv;




-------------07 import 작업


create table category_import
(
 category_id serial not null,
 "name" varchar(25) not null,
 last_update timestamp not null default now(),
 constraint category_import_pkey primary key (category_id)
);

select * from category_import;

copy category_import (category_id, name, last_update)
from 'C:\tmp\DB_CATEGORY.csv'
delimiter ','
csv header;

commit;

select * from category_import;


delete from category_import;

copy category_import (category_id, name, last_update)
from 'C:\tmp\DB_CATEGORY.txt'
delimiter '|'
csv header;

select * from category_import;


delete from category_import;

copy category_import (category_id, name, last_update)
from 'C:\tmp\DB_CATEGORY_2.csv'
delimiter ','
csv;

select * from category_import;





----------08 데이터 타입

