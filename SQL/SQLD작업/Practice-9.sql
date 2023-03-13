-- EQUI(�)���� --> ������
-- ����: 2�� �̻��� �����̼�(���̺�)�� ����ؼ� ���ο� �����̼��� ����� ����
-- �� �����̼�(�⺻Ű, �ܷ�Ű) ��ġ�ϴ� ���� ������ �������� ��
SELECT * FROM USERTBL;

SELECT * FROM BUYTBL;

-- ����Ŭ���� � ���� ������ ����� USERID�� ���� �͸� �����ϹǷ� 12���� ��µ�
SELECT * 
 FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID;
-- ������ �ϴ��� �߰������� ������ �� �� ����. �����Լ� �� GROUP BY�� ��� ����
SELECT *
 FROM USERTBL, BUYTBL
WHERE USERTBL.USERID = BUYTBL.USERID
  AND USERTBL.USERNAME LIKE '��%';
  
-- ISO ǥ�� SQL�� TABLE1 INNER JOIN TABLE2 ON ���̺� ������ ����
SELECT *
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID
 WHERE USERTBL.USERNAME = '��ȣ��';
 
-- EQUI����(��������, �����)�� �ؽ������� ���
-- �ؽ������� ���� ���̺��� �����ϰ� �־��� ���ǿ� �ش��ϴ� ���� ���õǸ� ����Ű�� �������� �Ͽ� �ؽ��Լ��� ����ؼ� �ؽ����̺��� ���� �޸𸮿� �����ϰ� ���� ���̺��� ������ �����ϴ� ���� ã��
-- ���� ���̺��� ����Ű�� ����ؼ� �ؽ��Լ��� �����Ͽ� �ش� ��Ŷ�� �˻��ϰ� �˸��� ���� ����Ѵ�.
-- USERTBL , BUYTBL ��ü�� ���� ������(TABLE ACCESS FULL) �ؽ� �Լ��� ����ؼ� ���̺��� �����Ѵ�.

-- �Ʒ� ������ ������ �߻��Ѵ�. ������? '�÷��� ��ȣ��'
-- USERTBL, BUYTBL�� ���� USERID�� �����ϹǷ� � ���̺� �ִ� USERID�� ����� �� ����Ŭ ������ �ָ��ϴٸ鼭 ������ �߻���Ŵ
SELECT USERID, USERNAME, PRODNAME, ADDR
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID;
 
-- �ذ���: ��ȣ���� �ذ��ϱ� ���� ���̺��.�÷������� ����
SELECT USERTBL.USERID, USERTBL.USERNAME, BUYTBL.PRODNAME, USERTBL.ADDR
 FROM USERTBL
 INNER JOIN BUYTBL
 ON USERTBL.USERID = BUYTBL.USERID;
-- �ڵ带 �����ϰ� �ϱ� ���� ���̺� �˸��ƽ�(��Ī)�� �ο�
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR
 FROM USERTBL U
 INNER JOIN BUYTBL B
 ON U.USERID = B.USERID;
 
-- INTERSECT ����: �� ���� ���̺��� �������� ��ȸ. ��, �������� ������ �Ǵ� ���� �÷������� �����ؾ� �Ѵ�.
SELECT USERID FROM USERTBL
INTERSECT
SELECT USERID FROM BUYTBL;


-- �ܺ�����(OUTER JOIN)
-- �ܺ������� �� ���� ���̺� ���� �������� ��ȸ�ϰ� �� �� ���̺��� �ִ� �����͸� ���� �� ���Խ��Ѽ� ����ϴ� ��� (A-B)
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "����ó"
 FROM USERTBL U, BUYTBL B
WHERE U.USERID = B.USERID(+); -- (+)������ ����Ŭ������ ����

-- ISOǥ���� LEFT OUTER JOIN
-- LEFT OUTER JOIN Ű���带 �߽����� ���� ���̺��� ������ ���� ���   
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "����ó"
 FROM USERTBL U
 LEFT OUTER JOIN BUYTBL B
 ON U.USERID = B.USERID;
 
-- ISOǥ���� RIGHT OUTER JOIN
-- RIGHT OUTER JOIN Ű���带 �߽����� ���� ���̺��� ������ ���� ���
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "����ó"
 FROM BUYTBL B
 RIGHT OUTER JOIN USERTBL U
 ON U.USERID = B.USERID;
 
-- ISOǥ���� FULL OUTER JOIN
-- FULL OUTER JOIN�� 2���� ���̺��� ������ ���� ��� 
SELECT U.USERID, U.USERNAME, B.PRODNAME, U.ADDR, CONCAT(U.MOBILE1, U.MOBILE2) AS "����ó"
 FROM BUYTBL B
 FULL OUTER JOIN USERTBL U
 ON U.USERID = B.USERID;

 
-- CROSS JOIN(��ȣ ����): ���� ���� ���� 2���� ���̺��� �ϳ��� ���� -> ī�׽þ� ���� �߻�
-- ī��η�Ƽ: �� ���̺� �ִ� ���ڵ��� ��
-- USERTBL 10 ���ڵ�, BUYTBL 12 ���ڵ�
-- ī�׽þ� ��: 10*12 = 120
-- MERGE JOIN���� �������� ��µȴ�
SELECT *
 FROM USERTBL, BUYTBL;
 
SELECT *
 FROM USERTBL CROSS JOIN BUYTBL;