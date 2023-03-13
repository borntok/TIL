-- ������ �Լ�: ��� �� ���� ���踦 �����ϱ� ���� �����Ǵ� �Լ�
-- ����, �հ�, ���, �� ��ġ ���� ������ �� ����
-- UNBOUNDED PRECEDING: ù ��° ��
-- UNBOUNDED FOLLOWING: ������ ��
-- TOTSAL���� ó������ ������ ������� �հ谡 ��
SELECT EMPNO, ENAME, SAL,
       SUM(SAL) OVER(ORDER BY SAL
                     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) TOTSAL
  FROM EMP;
  
-- CURRUNT ROW: ���� ��
-- ó������ ���� ���� ���ϰ� �� ���� ���� ���ؼ� ������ ���
SELECT EMPNO, ENAME, SAL,
       SUM(SAL) OVER(ORDER BY SAL
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) TOTSAL
  FROM EMP;
  
-- ���� �Լ�: RANK,DENSE_RANK, ROW_NUMBER
SELECT ENAME, SAL, JOB,
       RANK() OVER(ORDER BY SAL DESC) ALL_RANK,
       RANK() OVER(PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
  FROM EMP;
  
SELECT ENAME, SAL, JOB,
       RANK() OVER(ORDER BY SAL DESC) ALL_RANK,
       DENSE_RANK() OVER(ORDER BY SAL DESC) DENSE_RANK,
       ROW_NUMBER() OVER(ORDER BY SAL DESC) ROW_NUMBER
  FROM EMP;
  
-- ���� �Լ�: SUM, AVG, COUNT, MAX, MIN
SELECT ENAME, MGR, SAL,
       SUM(SAL) OVER(PARTITION BY MGR) SUM_MGR
 FROM EMP;
 
-- �� ���� ���� �Լ�: FIRST_VALUE, LAST_VALUE, LAG, LEAD
-- FIRST_VALUE: ��Ƽ�ǿ��� ��ȸ�� �� �߿��� ù ���� FETCH�� �Ǵ� ���� ���� ���
-- �μ��� �޿��� ���� ���� ����� ����
SELECT DEPTNO, ENAME, SAL,
       FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) AS DEPT_A
  FROM EMP;

-- LAST_VALUE: ��Ƽ�ǿ��� ������ ���� ������ ��
-- BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING: ���� ����� ������ ������� ����
SELECT DEPTNO, ENAME, SAL,
       LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS DEPT_A
  FROM EMP;
  
-- LAG: ���� ���� ���� ���
SELECT DEPTNO, ENAME, SAL,
       LAG(SAL) OVER (ORDER BY SAL DESC) AS PRE_SAL
  FROM EMP;

-- LEAD: ������ ��ġ�� ���� ������. �Ű����� �߿��� 2�� ���� �࿡�� 2��ŭ �̵��� ��ġ�� ���� ���, �������� ���� ������ �⺻���� 1�̴�.
SELECT DEPTNO, ENAME, SAL,
       LEAD(SAL, 2) OVER (ORDER BY SAL DESC) AS PRE_SAL
  FROM EMP;

-- ���� ���� �Լ�: CUME_DIST, PERCENT_RANK, NTITLE, RATIO_TO_REPORT
-- PERCENT_RANK: ��Ƽ�Ǻ��� 0���� 1���� ���� �ۼ�Ʈ�� ���
SELECT DEPTNO, ENAME, SAL, 
       ROUND(PERCENT_RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC), 2) AS PERCENT_SAL
  FROM EMP;
  
-- CUME_DIST: ù ��° �൵ ������� �����Ű�� ���� ������� ���
-- ����������� ���� 0~1 ������ ���� ����
SELECT DEPTNO, ENAME, SAL,
       ROUND(CUME_DIST() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC), 2) AS PERCENT_SAL
  FROM EMP;
  
-- NTILE: �Ű������� ���� �������� ���� ���� ���ҵǾ� ���. ���� ������ ������ �������� ���� ��� ����Ŭ ������ �˾Ƽ� ������.
SELECT DEPTNO, ENAME, SAL, 
       NTILE(4) OVER (ORDER BY SAL DESC) AS N_TILE
  FROM EMP;