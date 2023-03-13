-- DUAL ���̺�: ����Ŭ���� �����ϴ� ���� ���̺�
DESC DUAL;

-- ������ �Լ�(������): ����Ŭ �������� �����ϴ� �Լ�
-- ASCII('����') -> �ƽ�Ű�ڵ�� ���
-- SUBSTR() -> ���ڿ��� �ڸ��� �Լ�
-- LENGTHB(���ڿ�) -> �ش� ���ڿ��� ����Ʈ ũ��(�ѱ�:3byte/ ����:1byte)
-- LTRIM() -> ���� ���� ���� �Լ�
-- RTRIM() -> ���� ���� ���� �Լ�
-- TRIM() -> �¿��� ���� ���� �Լ�
-- CHR() -> �ƽ�Ű�ڵ� ���� �ش��ϴ� ���ڸ� ���
SELECT ASCII('A'), SUBSTR('ABCDEFG', 3, 4), LENGTH('ȫ�浿'), LENGTHB('ȫ�浿'), LENGTH(LTRIM(' ȫ')),
 LENGTH(RTRIM('ȫ ')), LENGTH(TRIM(' ȫ ')), CHR(97)
 FROM DUAL;
-- CONCAT(): ���ڿ��� �������ִ� �Լ�
-- ||: ���ڿ� ���� ������
SELECT CONCAT('������ ','���־�'), '���ڵ� '||'���־�'
 FROM DUAL;
-- LOWER(): �����ڸ� �ҹ��ڷ� ����
-- UPPER(): �����ڸ� �빮�ڷ� ����
SELECT LOWER('ABCDeee'), UPPER('ABCDeee')
 FROM DUAL;

-- ������ �Լ�(��¥��)
-- SYSDATE: ���� ��¥ ���
-- EXTRACT: ��, ��, �� ����
SELECT SYSDATE, EXTRACT(YEAR FROM SYSDATE), EXTRACT(MONTH FROM SYSDATE), EXTRACT(DAY FROM SYSDATE)
 FROM DUAL;

-- TO_CHAR(): ����ȯ �Լ�, ���˿� �°� ��¥�� �ð� ǥ��
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS AM')
 FROM DUAL;
 
-- ������ �Լ�(������)
-- ABS(): ���밪�� ���ϴ� �Լ�
-- SIGN(): ���, 0, ���������� Ȯ���ϴ� �Լ�
-- MOD(): �������� ���ϴ� �Լ�
-- CEIL(): ������ �ø��ϴ� �Լ�(���ں��� ũ�ų� ���� �ּ��� ������ ����)
-- FLOOR(): ������ �����ϴ� �Լ�(���ں��� �۰ų� ���� �ִ��� ������ ����)
-- ROUND(�Ǽ�, �ڸ���): �ڸ����� ����µ� �ݿø� ó�� 
-- TRUNC(�Ǽ�, �ڸ���): �ڸ����� ����µ� ���� ó��
SELECT ABS(-1), SIGN(0), MOD(11, 4), CEIL(10.1), FLOOR(10.9), ROUND(16.255, 2), TRUNC(16.255, 2)
 FROM DUAL;


-- DECODE(): IF������ ���� ����
-- DECODE() �Լ��� �÷����� �񱳰��� ���ؼ� �� ����� ���̸� 3��° ���ڰ��� ����, �����̸� 4��° ���ڰ��� ����
SELECT DECODE(EMPNO, 1000, 'TRUE','FALSE')
 FROM EMP;
 
SELECT DECODE(MGR, NULL, 'NULL', 'NOT NULL')
 FROM EMP;

-- CASE��: ���α׷��� ���ó�� ���ǹ� ���
SELECT CASE
    WHEN EMPNO < 1003 THEN 'A'
    WHEN EMPNO < 1008 THEN 'B'
    ELSE 'C'
    END
 FROM EMP;
 
-- DEPTNO�� 10���̸� �λ���, 20���̸� �ѹ���, 30���̸� ������, �� �� �������� �μ��������� ǥ���Ͻÿ�. ��, CASE�� �̿�
SELECT CASE
    WHEN DEPTNO = 10 THEN '�λ���'
    WHEN DEPTNO = 20 THEN '�ѹ���'
    WHEN DEPTNO = 30 THEN '������'
    ELSE '�μ� ����'
    END
 FROM EMP;