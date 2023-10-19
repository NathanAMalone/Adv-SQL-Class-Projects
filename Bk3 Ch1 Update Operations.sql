--Practice: Employees
SELECT 
	*
FROM employees e
WHERE first_name = 'Kristopher'

SELECT 
	*
FROM dealershipemployees d 
WHERE employee_id = 9

UPDATE dealershipemployees 
SET dealership_id = 20
WHERE employee_id = 9

--Practice: Sales
SELECT
	*
FROM sales s 
WHERE invoice_number = '9086714242'

UPDATE sales 
SET payment_method = 'mastercard'
WHERE invoice_number = '9086714242'