-- 부모 테이블 만들기
CREATE TABLE DEPT(
    DEPTNO VARCHAR2(4) PRIMARY KEY,
    DEPTNAME VARCHAR2(20)
);

INSERT INTO DEPT VALUES('1000', '인사팀');
INSERT INTO DEPT VALUES('1001', '총무팀');

SELECT * FROM DEPT;

COMMIT;

-- 자식 테이블 만들기
CREATE TABLE EMP(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 2) DEFAULT 0, -- DEFAULT 제약조건: 값을 입력하지 않을 경우 기본값 0으로 저장
    DEPTNO VARCHAR2(4) NOT NULL,
    CREATEDATE DATE DEFAULT SYSDATE, -- SYSDATE: 현재 PC의 날짜, 시간이 기본값으로 저장
    CONSTRAINT EMPPK PRIMARY KEY(EMPNO), -- EMP 테이블의 EMPNO 컬럼을 EMPPK라는 이름으로 기본키 설정
    -- 외래키 설정 시 DEPTFK 이름으로 DEPT 테이블의 DEPTNO와 참조하게 하는 제약조건
    CONSTRAINT DEPTFK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO) 
    ON DELETE CASCADE -- 자신이 참조하고 있는 부모 테이블의 데이터가 삭제되면 자식 테이블에 해당되는 데이터가 같이 삭제 -> "참조 무결성"을 지킬 수 있음
    -- 부모 테이블에는 해당 데이터가 없는데 자식 테이블에 해당 데이터가 있는 경우 참조 무결성 위배로 볼 수 있음
);

INSERT INTO EMP VALUES(100, '주예린', 2961, '1000', SYSDATE);
INSERT INTO EMP VALUES(101, '신희경', 1320, '1001', SYSDATE);
-- 부모 테이블의 부서 코드가 없으므로 무결성 제약조건 위반
INSERT INTO EMP VALUES(102, '주재용', 4000, '1002', SYSDATE);

COMMIT;
SELECT * FROM EMP;

-- DESC(DESCRIBE)명령어는 간단하게 테이블 구조를 확인하는 명령어이다.
DESC DEPT;
DESC EMP;
-- 부모 테이블인 DEPT는 EMP 테이블이 참조하고 있으므로(외래키에 의해 참조되는 고유/기본 키가 테이블에 존재하므로) 삭제되지 않는다.
DROP TABLE DEPT;
-- 부모 테이블과 자식 테이블이 같이 외래키 제약조건을 가지고 있을 때는, 항상 자식 테이블을 먼저 삭제한 뒤 부모 테이블을 삭제해야 한다.
DROP TABLE EMP;
DROP TABLE DEPT;


SELECT * FROM DEPT;
SELECT * FROM EMP;

-- 부모 테이블의 레코드 중 1000번 인사팀 삭제
DELETE FROM DEPT
WHERE DEPTNO = '1001';
COMMIT;

-- 테이블명 수정: ALTER TABLE ~ RENAME TO 구문 사용
ALTER TABLE EMP 
RENAME TO NEW_EMP;

ALTER TABLE NEW_EMP
RENAME TO EMP;

-- 테이블에 컬럼 추가
ALTER TABLE EMP
ADD (AGE NUMBER(2) DEFAULT 1);

-- 테이블 컬럼 변경
ALTER TABLE EMP
MODIFY (ENAME VARCHAR2(50) NULL);

-- 데이터 타입을 변경할 때, 변경할 테이블에 데이터가 존재하면 에러가 발생
ALTER TABLE EMP
MODIFY (SAL VARCHAR2(10) NOT NULL);

-- 컬럼 삭제
ALTER TABLE EMP
DROP COLUMN AGE;

-- 컬럼명 변경
ALTER TABLE EMP
RENAME COLUMN ENAME TO NEW_ENAME;

-- 테이블 제약조건 삭제
DROP TABLE EMP CASCADE CONSTRAINTS;

