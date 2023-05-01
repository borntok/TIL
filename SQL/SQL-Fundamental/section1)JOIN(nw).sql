/***************************
	���� �ǽ� - 2
***************************/

-- ���� Antonio Moreno�� 1997�⿡ �ֹ��� �ֹ� ������ ���̵�, �ֹ�����, �������, ��� �ּҸ� �� �ּҿ� �Բ� ���� ��
select a.contact_name, b.order_id, b.order_date, b.shipped_date, b.ship_address, a.address  
from customers a
join orders b
  on a.customer_id = b.customer_id 
where a.contact_name = 'Antonio Moreno'
and b.order_date between to_date('19970101', 'yyyymmdd') and to_date('19971231', 'yyyymmdd');


-- Berlin�� ��� �ִ� ���� �ֹ��� �ֹ� ������ ���� ��
-- ����, �ֹ�id, �ֹ�����, �ֹ����� ������, ��۾�ü���� ���� ��

select a.customer_id, a.contact_name, b.order_id, b.order_date, 
	   c.first_name || ' ' || c.last_name as employee_name,
	   d.company_name 
from customers a
join orders b 
  on a.customer_id = b.customer_id
join employees c 
  on b.employee_id = c.employee_id
join shippers d 
  on b.ship_via = d.shipper_id 
where a.city = 'Berlin';


-- Beverage ī�װ��� ���ϴ� ��� ��ǰ���̵�� ��ǰ��, �׸��� �̵� ��ǰ�� �����ϴ� supplier ȸ��� ���� ���� ��
select b.category_name, a.product_id, a.product_name, c.company_name 
from products a 
join categories b
  on a.category_id = b.category_id
join suppliers c 
  on a.supplier_id = c.supplier_id 
where b.category_id = 1;


-- ���� Antonio Moreno�� 1997�⿡ �ֹ��� �ֹ� ��ǰ������ �� �ּ�, �ֹ� ���̵�, �ֹ�����, �������, ��� �ּ� ��
-- �ֹ� ��ǰ���̵�, �ֹ� ��ǰ��, �ֹ� ��ǰ�� �ݾ�, �ֹ� ��ǰ�� ���� ī�װ���, supplier���� ���� ��

select a.contact_name, a.address, b.order_id, b.order_date, b.shipped_date, b.ship_address,
	   c.product_id, d.product_name, c.amount, e.category_name, f.contact_name as supplier_name 
from customers a
join orders b 
  on a.customer_id = b.customer_id 
join order_items c 
  on b.order_id = c.order_id
join products d 
  on c.product_id = d.product_id
join categories e
  on d.category_id = e.category_id
join suppliers f
  on d.supplier_id = f.supplier_id 
where a.contact_name = 'Antonio Moreno'
and b.order_date between to_date('19970101', 'yyyymmdd') and to_date('19971231', 'yyyymmdd');