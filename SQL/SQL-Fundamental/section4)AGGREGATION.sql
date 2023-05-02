/*****************************
	집계함수와 count(ditinct)
******************************/

drop table if exists emp_test;

create table emp_test
as
select * from emp;

insert into emp_test 
select 8000, 'CHMIN', 'ANALYST', 7839, to_date('19810101', 'YYYYMMDD'), 3000, 1000, 20;

select * from emp_test;


-- Aggregation은 Null값을 처리하지 않음
select deptno, count(*) as cnt, sum(comm), max(comm), avg(comm)
from emp_test
group by deptno;

select mgr, count(*), sum(comm)
from emp 
group by mgr;

-- max, min 함수는 숫자열 뿐만 아니라, 문자열, 날짜/시간 타입에도 적용 가능.
select deptno, max(job), min(ename), max(hiredate), min(hiredate)
from emp
group by deptno;

-- count(distinct 컬럼명)은 지정된 컬럼명에서 중복을 제거한 고유한 건수를 추출
select count(distinct job) from emp_test;

select deptno, count(*) as cnt, count(distinct job)
from emp_test
group by deptno;
