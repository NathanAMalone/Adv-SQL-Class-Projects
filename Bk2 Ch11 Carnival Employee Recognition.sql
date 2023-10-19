SELECT DISTINCT 
	e.employee_type_name,
	count(e2.employee_id) OVER(PARTITION BY e.employee_type_name) total_employees 
FROM employeetypes e 
JOIN employees e2 ON e.employee_type_id = e2.employee_type_id 

SELECT DISTINCT 
	d2.business_name ,
	count(e.employee_id) OVER (PARTITION BY	d2.business_name ) total_finance_managers
FROM employees e 
JOIN employeetypes e2 ON e2.employee_type_id = e.employee_type_id 
JOIN dealershipemployees d ON d.employee_id = e.employee_id 
JOIN dealerships d2 ON d2.dealership_id = d.dealership_id 
	WHERE e2.employee_type_name = 'Finance Manager'
ORDER BY d2.business_name 

SELECT DISTINCT 
	e.employee_id ,
	e.last_name || ', ' || e.first_name employee_name,
	count(de.dealership_id) OVER (PARTITION BY e.employee_id) dealership_shifts
--	d.business_name 
FROM employees e 
JOIN dealershipemployees de ON de.employee_id = e.employee_id 
JOIN dealerships d ON d.dealership_id =de.dealership_id 
GROUP BY e.employee_id , de.dealership_id , d.business_name 
ORDER BY dealership_shifts DESC 
LIMIT 3

SELECT DISTINCT 
	e.employee_id,
	e.last_name || ', ' || e.first_name employee_name,
	count(s.sale_id) OVER (PARTITION BY e.employee_id) num_of_sales
FROM employees e 
JOIN sales s ON s.employee_id = e.employee_id 
	WHERE s.sales_type_id =2
ORDER BY num_of_sales DESC 
LIMIT 2

--SELECT * FROM employees e 
--ORDER BY e.last_name 
--
--SELECT * FROM dealershipemployees d 
--ORDER BY employee_id  
--
--SELECT * FROM sales s 


	