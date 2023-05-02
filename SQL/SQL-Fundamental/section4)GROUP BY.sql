/**********************************
	group by �ǽ� - 01
***********************************/

-- emp ���̺��� �μ��� �ִ� �޿�, �ּ� �޿�, ��� �޿��� ���� ��
select deptno, max(sal), min(sal), round(avg(sal), 2)
from emp
group by deptno;

-- emp ���̺��� �μ��� �ִ� �޿�, �ּ� �޿�, ��� �޿��� ���ϵ� ��ձ޿��� 2000 �̻��� ��츸 ����
select deptno, max(sal), min(sal), round(avg(sal), 2)
from emp
group by deptno
having avg(sal) >= 2000;

-- emp ���̺��� �μ��� �ִ� �޿�, �ּ� �޿�, ��� �޿��� ���ϵ� ��ձ޿��� 2000 �̻��� ��츸 ���� (with�� �̿�)
with temp_01 as (
select deptno, max(sal), min(sal), round(avg(sal), 2) as avg_sal
from emp
group by deptno
)
select * from temp_01
where avg_sal >= 2000;

-- �μ��� SALES�� RESEARCH �Ҽ� �������� ���ź��� ������� ��� �޿��� ������ ��� �޿�
select a.empno, max(a.ename), trunc(avg(c.sal)) as avg_sal
from emp a
join dept b 
on a.deptno = b.deptno
join emp_salary_hist c
on a.empno = c.empno
where b.dname in ('SALES', 'RESEARCH')
group by 1
order by 1;

-- �μ��� SALES�� RESEARCH �Ҽ� �������� ���ź��� ������� ��� �޿��� ������ ��� �޿� (with���� Ǯ��)
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

-- �μ��� SALES�� RESEARCH �μ��� ��� �޿��� �Ҽ� ������ ���ź��� ������� ��� �޿��� �����Ͽ� ���� ��.
select a.dname, trunc(avg(c.sal)) as avg_sal 
from dept a
left join emp b 
on a.deptno = b.deptno 
left join emp_salary_hist c
on b.empno = c.empno 
where a.dname in ('SALES', 'RESEARCH')
group by a.dname;