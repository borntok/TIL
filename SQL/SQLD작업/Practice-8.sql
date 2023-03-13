-- DCL(DATA CONTROL LANGUAGE)
-- GRANT: 데이터베이스 사용자에게 권한을 부여
-- 데이터를 사용하기 위해서는 권한이 필요하며 연결, 입력, 수정, 삭제, 조회를 할 수 있다

-- 계정 생성
SHOW USER;

-- 해당 DB 우클릭 -> 접속해제 -> SYSTEM 계정으로 접속
CONNECT SYSTEM/0823 -- SQL PLUS에서만 적용
SHOW USER;

CREATE USER C##TEST IDENTIFIED BY 1234;
COMMIT;

SELECT * FROM EMP;

-- C##TEST 계정에게 접속, 자원에 대한 권한 부여
GRANT CONNECT, RESOURCE TO C##TEST;
COMMIT;

-- C##TEST계정으로 EMP 테이블을 조회하면 테이블이 존재하지 않는다는 메시지가 출력됨 -> EMP 테이블에 대한 권한이 없기 때문
SELECT * FROM EMP;

-- C##TEST에게 SELECT, INSERT, UPDATE 권한을 부여 
GRANT SELECT,INSERT, UPDATE
  ON EMP
  TO C##TEST;
COMMIT;

SHOW USER;
-- C##JYR 계정에서 만들어진 EMP 테이블을 조회
SELECT *
 FROM C##JYR.EMP;
-- DELETE에 대한 권한은 주지 않았으므로 삭제 불가능
DELETE FROM C##JYR.EMP
WHERE C##JYR.EMP.EMPNO = 1000;
-- UPDATE에 대한 권한을 주었으므로 수정 가능
UPDATE C##JYR.EMP
   SET ENAME = '주예린'
 WHERE EMPNO = 1000;
COMMIT;

-- REVOKE: 주어진 권한을 회수하는 명령어
REVOKE INSERT, UPDATE
    ON EMP
  FROM C##TEST;
COMMIT;

-- 권한을 회수한 후 C##TEST로 접속
UPDATE C##JYR.EMP
   SET ENAME = '킹예린'
 WHERE EMPNO = 1000;
 
 
-- TCL(TRANSACTION CONTROL LANGUAGE): COMMIT, ROLLBACK, SAVEPOINT
UPDATE EMP
   SET ENAME = '킹예린'
 WHERE EMPNO = 1000;
 
SELECT * FROM EMP;
COMMIT; -- 커밋이 이루어 지면 ROLLBACK이 되지 않음
ROLLBACK;

UPDATE EMP
   SET ENAME = '주예린'
 WHERE EMPNO = 1000;

ROLLBACK; -- 커밋이 되지 않은 상태에서는 얼마든지 ROLLBACK 가능
SELECT * FROM EMP;

-- SAVEPOINT: 트랜잭션을 작게 분할하여 관리하는 것, 지정된 위치에서만 ROLLBACK 가능
UPDATE EMP
   SET ENAME = '이정후'
 WHERE EMPNO = 1000;

SAVEPOINT LEE;

UPDATE EMP
   SET ENAME = '조규성'
 WHERE EMPNO = 1001;
 
SAVEPOINT JOE;

SELECT * FROM EMP;
-- 조규성은 ROLLBACK됨
ROLLBACK TO LEE;