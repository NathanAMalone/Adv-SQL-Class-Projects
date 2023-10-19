SELECT 
	*
FROM sales s 
WHERE 
	s.sales_type_id = 2;
	
SELECT  *
FROM sales s 
WHERE s.purchase_date > '2018-05-09';

SELECT *
FROM sales s 
WHERE s.deposit > 5000 OR payment_method = 'americanexpress';

SELECT *
FROM employees e  
WHERE e.first_name LIKE 'M%' OR e.first_name LIKE '%d';

SELECT *
FROM employees e 
WHERE e.phone LIKE '604%'