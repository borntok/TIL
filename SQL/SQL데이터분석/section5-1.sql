with temp_01 as (
	select to_char(date_trunc('day', visit_stime), 'yyyy-mm-dd') as d_day
		 , count(distinct sess_id) as daily_sess_cnt
		 , count(sess_id) as daily_sess_cnt_again
		 , count(distinct user_id) as daily_user_cnt
	from ga.ga_sess
	group by to_char(date_trunc('day', visit_stime), 'yyyy-mm-dd')
)
select *
	 , 1.0 * daily_sess_cnt / daily_user_cnt as avg_user_sessions
	 -- 정수와 정수를 나눌 때 postgresql은 정수로 형변환 함. 1.0을 곱해주거나 명시적으로 float type 선언
from temp_01
;

/*************************
	DAU, WAU, MAU 구하기
**************************/

select * from ga_sess;

/* 아래는 이미 많은 과거 데이터가 있을 경우를 가정하고 DAU, WAU, MAU를 추출함 */
-- 일별 방문한 고객 수(DAU)
select date_trunc('day', visit_stime)::date as d_day
	 , count(distinct user_id) as user_cnt
from ga_sess 
group by date_trunc('day', visit_stime);

-- 주별 방문한 고객 수(WAU)
select date_trunc('week', visit_stime)::date as week_day
	 , count(distinct user_id) as user_cnt
from ga_sess
group by date_trunc('week', visit_stime);

-- 월별 방문한 고객 수(WAU)
select date_trunc('month', visit_stime)::date as month_day
	 , count(distinct user_id) as user_cnt
from ga_sess
group by date_trunc('month', visit_stime);


/* 아래는 하루 주기로 계속 DAU, WAU(이전 7일), MAU(이전 30일)를 계속 추출 */
-- interval로 전일 7일 구하기
select to_date('20161101', 'yyyymmdd') - interval '7days';

-- 현재 일을 기준으로 전 7일의 WAU 구하기
select :current_date
	 , count(distinct user_id) as wau
from ga_sess
where visit_stime >= (:current_date - interval '7days') and visit_stime < :current_date;

-- 현재 일을 기준으로 전 1일의 DAU 구하기
select :current_date
	 , count(distinct user_id) as dau
from ga_sess
where visit_stime >= (:current_date - interval '1days') and visit_stime < :current_date;

-- 현재 일을 기준으로 전 30일의 MAU 구하기
select :current_date
	 , count(distinct user_id) as mau
from ga_sess
where visit_stime >= (:current_date - interval '30days') and visit_stime < :current_date;

-- 날짜별로 DAU, WAU, MAU 값을 가지는 테이블 생성
create table if not exists daily_acquisitions
(d_day date,
 dau integer,
 wau integer,
 mau integer
 );
 
select * from daily_acquisitions;

-- daily_acquisitions 테이블에 지정된 current_date별 DAU, WAU, MAU을 입력
insert into daily_acquisitions 
select :current_date
	 -- scalar subquery는 select 절에 사용가능. 단, 하나의 로우, 하나의 컬럼만 추출되어야 함.
	 , (select count(distinct user_id) as dau
	 	from ga_sess
	 	where visit_stime >= (:current_date - interval '1day') and visit_stime < :current_date)
	 , (select count(distinct user_id) as wau
	 	from ga_sess
	 	where visit_stime >= (:current_date - interval '7days') and visit_stime < :current_date)
	 , (select count(distinct user_id) as mau
	 	from ga_sess
	 	where visit_stime >= (:current_date - interval '30day') and visit_stime < :current_date)
;

-- 데이터 입력 확인
select * from daily_acquisitions;


-- 과거 일자별로 DAU 생성
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as dau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '1day') and visit_stime < b.current_date
group by b.current_date
;

-- 과거 일자별로 WAU 생성
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as wau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '7day') and visit_stime < b.current_date
group by b.current_date
;

-- 과거 일자별로 MAU 생성
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as mau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '30day') and visit_stime < b.current_date
group by b.current_date
;

-- 과거 일자별로 DAU 생성하는 임시 테이블 생성
drop table if exists daily_dau;

create table daily_dau
as
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as dau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '1day') and visit_stime < b.current_date
group by b.current_date
;

select * from daily_dau;

-- 과거 일자별로 WAU 생성하는 임시 테이블 생성
drop table if exists daily_wau;

create table daily_wau
as
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as wau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '7days') and visit_stime < b.current_date
group by b.current_date
;

-- 과거 일자별로 MAU 생성하는 임시 테이블 생성
drop table if exists daily_mau;

create table daily_mau
as
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as mau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '30days') and visit_stime < b.current_date
group by b.current_date
;


-- DAU, WAU, MAU 임시테이블을 일자별로 조인하여 daily_acquisitions 테이블 생성
drop table if exists daily_acquisitions;

create table daily_acquisitions
as
select a.current_date as curr_date, a.dau, b.wau, c.mau
from daily_dau a
join daily_wau b on a.current_date = b.current_date
join daily_mau c on a.current_date = c.current_date
;

select * from daily_acquisitions;



/*************************************
	DAU와 MAU의 비율. 고착도(stickiness) 
**************************************/
-- 월간 사용자들 중 얼마나 많은 사용자가 주기적으로 방문하는가? 재방문 지표로 서비스의 활성화 정도를 나타냄

-- DAU와 MAU의 비율
with temp_dau as (
select :current_date as curr_date
	 , count(distinct user_id) as dau
from ga_sess
where visit_stime >= (:current_date - interval '1days')
and visit_stime < :current_date 
)
, temp_mau as (
select :current_date as curr_date
	 , count(distinct user_id) as mau
from ga_sess
where visit_stime >= (:current_date - interval '30days')
and visit_stime < :current_date  
)
select a.curr_date, a.dau, b.mau
	 , round(100.0 * a.dau / b.mau, 2) as stickiness 
from temp_dau a
join temp_mau b 
  on a.curr_date = b.curr_date
;


-- 일주일간 stickiness, 평균 stickiness
select *
	 , round(100.0 * dau/mau, 2) as stickiness
	 , round(avg(100.0 * dau/mau) over(), 2) as avg_stickiness
from daily_acquisitions 
where curr_date between to_date('2016-10-25', 'yyyy-mm-dd') and to_date('2016-10-31', 'yyyy-mm-dd')
;