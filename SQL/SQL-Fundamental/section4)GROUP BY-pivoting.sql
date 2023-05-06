/***********************************************************************
	group by 실습 (group by와 aggregate 함수의 case when을 이용한 pivoting)
************************************************************************/

select job, sum(sal) as sales_sum
from emp 
group by job;

-- deptno로 group by하고 job으로 pivoting
select sum(case when job = 'SALESMAN' then sal end) as salesman,
	   sum(case when job = 'MANAGER' then sal end) as manager,
	   sum(case when job = 'ANALYST' then sal end) as analyst,
	   sum(case when job = 'CLERK' then sal end) as clerk,
	   sum(case when job = 'PRESIDENT' then sal end) as president
from emp;


-- deptno + job별로 group by
select deptno, job, sum(sal) as sal_sum, count(*)
from emp 
group by 1, 2
order by 1;

-- deptno로 group by하고 job으로 pivoting
select deptno, sum(sal) as sal_sum,
	   sum(case when job = 'SALESMAN' then sal end) as salesman,
	   sum(case when job = 'MANAGER' then sal end) as manager,
	   sum(case when job = 'ANALYST' then sal end) as analyst,
	   sum(case when job = 'CLERK' then sal end) as clerk,
	   sum(case when job = 'PRESIDENT' then sal end) as president
from emp
group by deptno;


-- group by Pivoting시 조건에 따른 건수 계산 유형 (count case when then 1 else null end)
select deptno, count(*) as cnt,
	   count(case when job = 'SALESMAN' then 1 end) as salesman,
	   count(case when job = 'MANAGER' then 1 end) as manager,
	   count(case when job = 'ANALYST' then 1 end) as analyst,
	   count(case when job = 'CLERK' then 1 end) as clerk,
	   count(case when job = 'PRESIDENT' then 1 end) as president
from emp
group by deptno;

-- group by Pivoting시 조건에 따른 건수 계산 시 잘못된 사례 (count case when then 1 else 0 end)
select deptno, count(*) as cnt,
	   count(case when job = 'SALESMAN' then 1 else 0 end) as salesman,
	   count(case when job = 'MANAGER' then 1 else 0 end) as manager,
	   count(case when job = 'ANALYST' then 1 else 0 end) as analyst,
	   count(case when job = 'CLERK' then 1 else 0 end) as clerk,
	   count(case when job = 'PRESIDENT' then 1 else 0 end) as president
from emp
group by deptno;

-- group by Pivoting시 조건에 따른 건수 계산 시 sum()을 이용
select deptno, count(*) as cnt,
	   sum(case when job = 'SALESMAN' then 1 else 0 end) as salesman,
	   sum(case when job = 'MANAGER' then 1 else 0 end) as manager,
	   sum(case when job = 'ANALYST' then 1 else 0 end) as analyst,
	   sum(case when job = 'CLERK' then 1 else 0 end) as clerk,
	   sum(case when job = 'PRESIDENT' then 1 else 0 end) as president
from emp
group by deptno;