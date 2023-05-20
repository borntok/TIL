-- user �������ڰ� �ش� ���� ������ �Ͽ��� 3�� ���� user ����
-- ���� ������ ���� ���ϱ�
-- postgresql�� last_day() �Լ��� ����. ������ �ش� ���ڰ� ���� ���� ù��° ��¥ ���� 10�� 5���̸� 10�� 1�Ͽ� 1���� ���ϰ� �ű⿡ 1���� ��
-- �� 10�� 5�� -> 10�� 1�� -> 11�� 1�� -> 10�� 31�� ������ ���

select user_id, create_time
	 , (date_trunc('month', create_time) + interval '1 month' - interval '1 day')::date
from ga_users
where create_time <= (date_trunc('month', create_time) + interval '1 month' - interval '1 day')::date - 2;

-- ����ں� ���� �������� Ƚ�� ������ ����, (���� 3�� ���� ������ ����� ����)
-- gubun���� pivot�Ͽ� ����
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
  ����ڰ� ù ���� ���� �� �� ��° ���� ���ӱ��� �ɸ��� ���, �ִ�, �ּ�, 4���� percentile �ð� ����
  step 1) ����� ���� ���� �ð��� ���� session �� ������ �ű�
  step 2) session �� ������ ù ��°�� �� ��°�� �� ����
  step 3) ����� ���� ù ��° ������ ���� ���� �� ��° ������ ���� �ð� ���̸� ���� ����
  step 4) step 3�� �����͸� ��ü ���, �ִ�, �ּ�, 4���� percentile �ð� ���ϱ�
*******************************************************************************/

select * from ga_sess ;
-- ����� ���� ���� �ð��� ���� session �� ������ �ű�.
select user_id
	 , row_number() over(partition by user_id order by visit_stime) as session_rn
	 , visit_stime
	 , count(*) over(partition by user_id) as session_cnt
from ga_sess
order by user_id, session_rn
;

-- session �� ������ ù��°�� �ι�° �� �� �����ϰ� ����� ���� ù��° ������ ���� ���� �ι�° ������ ���� �ð� ���̸� ���� ����
-- postgesql avg(time)�� interval�� ����� ������� ����. justify_interval()�� �����ؾ� ��.
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