/*****************************
	�����Լ��� count(ditinct)
******************************/

drop table if exists emp_test;

create table emp_test
as
select * from emp;

insert into emp_test 
select 8000, 'CHMIN', 'ANALYST', 7839, to_date('19810101', 'YYYYMMDD'), 3000, 1000, 20;

select * from emp_test;


-- Aggregation�� Null���� ó������ ����
select deptno, count(*) as cnt, sum(comm), max(comm), avg(comm)
from emp_test
group by deptno;

select mgr, count(*), sum(comm)
from emp 
group by mgr;

-- max, min �Լ��� ���ڿ� �Ӹ� �ƴ϶�, ���ڿ�, ��¥/�ð� Ÿ�Կ��� ���� ����.
select deptno, max(job), min(ename), max(hiredate), min(hiredate)
from emp
group by deptno;

-- count(distinct �÷���)�� ������ �÷����� �ߺ��� ������ ������ �Ǽ��� ����
select count(distinct job) from emp_test;

select deptno, count(*) as cnt, count(distinct job)
from emp_test
group by deptno;
