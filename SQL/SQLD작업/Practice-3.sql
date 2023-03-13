-- 뷰 생성
CREATE VIEW V_EMP 
  AS SELECT EMPNO, ENAME
       FROM EMP;

-- 뷰 조회
SELECT * FROM V_EMP;

-- 뷰에 데이터 삽입 불가능
INSERT INTO V_EMP VALUES('102', '주재용');

-- 뷰의 데이터를 삭제하면 실제 테이블의 데이터도 삭제됨 (권장되는 방법X)
DELETE FROM V_EMP
WHERE EMPNO = 100;

COMMIT;
SELECT * FROM EMP;

-- 뷰에 ALTER문은 적용되지 않음
ALTER VIEW V_EMP
ADD (AGE NUMBER(2) DEFAULT 1);

-- 뷰 삭제
DROP VIEW V_EMP;

DESC EMP;
-- 원하는 컬럼을 선택하여 데이터 저장 가능. NOT NULL 제약조건이 있는 컬럼은 반드시 데이터를 입력해야한다. 
INSERT INTO EMP(EMPNO, ENAME, DEPTNO) VALUES (102, '주재용', '1001');
INSERT INTO EMP VALUES (100, '주예린', 2961, '1000', SYSDATE);
INSERT INTO DEPT VALUES ('1002', '관리팀');
SELECT * FROM DEPT;

-- 테이블 복사
-- 테이블을 생성한 뒤 INSERT 구문으로 테이블 복사
CREATE TABLE DEPT_TEST(
    DEPT_CODE INT PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);
INSERT INTO DEPT_TEST
SELECT * FROM DEPT;

SELECT * FROM DEPT_TEST;

-- NOLOGGING: 로그파일의 기록을 최소화하면서 입력시 성능을 향상시키는 방법, BUFFER CACHE라는 메모리 영역을 생략하고 바로 기록
ALTER TABLE DEPT NOLOGGING;

-- UPDATE: 저장된 레코드의 컬럼 값을 수정할 떄 사용, 사용시 조건(WHERE절)을 사용하지 않으면 전체 레코드가 다 변경되므로 주의
SELECT * FROM EMP;

UPDATE EMP
   SET EMP_NAME = '한국'
 WHERE EMPNO = 1000;
 
COMMIT;

-- DELETE: 저장된 레코드의 컬럼 값을 삭제할 때 사용, 사용시 조건(WHERE절)을 사용하지 않으면 전체 레코드가 다 삭제되므로 주의
-- DELETE문은 DML구문이므로 TCL구문이 적용됨
SELECT * FROM EMP;

DELETE FROM EMP
WHERE EMPNO = 1001;

COMMIT;

-- TRUNCATE: 테이블 구조는 남겨둔 채, 모든 데이터를 삭제. DDL 구문이므로 ROLLBACK(TCL)이 적용되지 않음.
TRUNCATE TABLE EMP;