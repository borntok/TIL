/**********************
	Analytic sql 실습
***********************/

select * from emp;

-- 회사내 근무 기간 순위(hiredate): 공동 순위가 있을 경우 차순위는 밀려서 진행
select *
	 , rank() over(order by hiredate)
from emp;


-- 부서별로 가장 급여가 높은/낮은 순으로 순위: 공동 순위 시 차순위는 밀리지 않음
select *
	 , dense_rank () over(partition by deptno order by sal desc) as 높은_순위
	 , dense_rank () over(partition by deptno order by sal) as 낮은_순위
from emp ;

-- 부서별 가장 급여가 높은 직원 정보: 공동 순위는 없으며 반드시 고유 순위를 정함
select *
from (
  select *
	   , row_number () over(partition by deptno order by sal desc) as rn
  from emp
) a 
where rn = 1;

-- 부서별 급여 top 2 직원 정보: 공동 순위는 없으며 반드시 고유 순위를 정함
select *
from (
  select *
	   , row_number () over(partition by deptno order by sal desc) as rn
  from emp
) a 
where rn <= 2;

-- 부서별 가장 급여가 높은 직원과 가장 급여가 낮은 직원 정보, 공동순위는 없으며 반드시 고유 순위를 정함
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
 
-- 회사내 커미션 높은 순위. rank와 row_number 모두 추출
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