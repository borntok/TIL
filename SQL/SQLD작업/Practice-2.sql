-- �θ� ���̺� �����
CREATE TABLE DEPT(
    DEPTNO VARCHAR2(4) PRIMARY KEY,
    DEPTNAME VARCHAR2(20)
);

INSERT INTO DEPT VALUES('1000', '�λ���');
INSERT INTO DEPT VALUES('1001', '�ѹ���');

SELECT * FROM DEPT;

COMMIT;

-- �ڽ� ���̺� �����
CREATE TABLE EMP(
    EMPNO NUMBER(10),
    ENAME VARCHAR2(20) NOT NULL,
    SAL NUMBER(10, 2) DEFAULT 0, -- DEFAULT ��������: ���� �Է����� ���� ��� �⺻�� 0���� ����
    DEPTNO VARCHAR2(4) NOT NULL,
    CREATEDATE DATE DEFAULT SYSDATE, -- SYSDATE: ���� PC�� ��¥, �ð��� �⺻������ ����
    CONSTRAINT EMPPK PRIMARY KEY(EMPNO), -- EMP ���̺��� EMPNO �÷��� EMPPK��� �̸����� �⺻Ű ����
    -- �ܷ�Ű ���� �� DEPTFK �̸����� DEPT ���̺��� DEPTNO�� �����ϰ� �ϴ� ��������
    CONSTRAINT DEPTFK FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO) 
    ON DELETE CASCADE -- �ڽ��� �����ϰ� �ִ� �θ� ���̺��� �����Ͱ� �����Ǹ� �ڽ� ���̺� �ش�Ǵ� �����Ͱ� ���� ���� -> "���� ���Ἲ"�� ��ų �� ����
    -- �θ� ���̺��� �ش� �����Ͱ� ���µ� �ڽ� ���̺� �ش� �����Ͱ� �ִ� ��� ���� ���Ἲ ����� �� �� ����
);

INSERT INTO EMP VALUES(100, '�ֿ���', 2961, '1000', SYSDATE);
INSERT INTO EMP VALUES(101, '�����', 1320, '1001', SYSDATE);
-- �θ� ���̺��� �μ� �ڵ尡 �����Ƿ� ���Ἲ �������� ����
INSERT INTO EMP VALUES(102, '�����', 4000, '1002', SYSDATE);

COMMIT;
SELECT * FROM EMP;

-- DESC(DESCRIBE)��ɾ�� �����ϰ� ���̺� ������ Ȯ���ϴ� ��ɾ��̴�.
DESC DEPT;
DESC EMP;
-- �θ� ���̺��� DEPT�� EMP ���̺��� �����ϰ� �����Ƿ�(�ܷ�Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �����ϹǷ�) �������� �ʴ´�.
DROP TABLE DEPT;
-- �θ� ���̺�� �ڽ� ���̺��� ���� �ܷ�Ű ���������� ������ ���� ����, �׻� �ڽ� ���̺��� ���� ������ �� �θ� ���̺��� �����ؾ� �Ѵ�.
DROP TABLE EMP;
DROP TABLE DEPT;


SELECT * FROM DEPT;
SELECT * FROM EMP;

-- �θ� ���̺��� ���ڵ� �� 1000�� �λ��� ����
DELETE FROM DEPT
WHERE DEPTNO = '1001';
COMMIT;

-- ���̺�� ����: ALTER TABLE ~ RENAME TO ���� ���
ALTER TABLE EMP 
RENAME TO NEW_EMP;

ALTER TABLE NEW_EMP
RENAME TO EMP;

-- ���̺� �÷� �߰�
ALTER TABLE EMP
ADD (AGE NUMBER(2) DEFAULT 1);

-- ���̺� �÷� ����
ALTER TABLE EMP
MODIFY (ENAME VARCHAR2(50) NULL);

-- ������ Ÿ���� ������ ��, ������ ���̺� �����Ͱ� �����ϸ� ������ �߻�
ALTER TABLE EMP
MODIFY (SAL VARCHAR2(10) NOT NULL);

-- �÷� ����
ALTER TABLE EMP
DROP COLUMN AGE;

-- �÷��� ����
ALTER TABLE EMP
RENAME COLUMN ENAME TO NEW_ENAME;

-- ���̺� �������� ����
DROP TABLE EMP CASCADE CONSTRAINTS;

