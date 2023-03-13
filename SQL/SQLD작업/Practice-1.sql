-- table 만들기 (DDL 구문)
CREATE TABLE EMP(
    EMPNO INT PRIMARY KEY,
    EMP_NAME VARCHAR(30) NOT NULL,
    AGE INT NOT NULL,
    SAL INT NOT NULL,
    DEPT_CODE VARCHAR(5) NOT NULL
);

-- table 수정 (DDL 구문)
ALTER TABLE EMP MODIFY DEPT_CODE INT;
ALTER TABLE EMP MODIFY DEPT_CODE VARCHAR(5);
-- table 삭제 (DDL 구문)
DROP TABLE EMP;

-- TABLE 조회 (DML 구문)
-- AS는 ALLIAS의 약자로 별칭을 사용하여 가독성을 좋게 만들어 준다.
SELECT EMPNO AS "사원번호", EMP_NAME AS "이름", AGE AS "나이", SAL AS "연봉", DEPT_CODE AS "부서코드"
FROM EMP; 

-- 데이터 입력 (DML 구문)
INSERT INTO EMP VALUES(1000, '주예린', 28, 10000, '001');
INSERT INTO EMP VALUES(1001, '신희경', 56, 21000, '002');
INSERT INTO EMP VALUES(1002, '주재용', 57, 32000, '003');
-- 데이터 삭제 (조건: empno가 1000인 데이터 삭제) (DML 구문)
DELETE FROM EMP 
WHERE EMPNO = 1000; 

-- TCL의 한 명령어로 물리적인 저장장치(서버, HDD, SSD 등)에 보내기 전에 이전 상태로 돌리는 명령어
-- DML 구문(INSERT, DELETE, UPDATE)에 사용할 때 적용 가능
ROLLBACK;
-- TCL의 한 명령어로 물리적인 저장장치(서버, HDD, SSD 등)에 보낸다. 한 번 COMMIT 된 내용은 ROLLBACK이 되지 않음
COMMIT;


CREATE TABLE DEPT(
    DEPT_CODE INT PRIMARY KEY,
    DEPT_NAME VARCHAR(30) 
);

DROP TABLE DEPT;