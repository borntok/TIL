/*******************
	조인 실습 - 1
*******************/

-- 직원 정보와 직원이 속한 부서명을 가져오기
select a.*, b.dname 
from emp a 
join dept b
on a.deptno = b.deptno;

-- job이 SALESMAN인 직원정보와 직원이 속한 부서명 가져오기
select a.*, b.dname
from emp a
join dept b
on a.deptno = b.deptno 
where job = 'SALESMAN';

-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB, 그리고 과거 급여 정보 추출
select b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal 
from emp a
join dept b
  on a.deptno = b.deptno 
join emp_salary_hist c
  on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH');

-- 부서명 SALES와 RESEARCH의 소속 직원들의 부서명, 직원번호, 직원명, JOB, 그리고 과거 급여 정보 중 1983년 이전 데이터는 무시하고 데이터 추출
select b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal 
from emp a
join dept b
  on a.deptno = b.deptno 
join emp_salary_hist c
  on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH')
and c.fromdate >= to_date('19830101', 'yyyymmdd')
order by 1, 2, 3, c.fromdate;


-- 부서명 SALES와 RESEARCH 소속 직원별로 과거부터 현재까지 모든 급여를 취합한 평균 급여
with temp_01 as 
(
select b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal 
from emp a
join dept b 
  on a.deptno = b.deptno 
join emp_salary_hist c 
  on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH')
order by b.dname, a.empno, c.fromdate
)
select empno, max(ename), avg(sal) as avg_sal
from temp_01
group by empno;

-- 직원명 SMITH의 과거 소속 부서 정보를 구할 것
select a.empno, a.ename, b.deptno, c.dname, b.fromdate, b.todate 
from emp a
join emp_dept_hist b 
  on a.empno = b.empno
join dept c
  on b.deptno = c.deptno
where a.ename = 'SMITH'
and b.todate < to_date('9999', 'yyyy');