-- order_items 테이블에서 order_id별 amount 총합까지 표시
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over(partition by order_id) as total_amount
from order_items;

-- order_items 테이블에서 order_id별 line_prod_seq순으로 누적 amount 합까지 표시
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over(partition by order_id order by line_prod_seq /* rows between unbounded preceding and current row */) as total_amount
from order_items;

-- order_items 테이블에서 order_id별 line_prod_seq순으로 누적 amount 합 - partition 또는 order by 절이 없을 경우 windows 전체
select order_id, line_prod_seq, product_id, amount
	 , sum(amount) over() as total_amount
from order_items
where order_id between 10248 and 10250;

-- order_items 테이블에서 order_id별 상품 최대 구매금액, order_id별 상품 누적 최대 구매금액
select order_id, line_prod_seq, product_id, amount
	 , max(amount) over(partition by order_id) as max_amount
	 , max(amount) over(partition by order_id order by line_prod_seq) as cum_max_amount
from order_items;

-- order_items 테이블에서 order_id별 상품 최소 구매금액, order_id별 상품 누적 최소 구매금액
select order_id, line_prod_seq, product_id, amount
	 , min(amount) over(partition by order_id) as min_amount
	 , min(amount) over(partition by order_id order by line_prod_seq) as cum_min_amount
from order_items;

-- order_items 테이블에서 order_id별 상품 평균 구매금액, order_id별 상품 누적 평균 구매금액
select order_id, line_prod_seq, product_id, amount
	 , avg(amount) over(partition by order_id) as avg_amount
	 , avg(amount) over(partition by order_id order by line_prod_seq) as cum_avg_amount
from order_items;


/* 1. aggregation analytic 실습 */

-- 직원 정보 및 부서별로 직원 급여의 hiredate순으로 누적 급여함.
select empno, ename, deptno, sal, hiredate
	 , sum(sal) over(partition by deptno order by hiredate) as sum_sal
from emp;

-- 직원 정보 및 부서별 평균 급여와 개인 급여와의 차이 출력
select empno, ename, deptno, sal, hiredate
	 , avg(sal) over(partition by deptno)
	 , (sal - avg(sal) over(partition by deptno)) as sal_diff
from emp;

-- analytic을 사용하지 않고 위와 동일한 결과 출력
with temp_01 as (
  select deptno, avg(sal) as avg_sal
  from emp 
  group by 1)
select a.empno, a.ename, a.deptno, a.sal, a.hiredate,
	   b.avg_sal, a.sal - b.avg_sal as sal_diff
from emp a
join temp_01 b
on a.deptno = b.deptno
order by a.deptno ;

-- 직원 정보 및 부서별 총 급여 대비 개인 급여의 비율(소수점 2자리까지로 비율 출력)
select empno, ename, deptno, sal, hiredate
	 , round(sal / sum(sal) over(partition by deptno), 2) as sum_ratio
from emp;

-- 직원 정보 및 부서에서 가장 높은 급여 대비 비율 출력(소수점 2자리까지로 비율 출력)
select empno, ename, deptno, sal, hiredate
	 , round(sal / max(sal) over(partition by deptno), 2) as max_ratio
from emp;



-- product_id별 총 매출액을 구하고, 전체 매출 대비 개별 상품의 총 매출액 비율을 소수점 2자리로 구한 뒤 매출액 비율 내림차순으로 정렬
with temp_01 as (
  select product_id, trunc(sum(amount)) as product_amount
  from order_items
  group by product_id 
  )
select product_id, product_amount, 
	   round(product_amount / sum(product_amount) over (), 2) as product_ratio
from temp_01
order by 3 desc;

-- 직원별 개별 상품 매출액, 직원별 가장 높은 상품 매출액을 구하고, 직원별로 가장 높은 매출을 올리는 상품의 매출 금액 대비 개별 상품 매출 비율 구하기
with temp_01 as (
  select a.employee_id, b.product_id, trunc(sum(b.amount)) as t_amount
  from orders a
  join order_items b
  on a.order_id  = b.order_id
  group by a.employee_id, b.product_id 
  )
select employee_id, product_id, t_amount,
	   (t_amount / max(t_amount) over(partition by employee_id)) as max_ratio
from temp_01
order by 1, 4 desc;

-- 상품별 매출합을 구하되, 상품 카테고리별 매출합의 5% 이상이고, 동일 카테고리에서 상위 3개 매출의 상품 정보 추출
-- 1. 상품별 + 상품 카테고리별 총 매출 계산 (상품별 + 상품 카테고리별 총 매출은 결국 상품별 총 매출액)
-- 2. 상품 카테고리별 총 매출 계산 및 동일카테고리에서 상품별 랭킹 구함
-- 3. 상품 카테고리 매출의 5% 이상인 상품 매출과 매출 기준 top 3 상품 추출
with temp_01 as (
  select a.product_id, b.category_id, trunc(sum(a.amount)) as sum_amount
  from order_items a
  join products b
    on a.product_id = b.product_id
  group by 2, 1
  order by 1
  )
, temp_02 as (
  select product_id, category_id, sum_amount,
  	     sum(sum_amount) over (partition by category_id) as sum_category,
  	     row_number() over (partition by category_id order by sum_amount desc) as ranking
  from temp_01
  )
select *
from temp_02
where sum_amount >= 0.05 * sum_category
and ranking <= 3;