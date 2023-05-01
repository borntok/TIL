/**************************************
	조인 실습 - non equi 조인과 cross 조인
***************************************/

-- 직원정보와 급여등급 정보를 추출.
select * from salgrade;

select a.*, b.grade as salgrade, b.losal, b.hisal 
from emp a
join salgrade b
  on a.sal between b.losal and b.hisal;


-- 직원 급여의 이력정보를 나타내며, 해당 급여를 받았던 시작 시점에서의 부서번호도 함께 가져올 것
select a.*, b.deptno 
from emp_salary_hist a
join emp_dept_hist b on a.empno = b.empno and a.fromdate between b.fromdate and b.todate ;


-- cross 조인
with temp_01 as
(
select 1 as rnum
union all
select 2 as rnum
)
select a.*, b.*
from dept a
cross join temp_01 b;