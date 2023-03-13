-- 서브쿼리: WHERE구문에 SELECT문이 하나의 쿼리문으로 존재하는 것을 의미
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > 177;

-- 서브쿼리 -> 메인쿼리 순으로 실행
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > (SELECT HEIGHT 
                FROM USERTBL 
                WHERE USERNAME = '김용만');
                
-- 인라인 뷰: FROM구에 들어가는 서브쿼리, 가상의 테이블을 만드는 쿼리
SELECT *
 FROM (SELECT ROWNUM ID, PRODNAME  
        FROM BUYTBL) -- FROM구에는 쿼리문으로 가상의 테이블을 만들어주는 인라인 뷰
WHERE ID < 5;

-- 단일행 서브쿼리: 반드시 한 행만 조회해서 리턴 --> 비교연산자(>,>=,<,<=,=,<>) 사용
-- 다중행 서브쿼리: 여러 개의 행 리턴 가능 --> ANY, SOME, IN, ALL, EXISTS

-- 단일행 서브쿼리에서 서브쿼리문이 리턴하는 레코드가 2개이므로 비교대상이 애매하여 에러 발생
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > (SELECT HEIGHT
                 FROM USERTBL
                WHERE ADDR = '경남');
                
-- ANY: OR의 개념과 유사
-- 170 초과 또는 173 초과이므로 170 초과되는 값 출력
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT > ANY (SELECT HEIGHT
                     FROM USERTBL
                     WHERE ADDR = '경남');
                     
-- SOME: ANY와 동일한 기능
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT = SOME (SELECT HEIGHT
                        FROM USERTBL
                       WHERE ADDR = '경남');
                       
-- ALL: 서브쿼리의 결과값을 모두 만족하는 데이터만 출력 (AND와 유사)
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT > ALL (SELECT HEIGHT
                       FROM USERTBL
                      WHERE ADDR = '경남');

-- IN: 서브쿼리의 결과값을 포함하는 데이터 출력
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT IN (SELECT HEIGHT
                    FROM USERTBL
                   WHERE ADDR = '서울');

-- NOT IN: 서브쿼리의 결과값을 포함하지 않는 데이터 출력
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT NOT IN (SELECT HEIGHT
                        FROM USERTBL
                       WHERE ADDR = '서울');
                       
-- EXISTS: 서브쿼리로 어떤 데이터의 존재 여부를 BOOLEAN값으로 리턴
-- 실행순서가 메인쿼리->서브쿼리, 행의 결과를 비교해서 존재하면 출력, 없으면 출력X
SELECT *
 FROM USERTBL U
WHERE EXISTS (SELECT *
                FROM BUYTBL B
               WHERE U.USERID = B.USERID);

-- 스칼라 서브쿼리: 반드시 한 행과 한 컬럼만 반환하는 서브쿼리
SELECT ENAME AS "이름", SAL AS "급여", 
       (SELECT ROUND(AVG(SAL), 2) FROM EMP) AS "평균급여" -- 스칼라 서브쿼리
  FROM EMP
 WHERE EMPNO = '1000';