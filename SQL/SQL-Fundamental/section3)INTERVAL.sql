/**********************************************************
	date_part�� �̿��Ͽ� date/timestamp���� ��,��,��/�ð�,��,�� ����
***********************************************************/

-- date_part�� �̿��Ͽ� ��,��,�� ����
select a.*,
	   date_part('year', hiredate) as year,
	   date_part('month', hiredate) as month,
	   date_part('day', hiredate) as day 
from emp a;

-- date_part�� �̿��Ͽ� �ð�, ��, �� ����
select date_part('hour', '2023-05-01 18:11:57'::timestamp) as hour,
	   date_part('minute', '2023-05-01 18:11:57'::timestamp) as minute,
	   date_part('second', '2023-05-01 18:11:57'::timestamp) as second
;


/****************************************
	��¥�� �ð� ����. interval�� Ȱ��
*****************************************/

-- ��¥ ����
-- Date Ÿ�Կ� ���ڰ��� ���ϰų� ���� ���ڰ��� �ش��ϴ� ���ڸ� ���ϰų� ���� ��¥ ���
select to_date('2023-05-01', 'yyyy-mm-dd') - 2 as date_01;

-- Timestamp�� interval Ÿ���� �̿��Ͽ� ���� ����
select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '7 hour' as timestamp_01;

select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days' as timestamp_02;

select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days 7 hours 30 minutes' as timestamp_03;

-- Date Ÿ�Կ� interval�� ���ϸ� Timestamp�� ��ȯ
select to_date('2023-05-01', 'yyyy-mm-dd') + interval '2 days' as date_02;

-- interval '2 days'�� ���� ' '������ days�� day ȥ�� ���������� interval '2' day�� ���
select to_date('2023-05-01', 'yyyy-mm-dd') + interval '2' day as date_03;

-- ��¥ ���� ���� ���ϱ�. ���̰��� ������
select to_date('2023-05-01', 'yyyy-mm-dd') - to_date('2023-03-13', 'yyyy-mm-dd') as integer_01,
	   pg_typeof(to_date('2023-05-01', 'yyyy-mm-dd') - to_date('2023-03-13', 'yyyy-mm-dd')) as type;
	   
-- Timestamp���� ���� ���ϱ�. ���̰��� interval
select to_timestamp('2023-05-01 18:29:33', 'yyyy-mm-dd hh24:mi:ss')
	 - to_timestamp('2023-03-13 09:10:17', 'yyyy-mm-dd hh24:mi:ss') as time_01,
	   pg_typeof(to_timestamp('2023-05-01 18:29:33', 'yyyy-mm-dd hh24:mi:ss')
	 - to_timestamp('2023-03-13 09:10:17', 'yyyy-mm-dd hh24:mi:ss')) as type;

-- date + date�� ������� ����
	
-- now(), current_timestamp, current_date, current_time
-- interval�� ��,��,�Ϸ� ǥ���ϱ�. justify_interval�� age ��� ����
with temp_01 as 
(
select empno, ename, hiredate, now(), current_timestamp, current_date, current_time,
	   date_trunc('second', now()) as now_trunc,
	   now() - hiredate as �ټӱⰣ
from emp
)
select empno, ename, hiredate,
	   date_part('year', �ټӱⰣ),
	   justify_interval(�ټӱⰣ),
	   age(hiredate),
	   -- justify_interval�� 30���� 1�޷� �Ͽ� ��� 
	   date_part('year', justify_interval(�ټӱⰣ)),
	   date_part('year', justify_interval(�ټӱⰣ))||'�� '||date_part('month', justify_interval(�ټӱⰣ))||'��' as �ټӳ��,
	   date_part('year', age(hiredate))||'�� '||date_part('month', age(hiredate))||'��' as �ټӳ��_01
from temp_01;