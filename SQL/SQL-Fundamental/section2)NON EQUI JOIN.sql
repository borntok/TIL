/**************************************
	���� �ǽ� - non equi ���ΰ� cross ����
***************************************/

-- ���������� �޿���� ������ ����.
select * from salgrade;

select a.*, b.grade as salgrade, b.losal, b.hisal 
from emp a
join salgrade b
  on a.sal between b.losal and b.hisal;


-- ���� �޿��� �̷������� ��Ÿ����, �ش� �޿��� �޾Ҵ� ���� ���������� �μ���ȣ�� �Բ� ������ ��
select a.*, b.deptno 
from emp_salary_hist a
join emp_dept_hist b on a.empno = b.empno and a.fromdate between b.fromdate and b.todate ;


-- cross ����
with temp_01 as
(
select 1 as rnum
union all
select 2 as rnum
)
select a.*, b.*
from dept a
cross join temp_01 b;