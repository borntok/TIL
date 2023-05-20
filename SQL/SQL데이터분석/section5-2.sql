-- user 생성일자가 해당 월의 마지막 일에서 3일 전인 user 추출
-- 월의 마지막 일자 구하기
-- postgresql은 last_day() 함수가 없음. 때문에 해당 일자가 속한 달의 첫번째 날짜 가령 10월 5일이면 10월 1일에 1달을 더하고 거기에 1일을 뺌
-- 즉 10월 5일 -> 10월 1일 -> 11월 1일 -> 10월 31일 순으로 계산

select user_id, create_time
	 , (date_trunc('month', create_time) + interval '1 month' - interval '1 day')::date
from ga_users
where create_time <= (date_trunc('month', create_time) + interval '1 month' - interval '1 day')::date - 2;

-- 사용자별 월별 세션접속 횟수 구간별 집계, (월말 3일 이전 생성된 사용자 제외)
-- gubun별로 pivot하여 추출
with temp_01 as (
select a.user_id
	 , date_trunc('month', a.visit_stime)::date as month
	 , count(*) as monthly_user_cnt
from ga_sess a
join ga_users b 
  on a.user_id = b.user_id
where b.create_time <= (date_trunc('month', b.create_time) + interval '1 month' - interval '1 day')::date - 2
group by 1, 2
order by month
)
, temp_02 as (
select month 
	 , case when monthly_user_cnt = 1 then '0_only_first_session'
	 		when monthly_user_cnt between 2 and 3 then '2_between_3'
	 		when monthly_user_cnt between 4 and 8 then '4_between_8'
	 		when monthly_user_cnt between 9 and 14 then '9_between_14'
	 		when monthly_user_cnt between 15 and 25 then '15_between_25'
	 		when monthly_user_cnt >= 26 then 'over_26' end as gubun
	 , count(*) as user_cnt
from temp_01
group by month
	   , case when monthly_user_cnt = 1 then '0_only_first_session'
	 		when monthly_user_cnt between 2 and 3 then '2_between_3'
	 		when monthly_user_cnt between 4 and 8 then '4_between_8'
	 		when monthly_user_cnt between 9 and 14 then '9_between_14'
	 		when monthly_user_cnt between 15 and 25 then '15_between_25'
	 		when monthly_user_cnt >= 26 then 'over_26' end
order by 1, 2
)
select month
	 , sum(case when gubun='0_only_first_session' then user_cnt else 0 end) as "0_only_first_session"
	 , sum(case when gubun='2_between_3' then user_cnt else 0 end) as "2_between_3"
	 , sum(case when gubun='4_between_8' then user_cnt else 0 end) as "4_between_8"
	 , sum(case when gubun='9_between_14' then user_cnt else 0 end) as "9_between_14"
	 , sum(case when gubun='15_between_25' then user_cnt else 0 end) as "15_between_25"
	 , sum(case when gubun='over_26' then user_cnt else 0 end) as "over_26"
from temp_02
group by month order by 1
;


/******************************************************************************
  사용자가 첫 세션 접속 후 두 번째 세션 접속까지 걸리는 평균, 최대, 최소, 4분위 percentile 시간 추출
  step 1) 사용자 별로 접속 시간에 따라 session 별 순서를 매김
  step 2) session 별 순서가 첫 번째와 두 번째인 것 추출
  step 3) 사용자 별로 첫 번째 세션의 접속 이후 두 번째 세션의 접속 시간 차이를 가져 오기
  step 4) step 3의 데이터를 전체 평균, 최대, 최소, 4분위 percentile 시간 구하기
*******************************************************************************/

select * from ga_sess ;
-- 사용자 별로 접속 시간에 따라 session 별 순서를 매김.
select user_id
	 , row_number() over(partition by user_id order by visit_stime) as session_rn
	 , visit_stime
	 , count(*) over(partition by user_id) as session_cnt
from ga_sess
order by user_id, session_rn
;

-- session 별 순서가 첫번째와 두번째 인 것 추출하고 사용자 별로 첫번째 세션의 접속 이후 두번째 세션의 접속 시간 차이를 가져 오기
-- postgesql avg(time)은 interval이 제대로 고려되지 않음. justify_interval()을 적용해야 함.
with temp_01 as (
select user_id
	 , row_number() over(partition by user_id order by visit_stime) as session_rn
	 , visit_stime
	 , count(*) over(partition by user_id) as session_cnt
from ga_sess
order by user_id, session_rn
)
, temp_02 as (
select user_id 
	 , max(visit_stime) - min(visit_stime) as sess_time_diff
from temp_01
where session_rn <= 2 and session_cnt > 1
group by user_id
)
select justify_interval(avg(sess_time_diff))
	 , max(sess_time_diff) as max_time
	 , min(sess_time_diff) as min_time
	 , percentile_disc(0.25) within group (order by sess_time_diff) as percentile_1
	 , percentile_disc(0.5) within group (order by sess_time_diff) as percentile_2
	 , percentile_disc(0.75) within group (order by sess_time_diff) as percentile_3
	 , percentile_disc(1.0) within group (order by sess_time_diff) as percentile_4
from temp_02
where sess_time_diff::interval > interval '0 second'
;