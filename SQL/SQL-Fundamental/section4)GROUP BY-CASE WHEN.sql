/****************************
 	group by - case when
****************************/

-- emp ���̺��� �Ի�⵵�� ��� �޿� ���ϱ�.
select to_char(hiredate, 'yyyy') as hire_year, avg(sal) as avg_sal
from emp
group by to_char(hiredate, 'yyyy')
order by 1;

-- 1000�̸�, 1000-1999, 2000-2999�� ���� 1000���� ���� ���� sal�� �ִ� ������ group by �ϰ� �ش� �Ǽ��� ����
select floor(sal/1000) * 1000 as sal_range, count(*) as cnt, sum(sal) as sum_sal
from emp 
group by floor(sal/1000) 
order by 1;

-- job�� salesman�� ���� �׷��� ���� ��츸 ����� ���/�ּ�/�ִ� �޿��� ���ϱ�.
select case when job = 'SALESMAN' then 'SALESMAN' else 'OTHERS' end as job_sep,
			     avg(sal), min(sal), max(sal), count(*)
from emp 
group by case when job = 'SALESMAN' then 'SALESMAN' else 'OTHERS' end;