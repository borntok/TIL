/****************************
	���� �ǽ� - outer ����
****************************/

-- �ֹ��� �� �ѹ��� ���� �� ���� ���ϱ�
select a.*, b.order_id  
from customers a
left join orders b
on a.customer_id = b.customer_id
where b.order_id is null;

-- �μ������� �μ��� �Ҽӵ� ������ ���� ���ϱ�. �μ��� ������ ������ ���� �ʴ��� �μ������� ǥ�õǾ�� ��.
select a.deptno, a.dname, a.loc, b.ename
from hr.dept a
left join hr.emp b
on a.deptno = b.deptno
order by a.deptno;


-- Madrid�� ��� �ִ� ���� �ֹ��� �ֹ� ������ ���� ��.
-- ����, �ֹ�id, �ֹ�����, �ֹ����� ������, ��۾�ü���� ���ϵ�
-- ���� ���� �ֹ��� �� ���� ���� ���� ���� �������� ������ �ȵ�. �� ��� �ֹ������� ������ �ֹ�id�� 0���� �������� Null�� ���� ��

select a.contact_name, coalesce(b.order_id,0) as order_id, b.order_date, 
	   c.first_name ||' '|| c.last_name as employee_name, 
	   d.company_name as shipper_name
from customers a
left join orders b
  on a.customer_id = b.customer_id
left join employees c
  on b.employee_id = c.employee_id 
left join shippers d 
  on b.ship_via = d.shipper_id 
where a.city = 'Madrid'

-- ������ ���ռ� Ȯ�ο����� outer join ����ϴ� ���
-- order_items�� �ֹ���ȣ(order_id)�� ���� order_id�� ���� orders ������ ã��
select a.order_id, b.*
from orders a
left join order_items b
  on a.order_id = b.order_id
where b.order_id is null;
-- orders ���̺� ���� order_id�� �ִ� order_items ������ ã��
select a.order_id, b.*
from order_items a
left join orders b
  on a.order_id = b.order_id 
where b.order_id is null;