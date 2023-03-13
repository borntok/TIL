-- DUAL 테이블: 오라클에서 제공하는 더미 테이블
DESC DUAL;

-- 내장형 함수(문자형): 오라클 엔진에서 제공하는 함수
-- ASCII('문자') -> 아스키코드로 출력
-- SUBSTR() -> 문자열을 자르는 함수
-- LENGTHB(문자열) -> 해당 문자열의 바이트 크기(한글:3byte/ 영문:1byte)
-- LTRIM() -> 좌측 공백 제거 함수
-- RTRIM() -> 우측 공백 제거 함수
-- TRIM() -> 좌우측 공백 제거 함수
-- CHR() -> 아스키코드 값에 해당하는 문자를 출력
SELECT ASCII('A'), SUBSTR('ABCDEFG', 3, 4), LENGTH('홍길동'), LENGTHB('홍길동'), LENGTH(LTRIM(' 홍')),
 LENGTH(RTRIM('홍 ')), LENGTH(TRIM(' 홍 ')), CHR(97)
 FROM DUAL;
-- CONCAT(): 문자열을 연결해주는 함수
-- ||: 문자열 연결 연산자
SELECT CONCAT('고구마는 ','맛있어'), '감자도 '||'맛있어'
 FROM DUAL;
-- LOWER(): 영문자를 소문자로 변경
-- UPPER(): 영문자를 대문자로 변경
SELECT LOWER('ABCDeee'), UPPER('ABCDeee')
 FROM DUAL;

-- 내장형 함수(날짜형)
-- SYSDATE: 지금 날짜 출력
-- EXTRACT: 년, 월, 일 추출
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE), EXTRACT(DAY FROM SYSDATE)
 FROM DUAL;

-- TO_CHAR(): 형변환 함수, 포맷에 맞게 날짜와 시각 표현
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS AM')
 FROM DUAL;
 
-- 내장형 함수(숫자형)
-- ABS(): 절대값을 구하는 함수
-- SIGN(): 양수, 0, 음수인지를 확인하는 함수
-- MOD(): 나머지를 구하는 함수
-- CEIL(): 무조건 올림하는 함수(숫자보다 크거나 같은 최소의 정수를 리턴)
-- FLOOR(): 무조건 내림하는 함수(숫자보다 작거나 같은 최대의 정수를 리턴)
-- ROUND(실수, 자릿수): 자릿수로 만드는데 반올림 처리 
-- TRUNC(실수, 자릿수): 자릿수로 만드는데 절삭 처리
SELECT ABS(-1), SIGN(0), MOD(11, 4), CEIL(10.1), FLOOR(10.9), ROUND(16.255, 2), TRUNC(16.255, 2)
 FROM DUAL;


-- DECODE(): IF문으로 구현 가능
-- DECODE() 함수는 컬럼값이 비교값과 비교해서 그 결과가 참이면 3번째 인자값을 리턴, 거짓이면 4번째 인자값을 리턴
SELECT DECODE(EMPNO, 1000, 'TRUE','FALSE')
 FROM EMP;
 
SELECT DECODE(MGR, NULL, 'NULL', 'NOT NULL')
 FROM EMP;

-- CASE문: 프로그래밍 언어처럼 조건문 사용
SELECT CASE
    WHEN EMPNO < 1003 THEN 'A'
    WHEN EMPNO < 1008 THEN 'B'
    ELSE 'C'
    END
 FROM EMP;
 
-- DEPTNO가 10번이면 인사팀, 20번이면 총무팀, 30번이면 전산팀, 그 외 나머지는 부서없음으로 표시하시오. 단, CASE문 이용
SELECT CASE
    WHEN DEPTNO = 10 THEN '인사팀'
    WHEN DEPTNO = 20 THEN '총무팀'
    WHEN DEPTNO = 30 THEN '전산팀'
    ELSE '부서 없음'
    END
 FROM EMP;