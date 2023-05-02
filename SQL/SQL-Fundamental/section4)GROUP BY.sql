/**********************************
	group by 실습 - 01
***********************************/

-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구할 것
select deptno, max(sal), min(sal), round(avg(sal), 2)
from emp
group by deptno;

-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구하되 평균급여가 2000 이상인 경우만 추출
select deptno, max(sal), min(sal), round(avg(sal), 2)
from emp
group by deptno
having avg(sal) >= 2000;

-- emp 테이블에서 부서별 최대 급여, 최소 급여, 평균 급여를 구하되 평균급여가 2000 이상인 경우만 추출 (with절 이용)
with temp_01 as (
select deptno, max(sal), min(sal), round(avg(sal), 2) as avg_sal
from emp
group by deptno
)
select * from temp_01
where avg_sal >= 2000;

-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여
select a.empno, max(a.ename), trunc(avg(c.sal)) as avg_sal
from emp a
join dept b 
on a.deptno = b.deptno
join emp_salary_hist c
on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH')
group by 1
order by 1;

-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여 (with절로 풀기)
with temp_01 as (
select b.deptno, b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal
from emp a
join dept b
on a.deptno = b.deptno
join emp_salary_hist c
on a.empno = c.empno 
where b.dname in ('SALES', 'RESEARCH')
order by b.dname, a.empno, c.fromdate
)
select empno, ename, trunc(avg(sal)) as avg_sal
from temp_01
group by 1, 2
order by empno;

-- 부서명 SALES와 RESEARCH 부서별 평균 급여를 소속 직원의 과거부터 현재까지 모든 급여를 취합하여 구할 것.
select a.dname, trunc(avg(c.sal)) as avg_sal 
from dept a
left join emp b 
on a.deptno = b.deptno 
left join emp_salary_hist c
on b.empno = c.empno 
where a.dname in ('SALES', 'RESEARCH')
group by a.dname;