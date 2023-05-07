-- 3일 이동평균 매출
with temp_01 as (
  select  a.order_date, sum(b.amount) as sum_amount
  from orders a
  join order_items b 
    on a.order_id = b.order_id
  group by 1
  )
select order_date, sum_amount
	 , trunc(avg(sum_amount) over(order by order_date rows between 2 preceding and current row)) as ma_3days
from temp_01;

-- 3일 중간 평균 매출
with temp_01 as (
  select  a.order_date, sum(b.amount) as sum_amount
  from orders a
  join order_items b 
    on a.order_id = b.order_id
  group by 1
  )
select order_date, sum_amount
	 , trunc(avg(sum_amount) over(order by order_date rows between 1 preceding and 1 following)) as ca_3days
from temp_01;


-- N 이동 평균에서 맨 처음 N-1 개의 데이터의 경우 정확히 N이동 평균을 구할 수 없을 때 Null 처리
with temp_01 as (
  select  a.order_date, sum(b.amount) as sum_amount
  from orders a
  join order_items b 
    on a.order_id = b.order_id
  group by 1
  )
, temp_02 as (
  select order_date, sum_amount
	   , trunc(avg(sum_amount) over(order by order_date rows between 2 preceding and current row)) as ma_3days
	   , row_number() over(order by order_date) as rn
  from temp_01
)
select order_date, sum_amount
	 , case when rn < 3 then null else ma_3days end as ma_3days
from temp_02
;


-- 연속된 매출 일자에서 매출이 Null일 때와 그렇지 않을 때의 Aggregate Analytic 결과 차이
with ref_days as (
  select generate_series('1996-07-04'::date, '1996-07-23'::date, '1 day'::interval)::date as order_date
)
, temp_01 as (
  select  a.order_date, sum(b.amount) as sum_amount
  from orders a
  join order_items b 
    on a.order_id = b.order_id
  group by 1
  )
, temp_02 as (
  select a.order_date, b.sum_amount
  from ref_days a
  left join temp_01 b
	on a.order_date = b.order_date
  )
select order_date, sum_amount
	 , trunc(avg(sum_amount) over(order by order_date rows between 2 preceding and current row)) as ma_3days01
	 , trunc(avg(coalesce(sum_amount, 0)) over(order by order_date rows between 2 preceding and current row)) as ma_3days02
from temp_02;