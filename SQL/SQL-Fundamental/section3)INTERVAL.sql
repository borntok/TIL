/**********************************************************
	date_part를 이용하여 date/timestamp에서 년,월,일/시간,분,초 추출
***********************************************************/

-- date_part를 이용하여 년,월,일 추출
select a.*,
	   date_part('year', hiredate) as year,
	   date_part('month', hiredate) as month,
	   date_part('day', hiredate) as day 
from emp a;

-- date_part를 이용하여 시간, 분, 초 추출
select date_part('hour', '2023-05-01 18:11:57'::timestamp) as hour,
	   date_part('minute', '2023-05-01 18:11:57'::timestamp) as minute,
	   date_part('second', '2023-05-01 18:11:57'::timestamp) as second
;


/****************************************
	날짜와 시간 연산. interval의 활용
*****************************************/

-- 날짜 연산
-- Date 타입에 숫자값을 더하거나 빼면 숫자값에 해당하는 일자를 더하거나 빼서 날짜 계산
select to_date('2023-05-01', 'yyyy-mm-dd') - 2 as date_01;

-- Timestamp는 interval 타입을 이용하여 연산 수행
select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '7 hour' as timestamp_01;

select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days' as timestamp_02;

select to_timestamp('2023-05-01 18:19:22', 'yyyy-mm-dd hh24:mi:ss') + interval '2 days 7 hours 30 minutes' as timestamp_03;

-- Date 타입에 interval을 더하면 Timestamp로 변환
select to_date('2023-05-01', 'yyyy-mm-dd') + interval '2 days' as date_02;

-- interval '2 days'와 같이 ' '내에는 days나 day 혼용 가능하지만 interval '2' day만 허용
select to_date('2023-05-01', 'yyyy-mm-dd') + interval '2' day as date_03;

-- 날짜 간의 차이 구하기. 차이값은 정수형
select to_date('2023-05-01', 'yyyy-mm-dd') - to_date('2023-03-13', 'yyyy-mm-dd') as integer_01,
	   pg_typeof(to_date('2023-05-01', 'yyyy-mm-dd') - to_date('2023-03-13', 'yyyy-mm-dd')) as type;
	   
-- Timestamp간의 차이 구하기. 차이값은 interval
select to_timestamp('2023-05-01 18:29:33', 'yyyy-mm-dd hh24:mi:ss')
	 - to_timestamp('2023-03-13 09:10:17', 'yyyy-mm-dd hh24:mi:ss') as time_01,
	   pg_typeof(to_timestamp('2023-05-01 18:29:33', 'yyyy-mm-dd hh24:mi:ss')
	 - to_timestamp('2023-03-13 09:10:17', 'yyyy-mm-dd hh24:mi:ss')) as type;

-- date + date는 허용하지 않음
	
-- now(), current_timestamp, current_date, current_time
-- interval을 년,월,일로 표시하기. justify_interval과 age 사용 차이
with temp_01 as 
(
select empno, ename, hiredate, now(), current_timestamp, current_date, current_time,
	   date_trunc('second', now()) as now_trunc,
	   now() - hiredate as 근속기간
from emp
)
select empno, ename, hiredate,
	   date_part('year', 근속기간),
	   justify_interval(근속기간),
	   age(hiredate),
	   -- justify_interval은 30일을 1달로 하여 계산 
	   date_part('year', justify_interval(근속기간)),
	   date_part('year', justify_interval(근속기간))||'년 '||date_part('month', justify_interval(근속기간))||'월' as 근속년월,
	   date_part('year', age(hiredate))||'년 '||date_part('month', age(hiredate))||'월' as 근속년월_01
from temp_01;