--Practice: 1
SELECT 
	*
FROM sales s 
WHERE invoice_number = '2436217483'

DELETE FROM sales 
WHERE invoice_number = '2436217483'

--Practice: 2
SELECT 
	*
FROM employees e 
WHERE employee_id = 35

SELECT 
	*
FROM dealershipemployees d 

SELECT
	*
FROM sales s 

ALTER TABLE dealershipemployees
DROP CONSTRAINT dealershipemployees_employee_id_fkey,
ADD CONSTRAINT dealershipemployees_employee_id_fkey 
	FOREIGN KEY (employee_id)
	REFERENCES employees (employee_id)
	ON DELETE CASCADE

ALTER TABLE sales
DROP CONSTRAINT sales_employee_id_fkey,
ADD CONSTRAINT sales_employee_id_fkey
	FOREIGN KEY (employee_id)
	REFERENCES employees (employee_id)
	ON DELETE  CASCADE
	
DELETE  FROM employees 
WHERE employee_id = 35