-- ROWNUM: 오라클 데이터베이스의 SELECT문의 결과에 대한 논리적인 일련 번호를 부여, 행의 제한 걸 때 사용
-- 페이지의 단위를 출력하기 위해서 인라인뷰를 사용
-- 인라인 뷰: FROM절에 서브쿼리 자체를 의미
SELECT * -- 메인쿼리
FROM (SELECT * FROM EMP) LIST -- 서브쿼리

-- ROWNUM으로 출력되는 데이터 수 제한
SELECT *
 FROM EMP
WHERE ROWNUM <= 1;

-- 인라인 뷰를 사용하여 EMP 테이블의 출력 데이터를 5개로 제한(SQL SERVER: TOP(), MYSQL: LIMIT과 같은 기능)
SELECT *
 FROM (SELECT ROWNUM LIST, ENAME FROM EMP) -- 인라인 뷰 사용
WHERE LIST <= 5;

-- 웹 게시판에서 많이 사용되는 쿼리문
SELECT *
 FROM (SELECT ROWNUM LIST, ENAME FROM EMP)
WHERE LIST BETWEEN 6 AND 10;

-- ROWID: 오라클 데이터베이스 내에서 데이터를 구분할 수 있는 유일한 값, 데이터를 저장할 때 오라클 엔진이 자동으로 생성하는 값
-- 데이터가 어떤 데이터 파일이나 어느 블록에 저장되어 있는지 알 수 있다
-- ROWID 구조: 오브젝트, 상대 파일 번호, 블록 번호, 데이터 번호
SELECT ROWID, ENAME
 FROM EMP;
 
-- WITH 구문: 서브쿼리를 사용해서 임시테이블이나 뷰처럼 사용 가능
-- 서브쿼리 블록에 별칭 사용 가능, 옵티마이저가 SQL구문의 결과를 인라인 뷰나 임시테이블로 판단
WITH V_DATA AS (
  SELECT * FROM EMP
  UNION ALL -- 두 테이블 병합(중복 데이터 포함) / UNION은 중복 데이터X
  SELECT * FROM EMP)
SELECT *
 FROM V_DATA
WHERE EMPNO = 1000;

-- EMP 테이블에서 부서번호가 20인 것에 대한 임시테이블을 만들고 조회 (WITH 구문 사용)
WITH V_EMP AS (
  SELECT *
  FROM EMP
  WHERE DEPTNO = 20)
SELECT * FROM V_EMP;