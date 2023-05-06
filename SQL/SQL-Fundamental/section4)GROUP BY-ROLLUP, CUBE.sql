/**********************
	group by rollup
***********************/

-- deptno + job ���� �ܿ� dept�� ��ü job ����(�ᱹ dept ����), ��ü Aggregation ����
select deptno, job, sum(sal)
from emp 
group by rollup(deptno, job)
order by 1, 2;


-- ��ǰ ī�װ� + ��ǰ�� ������ ���ϱ�
select c.category_name, b.product_name, sum(a.amount)
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c
  on b.category_id = c.category_id 
group by c.category_name, b.product_name
order by 1,2;

-- ��ǰ ī�װ� + ��ǰ�� ������ ���ϵ�, ��ǰ ī�װ� �� �Ұ� ������ �� ��ü ��ǰ�� �������� �Բ� ���ϱ�
select c.category_name, b.product_name, sum(a.amount)
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c
  on b.category_id = c.category_id 
group by rollup(c.category_name, b.product_name)
order by 1,2;


-- ��,��,�Ϻ� ������ ���ϱ�
-- �� �Ǵ� ���� 01, 02�� ���� ���·� ǥ���Ϸ��� to_char()�Լ�, 1, 2�� ���� ���ڷ� ǥ���Ϸ��� date_part()�Լ� ���
select to_char(a.order_date, 'yyyy') as year,
	   to_char(a.order_date, 'mm') as month,
	   to_char(a.order_date, 'dd') as day,
	   sum(b.amount)
from orders a
join order_items b
  on a.order_id = b.order_id 
group by 1, 2, 3
order by 1, 2, 3;

-- ��+��+�Ϻ� ������ ���ϵ�, ���� �Ұ� ������, �⺰ ������, ��ü �������� �Բ� ���ϱ�
with temp_01 as
(
 select to_char(a.order_date, 'yyyy') as year,
 	    to_char(a.order_date, 'mm') as month,
	    to_char(a.order_date, 'dd') as day,
	    sum(b.amount) as sum_amount
 from orders a
 join order_items b
   on a.order_id = b.order_id 
 group by rollup(1, 2, 3)
 order by 1, 2, 3
)
select case when year is null then '�Ѹ���' else year end as year
	 , case when year is null then null
	     else case when month is null then '�� �Ѹ���' else month end 
	   end as month 
	 , case when year is null or month is null then null 
	 	 else case when day is null then '�� �Ѹ���' else day end
	   end as day
	 , sum_amount
from temp_01
order by year, month, day ;



/********************
	group by cube 
*********************/

--deptno, job�� ������ �������� Group by ����
select deptno, job, sum(sal)
from emp
group by cube(1, 2)
order by 1, 2;


-- ��ǰī�װ� + ��ǰ�� + �ֹ�ó�������� ����
select c.category_name, b.product_name, 
	   e.first_name||' '||e.last_name as employee,
	   sum(a.amount) 
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c 
  on b.category_id = c.category_id 
join orders d
  on a.order_id = d.order_id 
join employees e
  on d.employee_id = e.employee_id 
group by 1, 2, 3
order by 1, 2, 3;

-- ��ǰī�װ�, ��ǰ��, �ֹ�ó�������� ������ �������� Group by ����
select c.category_name, b.product_name, 
	   e.first_name||' '||e.last_name as employee,
	   sum(a.amount) 
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c 
  on b.category_id = c.category_id 
join orders d
  on a.order_id = d.order_id 
join employees e
  on d.employee_id = e.employee_id 
group by cube(1, 2, 3)
order by 1, 2, 3;