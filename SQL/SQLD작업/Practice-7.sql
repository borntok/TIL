-- ROWNUM: ����Ŭ �����ͺ��̽��� SELECT���� ����� ���� ������ �Ϸ� ��ȣ�� �ο�, ���� ���� �� �� ���
-- �������� ������ ����ϱ� ���ؼ� �ζ��κ並 ���
-- �ζ��� ��: FROM���� �������� ��ü�� �ǹ�
SELECT * -- ��������
FROM (SELECT * FROM EMP) LIST -- ��������

-- ROWNUM���� ��µǴ� ������ �� ����
SELECT *
 FROM EMP
WHERE ROWNUM <= 1;

-- �ζ��� �並 ����Ͽ� EMP ���̺��� ��� �����͸� 5���� ����(SQL SERVER: TOP(), MYSQL: LIMIT�� ���� ���)
SELECT *
 FROM (SELECT ROWNUM LIST, ENAME FROM EMP) -- �ζ��� �� ���
WHERE LIST <= 5;

-- �� �Խ��ǿ��� ���� ���Ǵ� ������
SELECT *
 FROM (SELECT ROWNUM LIST, ENAME FROM EMP)
WHERE LIST BETWEEN 6 AND 10;

-- ROWID: ����Ŭ �����ͺ��̽� ������ �����͸� ������ �� �ִ� ������ ��, �����͸� ������ �� ����Ŭ ������ �ڵ����� �����ϴ� ��
-- �����Ͱ� � ������ �����̳� ��� ��Ͽ� ����Ǿ� �ִ��� �� �� �ִ�
-- ROWID ����: ������Ʈ, ��� ���� ��ȣ, ��� ��ȣ, ������ ��ȣ
SELECT ROWID, ENAME
 FROM EMP;
 
-- WITH ����: ���������� ����ؼ� �ӽ����̺��̳� ��ó�� ��� ����
-- �������� ��Ͽ� ��Ī ��� ����, ��Ƽ�������� SQL������ ����� �ζ��� �䳪 �ӽ����̺�� �Ǵ�
WITH V_DATA AS (
  SELECT * FROM EMP
  UNION ALL -- �� ���̺� ����(�ߺ� ������ ����) / UNION�� �ߺ� ������X
  SELECT * FROM EMP)
SELECT *
 FROM V_DATA
WHERE EMPNO = 1000;

-- EMP ���̺��� �μ���ȣ�� 20�� �Ϳ� ���� �ӽ����̺��� ����� ��ȸ (WITH ���� ���)
WITH V_EMP AS (
  SELECT *
  FROM EMP
  WHERE DEPTNO = 20)
SELECT * FROM V_EMP;