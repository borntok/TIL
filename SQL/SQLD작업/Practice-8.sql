-- DCL(DATA CONTROL LANGUAGE)
-- GRANT: �����ͺ��̽� ����ڿ��� ������ �ο�
-- �����͸� ����ϱ� ���ؼ��� ������ �ʿ��ϸ� ����, �Է�, ����, ����, ��ȸ�� �� �� �ִ�

-- ���� ����
SHOW USER;

-- �ش� DB ��Ŭ�� -> �������� -> SYSTEM �������� ����
CONNECT SYSTEM/0823 -- SQL PLUS������ ����
SHOW USER;

CREATE USER C##TEST IDENTIFIED BY 1234;
COMMIT;

SELECT * FROM EMP;

-- C##TEST �������� ����, �ڿ��� ���� ���� �ο�
GRANT CONNECT, RESOURCE TO C##TEST;
COMMIT;

-- C##TEST�������� EMP ���̺��� ��ȸ�ϸ� ���̺��� �������� �ʴ´ٴ� �޽����� ��µ� -> EMP ���̺� ���� ������ ���� ����
SELECT * FROM EMP;

-- C##TEST���� SELECT, INSERT, UPDATE ������ �ο� 
GRANT SELECT,INSERT, UPDATE
  ON EMP
  TO C##TEST;
COMMIT;

SHOW USER;
-- C##JYR �������� ������� EMP ���̺��� ��ȸ
SELECT *
 FROM C##JYR.EMP;
-- DELETE�� ���� ������ ���� �ʾ����Ƿ� ���� �Ұ���
DELETE FROM C##JYR.EMP
WHERE C##JYR.EMP.EMPNO = 1000;
-- UPDATE�� ���� ������ �־����Ƿ� ���� ����
UPDATE C##JYR.EMP
   SET ENAME = '�ֿ���'
 WHERE EMPNO = 1000;
COMMIT;

-- REVOKE: �־��� ������ ȸ���ϴ� ��ɾ�
REVOKE INSERT, UPDATE
    ON EMP
  FROM C##TEST;
COMMIT;

-- ������ ȸ���� �� C##TEST�� ����
UPDATE C##JYR.EMP
   SET ENAME = 'ŷ����'
 WHERE EMPNO = 1000;
 
 
-- TCL(TRANSACTION CONTROL LANGUAGE): COMMIT, ROLLBACK, SAVEPOINT
UPDATE EMP
   SET ENAME = 'ŷ����'
 WHERE EMPNO = 1000;
 
SELECT * FROM EMP;
COMMIT; -- Ŀ���� �̷�� ���� ROLLBACK�� ���� ����
ROLLBACK;

UPDATE EMP
   SET ENAME = '�ֿ���'
 WHERE EMPNO = 1000;

ROLLBACK; -- Ŀ���� ���� ���� ���¿����� �󸶵��� ROLLBACK ����
SELECT * FROM EMP;

-- SAVEPOINT: Ʈ������� �۰� �����Ͽ� �����ϴ� ��, ������ ��ġ������ ROLLBACK ����
UPDATE EMP
   SET ENAME = '������'
 WHERE EMPNO = 1000;

SAVEPOINT LEE;

UPDATE EMP
   SET ENAME = '���Լ�'
 WHERE EMPNO = 1001;
 
SAVEPOINT JOE;

SELECT * FROM EMP;
-- ���Լ��� ROLLBACK��
ROLLBACK TO LEE;