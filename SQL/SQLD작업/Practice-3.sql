-- �� ����
CREATE VIEW V_EMP 
  AS SELECT EMPNO, ENAME
       FROM EMP;

-- �� ��ȸ
SELECT * FROM V_EMP;

-- �信 ������ ���� �Ұ���
INSERT INTO V_EMP VALUES('102', '�����');

-- ���� �����͸� �����ϸ� ���� ���̺��� �����͵� ������ (����Ǵ� ���X)
DELETE FROM V_EMP
WHERE EMPNO = 100;

COMMIT;
SELECT * FROM EMP;

-- �信 ALTER���� ������� ����
ALTER VIEW V_EMP
ADD (AGE NUMBER(2) DEFAULT 1);

-- �� ����
DROP VIEW V_EMP;

DESC EMP;
-- ���ϴ� �÷��� �����Ͽ� ������ ���� ����. NOT NULL ���������� �ִ� �÷��� �ݵ�� �����͸� �Է��ؾ��Ѵ�. 
INSERT INTO EMP(EMPNO, ENAME, DEPTNO) VALUES (102, '�����', '1001');
INSERT INTO EMP VALUES (100, '�ֿ���', 2961, '1000', SYSDATE);
INSERT INTO DEPT VALUES ('1002', '������');
SELECT * FROM DEPT;

-- ���̺� ����
-- ���̺��� ������ �� INSERT �������� ���̺� ����
CREATE TABLE DEPT_TEST(
    DEPT_CODE INT PRIMARY KEY,
    DEPT_NAME VARCHAR(30)
);
INSERT INTO DEPT_TEST
SELECT * FROM DEPT;

SELECT * FROM DEPT_TEST;

-- NOLOGGING: �α������� ����� �ּ�ȭ�ϸ鼭 �Է½� ������ ����Ű�� ���, BUFFER CACHE��� �޸� ������ �����ϰ� �ٷ� ���
ALTER TABLE DEPT NOLOGGING;

-- UPDATE: ����� ���ڵ��� �÷� ���� ������ �� ���, ���� ����(WHERE��)�� ������� ������ ��ü ���ڵ尡 �� ����ǹǷ� ����
SELECT * FROM EMP;

UPDATE EMP
   SET EMP_NAME = '�ѱ�'
 WHERE EMPNO = 1000;
 
COMMIT;

-- DELETE: ����� ���ڵ��� �÷� ���� ������ �� ���, ���� ����(WHERE��)�� ������� ������ ��ü ���ڵ尡 �� �����ǹǷ� ����
-- DELETE���� DML�����̹Ƿ� TCL������ �����
SELECT * FROM EMP;

DELETE FROM EMP
WHERE EMPNO = 1001;

COMMIT;

-- TRUNCATE: ���̺� ������ ���ܵ� ä, ��� �����͸� ����. DDL �����̹Ƿ� ROLLBACK(TCL)�� ������� ����.
TRUNCATE TABLE EMP;