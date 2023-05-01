/*******************
	���� �ǽ� - 1
*******************/

-- ���� ������ ������ ���� �μ����� ��������
select a.*, b.dname 
from emp a 
join dept b
on a.deptno = b.deptno;

-- job�� SALESMAN�� ���������� ������ ���� �μ��� ��������
select a.*, b.dname
from emp a
join dept b
on a.deptno = b.deptno 
where job = 'SALESMAN';

-- �μ��� SALES�� RESEARCH�� �Ҽ� �������� �μ���, ������ȣ, ������, JOB, �׸��� ���� �޿� ���� ����
select b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal 
from emp a
join dept b
  on a.deptno = b.deptno 
join emp_salary_hist c
  on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH');

-- �μ��� SALES�� RESEARCH�� �Ҽ� �������� �μ���, ������ȣ, ������, JOB, �׸��� ���� �޿� ���� �� 1983�� ���� �����ʹ� �����ϰ� ������ ����
select b.dname, a.empno, a.ename, a.job, c.fromdate, c.todate, c.sal 
from emp a
join dept b
  on a.deptno = b.deptno 
join emp_salary_hist c
  on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH')
and c.fromdate >= to_date('19830101', 'yyyymmdd')
order by 1, 2, 3, c.fromdate;


-- �μ��� SALES�� RESEARCH �Ҽ� �������� ���ź��� ������� ��� �޿��� ������ ��� �޿�
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

-- ������ SMITH�� ���� �Ҽ� �μ� ������ ���� ��
select a.empno, a.ename, b.deptno, c.dname, b.fromdate, b.todate 
from emp a
join emp_dept_hist b 
  on a.empno = b.empno
join dept c
  on b.deptno = c.deptno
where a.ename = 'SMITH'
and b.todate < to_date('9999', 'yyyy');