/**********************
	Analytic sql �ǽ�
***********************/

select * from emp;

-- ȸ�系 �ٹ� �Ⱓ ����(hiredate): ���� ������ ���� ��� �������� �з��� ����
select *
	 , rank() over(order by hiredate)
from emp;


-- �μ����� ���� �޿��� ����/���� ������ ����: ���� ���� �� �������� �и��� ����
select *
	 , dense_rank () over(partition by deptno order by sal desc) as ����_����
	 , dense_rank () over(partition by deptno order by sal) as ����_����
from emp ;

-- �μ��� ���� �޿��� ���� ���� ����: ���� ������ ������ �ݵ�� ���� ������ ����
select *
from (
  select *
	   , row_number () over(partition by deptno order by sal desc) as rn
  from emp
) a 
where rn = 1;

-- �μ��� �޿� top 2 ���� ����: ���� ������ ������ �ݵ�� ���� ������ ����
select *
from (
  select *
	   , row_number () over(partition by deptno order by sal desc) as rn
  from emp
) a 
where rn <= 2;

-- �μ��� ���� �޿��� ���� ������ ���� �޿��� ���� ���� ����, ���������� ������ �ݵ�� ���� ������ ����
with temp_01 as (
  select a.*
  	   , case when rn_desc = 1 then 'TOP'
  	   	 	  when rn_asc = 1 then 'BOTTOM'
  	   	 else 'middle' end as gubun
  from (
    select *
	     , row_number () over(partition by deptno order by sal desc) as rn_desc
	     , row_number () over(partition by deptno order by sal) as rn_asc
    from emp
  ) a 
where rn_desc = 1 or rn_asc = 1 
)
, temp_02 as (
  select deptno
  	   , max(sal) as max_sal
  	   , min(sal) as min_sal
  from temp_01
  group by deptno
)
select a.*
	 , b.max_sal - b.min_sal as sal_diff
from temp_01 a
join temp_02 b 
  on a.deptno = b.deptno
order by a.deptno, a.sal desc 
  ;
 
-- ȸ�系 Ŀ�̼� ���� ����. rank�� row_number ��� ����
 select *
 	  , rank() over(order by comm desc /*nulls first*/) as rank
 	  , row_number() over(order by comm desc /*nulls first*/) as rn
 from emp;
 
 select *
 	  , rank() over(order by comm desc nulls last) as rank
 	  , row_number() over(order by comm desc nulls last) as rn
 from emp;
 
 select *
 	  , rank() over(order by coalesce(comm, 0) desc) as rank
 	  , row_number() over(order by coalesce(comm, 0) desc) as rn
 from emp;