-- lag(): ���� �ຸ�� ���� ���� �����͸� ������. ���� �μ����� hiredate������ ���� ename�� ������.
select empno, deptno, hiredate, ename
	 , lag(ename) over (partition by deptno order by hiredate) as prev_name
from emp;

-- lead(): ���� ���� ���� ���� �����͸� ������. ���� �μ����� hiredate������ ���� ename�� ������
select empno, deptno, hiredate, ename
	 , lead(ename) over (partition by deptno order by hiredate) as prev_name
from emp;


-- lag ���� �� windows���� ������ ���� ���� ��� default ���� ������ �� ����. �� ��� �ݵ�� offset�� ���������
select empno, deptno, hiredate, ename
	 , lag(ename, 1, 'No Previous') over (partition by deptno order by hiredate) as prev_name
from emp;

-- Null ó���� �Ʒ��� ���� ������ ���� ����
select empno, deptno, hiredate, ename
	 , coalesce (lag(ename) over(partition by deptno order by hiredate), 'No Previous') as prev_name
from emp;


-- �����ϰ� ������ ���ⵥ���Ϳ� �� ���̸� ���, ������ ���� �����Ͱ� ���� ��� ������ ���� �����͸� ����ϰ�, ���̴� 0
with temp_01 as (
  select a.order_date, sum(b.amount) as sum_amount
  from orders a
  join order_items b
    on a.order_id = b.order_id
  group by a.order_date
  )
select order_date, sum_amount
	 , coalesce(lag(sum_amount) over(order by order_date), sum_amount) as prev_amount
	 , sum_amount - coalesce(lag(sum_amount) over(order by order_date), sum_amount) as diff_amount
from temp_01;


-- �μ����� ���� hiredate�� ������ ����� sal ��������
select empno, ename, deptno, hiredate, sal
	 , first_value(sal) over(partition by deptno order by hiredate) as first_hiredate_sal
from emp;

-- �μ����� ���� hiredate�� �ֱ��� ����� sal ��������. windows���� rows between unbounded preceding and unbounded following�� �Ǿ����.
select empno, ename, deptno, hiredate, sal
	 , last_value(sal) over(partition by deptno order by hiredate
	 						rows between unbounded preceding and unbounded following) as last_hiredate_sal_01 
	 , last_value(sal) over(partition by deptno order by hiredate
	 						rows between unbounded preceding and current row) as last_hiredate_sal_02
from emp;

-- last_value() over(order by asc) ��� first_value() over(order by desc)�� ���� ����
select empno, ename, deptno, hiredate, sal
	 , last_value(sal) over(partition by deptno order by hiredate rows between unbounded preceding and unbounded following) as last_hiredate_sal_01
	 , first_value(sal) over(partition by deptno order by hiredate desc) as last_hiredate_sal_02
from emp;

-- first_value()�� min()�� ����
select empno, ename, deptno, hiredate, sal
	 , first_value(sal) over(partition by deptno order by hiredate) as first_hiredate_sal
	 , min(sal) over(partition by deptno order by hiredate) as min_sal
from emp;