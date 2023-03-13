-- �׷��Լ�
-- 1. ROLLUP: ����Ŭ������ GROUP BY�� �÷��� ���� �Ұ�, �հ踦 ���ϴ� �Լ�
SELECT DECODE(DEPTNO, NULL, '��ü�հ�', ' ') TOT, -- DEPTNO�� NULL�̸� ��ü�հ踦 ���
       DECODE(DEPTNO, NULL, ' ', 10, '�λ���', 20, '������', 30, '������') "�μ�", -- �μ���ȣ�� NULL�̸� ����, 10�� �λ��� ������ ���
       SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO); -- ROLLUP �Լ��� �̿��ϸ� �μ��� �հ� �� ��ü�հ踦 ���� �� ����

-- �μ���, ������ ROLLUP�� �����ϸ� �μ��� �հ�, ������ �հ�, ��ü �հ谡 ��� ��ȸ�ȴ�.
SELECT DEPTNO, JOB, SUM(SAL)
 FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO;

-- 2. GROUPING: ROLLUP, CUBE, GROUPING SETS���� �����Ǵ� �հ� ���� �����ϱ� ���� ���
-- �Ұ�, �հ谡 �������� GROUPING �Լ��� 1�� �������ְ� �׷��� ������ 0�� ����
-- DECODE�Լ��� �Բ� ����ϸ� ���� ���ϴ� ������ ���·� �ۼ��ؼ� ���� ����
SELECT DEPTNO, 
       DECODE(GROUPING(DEPTNO),0, ' ','��ü�հ�') TOT,
       DECODE(GROUPING(JOB),0,' ', '�μ��հ�') TOT_DEPT, 
       SUM(SAL)
  FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY DEPTNO;

-- 3. GROUPING SETS: GROUP BY�� ������ �÷��� ������ ������� �پ��� �Ұ踦 ���� �� �ִ�
SELECT DEPTNO, JOB, SUM(SAL)
  FROM EMP
GROUP BY GROUPING SETS(JOB, DEPTNO) -- �÷����� ���������� ���. ������ ����X
ORDER BY DEPTNO, JOB;

-- 4. CUBE: ������ �÷��� ���ؼ� ���� ������ ��� ���踦 ���, ������ ����, �پ��� ������ �м�
SELECT DEPTNO, JOB, SUM(SAL)
  FROM EMP
GROUP BY CUBE(DEPTNO, JOB); -- ��ü�հ�, ������ �հ�, �μ��� �հ�, ������ �μ��� �հ�