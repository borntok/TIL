-- EQUI(등가)조인 --> 교집합
-- 조인: 2개 이상의 릴레이션(테이블)을 사용해서 새로운 릴레이션을 만드는 과정
-- 두 릴레이션(기본키, 외래키) 일치하는 것을 조인의 조건으로 함
SELECT * FROM USERTBL;

SELECT * FROM BUYTBL;

-- 오라클에서 등가 내부 조인의 결과는 USERID가 같은 것만 추출하므로 12행이 출력됨
SELECT * 
 FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID;
-- 조인을 하더라도 추가적으로 조건을 줄 수 있음. 집계함수 및 GROUP BY도 사용 가능
SELECT *
 FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID
  AND USERTBL.USERNAME LIKE '이%';
  
-- ISO 표준 SQL로 TABLE1 INNER JOIN TABLE2 ON 테이블 교집합 조건
SELECT *
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID
 WHERE USERTBL.USERNAME = '강호동';
 
-- EQUI조인(내부조인, 등가조인)만 해시조인을 사용
-- 해시조인은 선행 테이블을 결정하고 주어진 조건에 해당하는 행이 선택되면 조인키를 기준으로 하여 해시함수를 사용해서 해시테이블을 메인 메모리에 생성하고 후행 테이블에서 조건을 만족하는 행을 찾음
-- 후행 테이블의 조인키를 사용해서 해시함수를 적용하여 해당 버킷을 검색하고 알맞은 것을 출력한다.
-- USERTBL , BUYTBL 전체를 읽은 다음에(TABLE ACCESS FULL) 해시 함수를 사용해서 테이블을 연결한다.

-- 아래 쿼리는 에러가 발생한다. 이유는? '컬럼의 모호성'
-- USERTBL, BUYTBL에 같은 USERID가 존재하므로 어떤 테이블에 있는 USERID를 출력할 지 오라클 엔진이 애매하다면서 에러를 발생시킴
SELECT USERID, USERNAME, PRODNAME, ADDR
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID;
 
-- 해결방법: 모호성을 해결하기 위해 테이블명.컬럼명으로 변경
SELECT USERTBL.USERID, USERTBL.USERNAME, BUYTBL.PRODNAME, USERTBL.ADDR
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID;
-- 코드를 간결하게 하기 위해 테이블에 알리아스(별칭)을 부여
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR
 FROM USERTBL U
 INNER JOIN BUYTBL B
 ON U.USERID = B.USERID;
 
-- INTERSECT 연산: 두 개의 테이블에서 교집합을 조회. 단, 교집합의 조건이 되는 값을 컬럼값으로 지정해야 한다.
SELECT USERID FROM USERTBL
INTERSECT
SELECT USERID FROM BUYTBL;


-- 외부조인(OUTER JOIN)
-- 외부조인은 두 개의 테이블 간의 교집합을 조회하고 한 쪽 테이블에만 있는 데이터를 전부 다 포함시켜서 출력하는 방법 (A-B)
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "연락처"
 FROM USERTBL U, BUYTBL B
WHERE U.USERID = B.USERID(+); -- (+)구문은 오라클에서만 적용

-- ISO표준의 LEFT OUTER JOIN
-- LEFT OUTER JOIN 키워드를 중심으로 좌측 테이블의 내용을 전부 출력   
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "연락처"
 FROM USERTBL U
 LEFT OUTER JOIN BUYTBL B
 ON U.USERID = B.USERID;
 
-- ISO표준의 RIGHT OUTER JOIN
-- RIGHT OUTER JOIN 키워드를 중심으로 우측 테이블의 내용을 전부 출력
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "연락처"
 FROM BUYTBL B
 RIGHT OUTER JOIN USERTBL U
 ON U.USERID = B.USERID;
 
-- ISO표준의 FULL OUTER JOIN
-- FULL OUTER JOIN은 2개의 테이블의 내용을 전부 출력 
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "연락처"
 FROM BUYTBL B
 FULL OUTER JOIN USERTBL U
 ON U.USERID = B.USERID;

 
-- CROSS JOIN(상호 조인): 조건 구문 없이 2개의 테이블을 하나로 만듦 -> 카테시안 곱이 발생
-- 카디널러티: 한 테이블에 있는 레코드의 수
-- USERTBL 10 레코드, BUYTBL 12 레코드
-- 카테시안 곱: 10*12 = 120
-- MERGE JOIN으로 실행결과가 출력된다
SELECT *
 FROM USERTBL, BUYTBL;
 
SELECT *
 FROM USERTBL CROSS JOIN BUYTBL;