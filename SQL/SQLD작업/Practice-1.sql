-- table ����� (DDL ����)
CREATE TABLE EMP(
    EMPNO INT PRIMARY KEY,
    EMP_NAME VARCHAR(30) NOT NULL,
    AGE INT NOT NULL,
    SAL INT NOT NULL,
    DEPT_CODE VARCHAR(5) NOT NULL
);

-- table ���� (DDL ����)
ALTER TABLE EMP MODIFY DEPT_CODE INT;
ALTER TABLE EMP MODIFY DEPT_CODE VARCHAR(5);
-- table ���� (DDL ����)
DROP TABLE EMP;

-- TABLE ��ȸ (DML ����)
-- AS�� ALLIAS�� ���ڷ� ��Ī�� ����Ͽ� �������� ���� ����� �ش�.
SELECT EMPNO AS "�����ȣ", EMP_NAME AS "�̸�", AGE AS "����", SAL AS "����", DEPT_CODE AS "�μ��ڵ�"
FROM EMP; 

-- ������ �Է� (DML ����)
INSERT INTO EMP VALUES(1000, '�ֿ���', 28, 10000, '001');
INSERT INTO EMP VALUES(1001, '�����', 56, 21000, '002');
INSERT INTO EMP VALUES(1002, '�����', 57, 32000, '003');
-- ������ ���� (����: empno�� 1000�� ������ ����) (DML ����)
DELETE FROM EMP 
WHERE EMPNO = 1000; 

-- TCL�� �� ��ɾ�� �������� ������ġ(����, HDD, SSD ��)�� ������ ���� ���� ���·� ������ ��ɾ�
-- DML ����(INSERT, DELETE, UPDATE)�� ����� �� ���� ����
ROLLBACK;
-- TCL�� �� ��ɾ�� �������� ������ġ(����, HDD, SSD ��)�� ������. �� �� COMMIT �� ������ ROLLBACK�� ���� ����
COMMIT;


CREATE TABLE DEPT(
    DEPT_CODE INT PRIMARY KEY,
    DEPT_NAME VARCHAR(30) 
);

DROP TABLE DEPT;