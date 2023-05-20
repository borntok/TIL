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
	 -- ������ ������ ���� �� postgresql�� ������ ����ȯ ��. 1.0�� �����ְų� ��������� float type ����
from temp_01
;

/*************************
	DAU, WAU, MAU ���ϱ�
**************************/

select * from ga_sess;

/* �Ʒ��� �̹� ���� ���� �����Ͱ� ���� ��츦 �����ϰ� DAU, WAU, MAU�� ������ */
-- �Ϻ� �湮�� �� ��(DAU)
select date_trunc('day', visit_stime)::date as d_day
	 , count(distinct user_id) as user_cnt
from ga_sess 
group by date_trunc('day', visit_stime);

-- �ֺ� �湮�� �� ��(WAU)
select date_trunc('week', visit_stime)::date as week_day
	 , count(distinct user_id) as user_cnt
from ga_sess
group by date_trunc('week', visit_stime);

-- ���� �湮�� �� ��(WAU)
select date_trunc('month', visit_stime)::date as month_day
	 , count(distinct user_id) as user_cnt
from ga_sess
group by date_trunc('month', visit_stime);


/* �Ʒ��� �Ϸ� �ֱ�� ��� DAU, WAU(���� 7��), MAU(���� 30��)�� ��� ���� */
-- interval�� ���� 7�� ���ϱ�
select to_date('20161101', 'yyyymmdd') - interval '7days';

-- ���� ���� �������� �� 7���� WAU ���ϱ�
select :current_date
	 , count(distinct user_id) as wau
from ga_sess
where visit_stime >= (:current_date - interval '7days') and visit_stime < :current_date;

-- ���� ���� �������� �� 1���� DAU ���ϱ�
select :current_date
	 , count(distinct user_id) as dau
from ga_sess
where visit_stime >= (:current_date - interval '1days') and visit_stime < :current_date;

-- ���� ���� �������� �� 30���� MAU ���ϱ�
select :current_date
	 , count(distinct user_id) as mau
from ga_sess
where visit_stime >= (:current_date - interval '30days') and visit_stime < :current_date;

-- ��¥���� DAU, WAU, MAU ���� ������ ���̺� ����
create table if not exists daily_acquisitions
(d_day date,
 dau integer,
 wau integer,
 mau integer
 );
 
select * from daily_acquisitions;

-- daily_acquisitions ���̺� ������ current_date�� DAU, WAU, MAU�� �Է�
insert into daily_acquisitions 
select :current_date
	 -- scalar subquery�� select ���� ��밡��. ��, �ϳ��� �ο�, �ϳ��� �÷��� ����Ǿ�� ��.
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

-- ������ �Է� Ȯ��
select * from daily_acquisitions;


-- ���� ���ں��� DAU ����
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as dau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '1day') and visit_stime < b.current_date
group by b.current_date
;

-- ���� ���ں��� WAU ����
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as wau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '7day') and visit_stime < b.current_date
group by b.current_date
;

-- ���� ���ں��� MAU ����
with temp_00 as (
select generate_series('2016-08-02'::date, '2016-11-01'::date, '1 day'::interval)::date as current_date
)
select b.current_date, count(distinct user_id) as mau
from ga_sess a
cross join temp_00 b 
where visit_stime >= (b.current_date - interval '30day') and visit_stime < b.current_date
group by b.current_date
;

-- ���� ���ں��� DAU �����ϴ� �ӽ� ���̺� ����
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

-- ���� ���ں��� WAU �����ϴ� �ӽ� ���̺� ����
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

-- ���� ���ں��� MAU �����ϴ� �ӽ� ���̺� ����
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


-- DAU, WAU, MAU �ӽ����̺��� ���ں��� �����Ͽ� daily_acquisitions ���̺� ����
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
	DAU�� MAU�� ����. ������(stickiness) 
**************************************/
-- ���� ����ڵ� �� �󸶳� ���� ����ڰ� �ֱ������� �湮�ϴ°�? ��湮 ��ǥ�� ������ Ȱ��ȭ ������ ��Ÿ��

-- DAU�� MAU�� ����
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


-- �����ϰ� stickiness, ��� stickiness
select *
	 , round(100.0 * dau/mau, 2) as stickiness
	 , round(avg(100.0 * dau/mau) over(), 2) as avg_stickiness
from daily_acquisitions 
where curr_date between to_date('2016-10-25', 'yyyy-mm-dd') and to_date('2016-10-31', 'yyyy-mm-dd')
;