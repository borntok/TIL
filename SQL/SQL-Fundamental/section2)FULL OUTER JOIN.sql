/****************************
	���� �ǽ� - full outer ����
*****************************/

-- dept�� �Ҽ� ������ ���� ��� ����. ������ ������ �Ҽ� �μ��� ���� ��찡 ����
select a.*, b.ename , b.ename
from dept a
left join emp b
  on a.deptno = b.deptno ;
  
-- full outer join �׽�Ʈ�� ���� �Ҽ� �μ��� ���� �׽�Ʈ�� ������ ����.
 drop table if exists hr.emp_test;
 
create table hr.emp_test
as
select * from emp;

select * from hr.emp_test

-- �Ҽ� �μ��� Null�� Update
update hr.emp_test
set deptno = null
where empno = 7934;

select * from hr.emp_test;

-- dept�� �������� left outer join�� �Ҽ������� ���� �μ��� ���������, �Ҽ� �μ��� ���� ������ ������ �� ����.
select a.*, b.empno, b.ename
from dept a
left join hr.emp_test b
  on a.deptno = b.deptno;
  
-- full outer join�Ͽ� ���� ����� ������ �������� �ʵ��� ��
select a.*, b.empno, b.ename
from dept a
full outer join hr.emp_test b 
  on a.deptno = b.deptno;