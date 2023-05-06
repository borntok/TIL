/**********************
	group by rollup
***********************/

-- deptno + job 레벨 외에 dept내 전체 job 레벨(결국 dept 레벨), 전체 Aggregation 수행
select deptno, job, sum(sal)
from emp 
group by rollup(deptno, job)
order by 1, 2;


-- 상품 카테고리 + 상품별 매출합 구하기
select c.category_name, b.product_name, sum(a.amount)
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c
  on b.category_id = c.category_id 
group by c.category_name, b.product_name
order by 1,2;

-- 상품 카테고리 + 상품별 매출합 구하되, 상품 카테고리 별 소계 매출합 및 전체 상품의 매출합을 함께 구하기
select c.category_name, b.product_name, sum(a.amount)
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c
  on b.category_id = c.category_id 
group by rollup(c.category_name, b.product_name)
order by 1,2;


-- 년,월,일별 매출합 구하기
-- 월 또는 일을 01, 02와 같은 형태로 표시하려면 to_char()함수, 1, 2와 같은 숫자로 표시하려면 date_part()함수 사용
select to_char(a.order_date, 'yyyy') as year,
	   to_char(a.order_date, 'mm') as month,
	   to_char(a.order_date, 'dd') as day,
	   sum(b.amount)
from orders a
join order_items b
  on a.order_id = b.order_id 
group by 1, 2, 3
order by 1, 2, 3;

-- 년+월+일별 매출합 구하되, 월별 소계 매출합, 년별 매출합, 전체 매출합을 함께 구하기
with temp_01 as
(
 select to_char(a.order_date, 'yyyy') as year,
 	    to_char(a.order_date, 'mm') as month,
	    to_char(a.order_date, 'dd') as day,
	    sum(b.amount) as sum_amount
 from orders a
 join order_items b
   on a.order_id = b.order_id 
 group by rollup(1, 2, 3)
 order by 1, 2, 3
)
select case when year is null then '총매출' else year end as year
	 , case when year is null then null
	     else case when month is null then '년 총매출' else month end 
	   end as month 
	 , case when year is null or month is null then null 
	 	 else case when day is null then '월 총매출' else day end
	   end as day
	 , sum_amount
from temp_01
order by year, month, day ;



/********************
	group by cube 
*********************/

--deptno, job의 가능한 결합으로 Group by 수행
select deptno, job, sum(sal)
from emp
group by cube(1, 2)
order by 1, 2;


-- 상품카테고리 + 상품별 + 주문처리직원별 매출
select c.category_name, b.product_name, 
	   e.first_name||' '||e.last_name as employee,
	   sum(a.amount) 
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c 
  on b.category_id = c.category_id 
join orders d
  on a.order_id = d.order_id 
join employees e
  on d.employee_id = e.employee_id 
group by 1, 2, 3
order by 1, 2, 3;

-- 상품카테고리, 상품별, 주문처리직원별 가능한 결합으로 Group by 수행
select c.category_name, b.product_name, 
	   e.first_name||' '||e.last_name as employee,
	   sum(a.amount) 
from order_items a
join products b
  on a.product_id = b.product_id 
join categories c 
  on b.category_id = c.category_id 
join orders d
  on a.order_id = d.order_id 
join employees e
  on d.employee_id = e.employee_id 
group by cube(1, 2, 3)
order by 1, 2, 3;