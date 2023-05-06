/***********************************************************************
	group by �ǽ� (group by�� aggregate �Լ��� case when�� �̿��� pivoting)
************************************************************************/

select job, sum(sal) as sales_sum
from emp 
group by job;

-- deptno�� group by�ϰ� job���� pivoting
select sum(case when job = 'SALESMAN' then sal end) as salesman,
	   sum(case when job = 'MANAGER' then sal end) as manager,
	   sum(case when job = 'ANALYST' then sal end) as analyst,
	   sum(case when job = 'CLERK' then sal end) as clerk,
	   sum(case when job = 'PRESIDENT' then sal end) as president
from emp;


-- deptno + job���� group by
select deptno, job, sum(sal) as sal_sum, count(*)
from emp 
group by 1, 2
order by 1;

-- deptno�� group by�ϰ� job���� pivoting
select deptno, sum(sal) as sal_sum,
	   sum(case when job = 'SALESMAN' then sal end) as salesman,
	   sum(case when job = 'MANAGER' then sal end) as manager,
	   sum(case when job = 'ANALYST' then sal end) as analyst,
	   sum(case when job = 'CLERK' then sal end) as clerk,
	   sum(case when job = 'PRESIDENT' then sal end) as president
from emp
group by deptno;


-- group by Pivoting�� ���ǿ� ���� �Ǽ� ��� ���� (count case when then 1 else null end)
select deptno, count(*) as cnt,
	   count(case when job = 'SALESMAN' then 1 end) as salesman,
	   count(case when job = 'MANAGER' then 1 end) as manager,
	   count(case when job = 'ANALYST' then 1 end) as analyst,
	   count(case when job = 'CLERK' then 1 end) as clerk,
	   count(case when job = 'PRESIDENT' then 1 end) as president
from emp
group by deptno;

-- group by Pivoting�� ���ǿ� ���� �Ǽ� ��� �� �߸��� ��� (count case when then 1 else 0 end)
select deptno, count(*) as cnt,
	   count(case when job = 'SALESMAN' then 1 else 0 end) as salesman,
	   count(case when job = 'MANAGER' then 1 else 0 end) as manager,
	   count(case when job = 'ANALYST' then 1 else 0 end) as analyst,
	   count(case when job = 'CLERK' then 1 else 0 end) as clerk,
	   count(case when job = 'PRESIDENT' then 1 else 0 end) as president
from emp
group by deptno;

-- group by Pivoting�� ���ǿ� ���� �Ǽ� ��� �� sum()�� �̿�
select deptno, count(*) as cnt,
	   sum(case when job = 'SALESMAN' then 1 else 0 end) as salesman,
	   sum(case when job = 'MANAGER' then 1 else 0 end) as manager,
	   sum(case when job = 'ANALYST' then 1 else 0 end) as analyst,
	   sum(case when job = 'CLERK' then 1 else 0 end) as clerk,
	   sum(case when job = 'PRESIDENT' then 1 else 0 end) as president
from emp
group by deptno;