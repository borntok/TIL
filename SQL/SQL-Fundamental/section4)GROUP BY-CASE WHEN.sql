/****************************
 	group by - case when
****************************/

-- emp 테이블에서 입사년도별 평균 급여 구하기.
select to_char(hiredate, 'yyyy') as hire_year, avg(sal) as avg_sal
from emp
group by to_char(hiredate, 'yyyy')
order by 1;

-- 1000미만, 1000-1999, 2000-2999와 같이 1000단위 범위 내에 sal이 있는 레벨로 group by 하고 해당 건수를 구함
select floor(sal/1000) * 1000 as sal_range, count(*) as cnt, sum(sal) as sum_sal
from emp 
group by floor(sal/1000) 
order by 1;

-- job이 salesman인 경우와 그렇지 않은 경우만 나누어서 평균/최소/최대 급여를 구하기.
select case when job = 'SALESMAN' then 'SALESMAN' else 'OTHERS' end as job_sep,
			     avg(sal), min(sal), max(sal), count(*)
from emp 
group by case when job = 'SALESMAN' then 'SALESMAN' else 'OTHERS' end;