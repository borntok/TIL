/****************************
	조인 실습 - full outer 조인
*****************************/

-- dept는 소속 직원이 없는 경우 존재. 하지만 직원은 소속 부서가 없는 경우가 없음
select a.*, b.ename , b.ename
from dept a
left join emp b
  on a.deptno = b.deptno ;
  
-- full outer join 테스트를 위해 소속 부서가 없는 테스트용 데이터 생성.
 drop table if exists hr.emp_test;
 
create table hr.emp_test
as
select * from emp;

select * from hr.emp_test

-- 소속 부서를 Null로 Update
update hr.emp_test
set deptno = null
where empno = 7934;

select * from hr.emp_test;

-- dept를 기준으로 left outer join시 소속직원이 없는 부서는 추출되지만, 소속 부서가 없는 직원은 추출할 수 없음.
select a.*, b.empno, b.ename
from dept a
left join hr.emp_test b
  on a.deptno = b.deptno;
  
-- full outer join하여 양쪽 모두의 집합이 누락되지 않도록 함
select a.*, b.empno, b.ename
from dept a
full outer join hr.emp_test b 
  on a.deptno = b.deptno;