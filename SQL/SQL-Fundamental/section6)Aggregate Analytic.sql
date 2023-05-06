-- order_items ���̺��� order_id�� amount ���ձ��� ǥ��
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over(partition by order_id) as total_amount
from order_items;

-- order_items ���̺��� order_id�� line_prod_seq������ ���� amount �ձ��� ǥ��
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over(partition by order_id order by line_prod_seq /* rows between unbounded preceding and current row */) as total_amount
from order_items;

-- order_items ���̺��� order_id�� line_prod_seq������ ���� amount �� - partition �Ǵ� order by ���� ���� ��� windows ��ü
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over() as total_amount
from order_items
where order_id between 10248 and 10250;

-- order_items ���̺��� order_id�� ��ǰ �ִ� ���űݾ�, order_id�� ��ǰ ���� �ִ� ���űݾ�
select order_id, line_prod_seq, product_id, amount
	 , max(amount) over(partition by order_id) as max_amount
	 , max(amount) over(partition by order_id order by line_prod_seq) as cum_max_amount
from order_items;

-- order_items ���̺��� order_id�� ��ǰ �ּ� ���űݾ�, order_id�� ��ǰ ���� �ּ� ���űݾ�
select order_id, line_prod_seq, product_id, amount
	 , min(amount) over(partition by order_id) as min_amount
	 , min(amount) over(partition by order_id order by line_prod_seq) as cum_min_amount
from order_items;

-- order_items ���̺��� order_id�� ��ǰ ��� ���űݾ�, order_id�� ��ǰ ���� ��� ���űݾ�
select order_id, line_prod_seq, product_id, amount
	 , avg(amount) over(partition by order_id) as avg_amount
	 , avg(amount) over(partition by order_id order by line_prod_seq) as cum_avg_amount
from order_items;


/* 1. aggregation analytic �ǽ� */

-- ���� ���� �� �μ����� ���� �޿��� hiredate������ ���� �޿���.
select empno, ename, deptno, sal, hiredate
	 , sum(sal) over(partition by deptno order by hiredate) as sum_sal
from emp;

-- ���� ���� �� �μ��� ��� �޿��� ���� �޿����� ���� ���
select empno, ename, deptno, sal, hiredate
	 , avg(sal) over(partition by deptno)
	 , (sal - avg(sal) over(partition by deptno)) as sal_diff
from emp;

-- analytic�� ������� �ʰ� ���� ������ ��� ���
with temp_01 as (
  select deptno, avg(sal) as avg_sal
  from emp 
  group by 1)
select a.empno, a.ename, a.deptno, a.sal, a.hiredate,
	   b.avg_sal, a.sal - b.avg_sal as sal_diff
from emp a
join temp_01 b
on a.deptno = b.deptno
order by a.deptno ;

-- ���� ���� �� �μ��� �� �޿� ��� ���� �޿��� ����(�Ҽ��� 2�ڸ������� ���� ���)
select empno, ename, deptno, sal, hiredate
	 , round(sal / sum(sal) over(partition by deptno), 2) as sum_ratio
from emp;

-- ���� ���� �� �μ����� ���� ���� �޿� ��� ���� ���(�Ҽ��� 2�ڸ������� ���� ���)
select empno, ename, deptno, sal, hiredate
	 , round(sal / max(sal) over(partition by deptno), 2) as max_ratio
from emp;



-- product_id�� �� ������� ���ϰ�, ��ü ���� ��� ���� ��ǰ�� �� ����� ������ �Ҽ��� 2�ڸ��� ���� �� ����� ���� ������������ ����
with temp_01 as (
  select product_id, trunc(sum(amount)) as product_amount
  from order_items
  group by product_id 
  )
select product_id, product_amount, 
	   round(product_amount / sum(product_amount) over (), 2) as product_ratio
from temp_01
order by 3 desc;

-- ������ ���� ��ǰ �����, ������ ���� ���� ��ǰ ������� ���ϰ�, �������� ���� ���� ������ �ø��� ��ǰ�� ���� �ݾ� ��� ���� ��ǰ ���� ���� ���ϱ�
with temp_01 as (
  select a.employee_id, b.product_id, trunc(sum(b.amount)) as t_amount
  from orders a
  join order_items b
  on a.order_id  = b.order_id
  group by a.employee_id, b.product_id 
  )
select employee_id, product_id, t_amount,
	   (t_amount / max(t_amount) over(partition by employee_id)) as max_ratio
from temp_01
order by 1, 4 desc;

-- ��ǰ�� �������� ���ϵ�, ��ǰ ī�װ��� �������� 5% �̻��̰�, ���� ī�װ����� ���� 3�� ������ ��ǰ ���� ����
-- 1. ��ǰ�� + ��ǰ ī�װ��� �� ���� ��� (��ǰ�� + ��ǰ ī�װ��� �� ������ �ᱹ ��ǰ�� �� �����)
-- 2. ��ǰ ī�װ��� �� ���� ��� �� ����ī�װ����� ��ǰ�� ��ŷ ����
-- 3. ��ǰ ī�װ� ������ 5% �̻��� ��ǰ ����� ���� ���� top 3 ��ǰ ����
with temp_01 as (
  select a.product_id, b.category_id, trunc(sum(a.amount)) as sum_amount
  from order_items a
  join products b
    on a.product_id = b.product_id
  group by 2, 1
  order by 1
  )
, temp_02 as (
  select product_id, category_id, sum_amount,
  	     sum(sum_amount) over (partition by category_id) as sum_category,
  	     row_number() over (partition by category_id order by sum_amount desc) as ranking
  from temp_01
  )
select *
from temp_02
where sum_amount >= 0.05 * sum_category
and ranking <= 3;