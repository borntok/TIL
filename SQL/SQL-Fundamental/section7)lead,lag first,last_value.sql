-- lag(): 현재 행보다 이전 행의 데이터를 가져옴. 동일 부서에서 hiredate순으로 이전 ename을 가져옴.
select empno, deptno, hiredate, ename
	 , lag(ename) over (partition by deptno order by hiredate) as prev_name
from emp;

-- lead(): 현재 행의 다음 행의 데이터를 가져옴. 동일 부서에서 hiredate순으로 다음 ename을 가져옴
select empno, deptno, hiredate, ename
	 , lead(ename) over (partition by deptno order by hiredate) as prev_name
from emp;


-- lag 적용 시 windows에서 가져올 값이 없을 경우 default 값을 설정할 수 있음. 이 경우 반드시 offset을 정해줘야함
select empno, deptno, hiredate, ename
	 , lag(ename, 1, 'No Previous') over (partition by deptno order by hiredate) as prev_name
from emp;

-- Null 처리를 아래와 같이 수행할 수도 있음
select empno, deptno, hiredate, ename
	 , coalesce (lag(ename) over(partition by deptno order by hiredate), 'No Previous') as prev_name
from emp;


-- 현재일과 전일의 매출데이터와 그 차이를 출력, 이전일 매출 데이터가 없을 경우 현재일 매출 데이터를 출력하고, 차이는 0
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


-- 부서별로 가장 hiredate가 오래된 사람의 sal 가져오기
select empno, ename, deptno, hiredate, sal
	 , first_value(sal) over(partition by deptno order by hiredate) as first_hiredate_sal
from emp;

-- 부서별로 가장 hiredate가 최근인 사람의 sal 가져오기. windows절이 rows between unbounded preceding and unbounded following이 되어야함.
select empno, ename, deptno, hiredate, sal
	 , last_value(sal) over(partition by deptno order by hiredate
	 						rows between unbounded preceding and unbounded following) as last_hiredate_sal_01 
	 , last_value(sal) over(partition by deptno order by hiredate
	 						rows between unbounded preceding and current row) as last_hiredate_sal_02
from emp;

-- last_value() over(order by asc) 대신 first_value() over(order by desc)를 적용 가능
select empno, ename, deptno, hiredate, sal
	 , last_value(sal) over(partition by deptno order by hiredate rows between unbounded preceding and unbounded following) as last_hiredate_sal_01
	 , first_value(sal) over(partition by deptno order by hiredate desc) as last_hiredate_sal_02
from emp;

-- first_value()와 min()의 차이
select empno, ename, deptno, hiredate, sal
	 , first_value(sal) over(partition by deptno order by hiredate) as first_hiredate_sal
	 , min(sal) over(partition by deptno order by hiredate) as min_sal
from emp;