-- ��������: WHERE������ SELECT���� �ϳ��� ���������� �����ϴ� ���� �ǹ�
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > 177;

-- �������� -> �������� ������ ����
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > (SELECT HEIGHT 
                FROM USERTBL 
                WHERE USERNAME = '��븸');
                
-- �ζ��� ��: FROM���� ���� ��������, ������ ���̺��� ����� ����
SELECT *
 FROM (SELECT ROWNUM ID, PRODNAME  
        FROM BUYTBL) -- FROM������ ���������� ������ ���̺��� ������ִ� �ζ��� ��
WHERE ID < 5;

-- ������ ��������: �ݵ�� �� �ุ ��ȸ�ؼ� ���� --> �񱳿�����(>,>=,<,<=,=,<>) ���
-- ������ ��������: ���� ���� �� ���� ���� --> ANY, SOME, IN, ALL, EXISTS

-- ������ ������������ ������������ �����ϴ� ���ڵ尡 2���̹Ƿ� �񱳴���� �ָ��Ͽ� ���� �߻�
SELECT USERNAME, HEIGHT
 FROM USERTBL
WHERE HEIGHT > (SELECT HEIGHT
                 FROM USERTBL
                WHERE ADDR = '�泲');
                
-- ANY: OR�� ����� ����
-- 170 �ʰ� �Ǵ� 173 �ʰ��̹Ƿ� 170 �ʰ��Ǵ� �� ���
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT > ANY (SELECT HEIGHT
                     FROM USERTBL
                     WHERE ADDR = '�泲');
                     
-- SOME: ANY�� ������ ���
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT = SOME (SELECT HEIGHT
                        FROM USERTBL
                       WHERE ADDR = '�泲');
                       
-- ALL: ���������� ������� ��� �����ϴ� �����͸� ��� (AND�� ����)
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT > ALL (SELECT HEIGHT
                       FROM USERTBL
                      WHERE ADDR = '�泲');

-- IN: ���������� ������� �����ϴ� ������ ���
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT IN (SELECT HEIGHT
                    FROM USERTBL
                   WHERE ADDR = '����');

-- NOT IN: ���������� ������� �������� �ʴ� ������ ���
SELECT USERNAME, HEIGHT
 FROM USERTBL
 WHERE HEIGHT NOT IN (SELECT HEIGHT
                        FROM USERTBL
                       WHERE ADDR = '����');
                       
-- EXISTS: ���������� � �������� ���� ���θ� BOOLEAN������ ����
-- ��������� ��������->��������, ���� ����� ���ؼ� �����ϸ� ���, ������ ���X
SELECT *
 FROM USERTBL U
WHERE EXISTS (SELECT *
                FROM BUYTBL B
               WHERE U.USERID = B.USERID);

-- ��Į�� ��������: �ݵ�� �� ��� �� �÷��� ��ȯ�ϴ� ��������
SELECT ENAME AS "�̸�", SAL AS "�޿�", 
       (SELECT ROUND(AVG(SAL), 2) FROM EMP) AS "��ձ޿�" -- ��Į�� ��������
  FROM EMP
 WHERE EMPNO = '1000';