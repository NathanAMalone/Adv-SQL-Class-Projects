SELECT *
FROM sales s 
WHERE s.sales_type_id = 1;

SELECT *
FROM sales s 
WHERE s.sales_type_id = 2;

SELECT 
	s.sale_id ,
	v.vin ,
	c.first_name cust_first_name,
	c.last_name cust_last_name,
	e.first_name emp_first_name,
	e.last_name emp_last_name,
	d.business_name ,
	d.city ,
	d.state 
FROM sales s 
LEFT JOIN vehicles v 
	ON	s.vehicle_id = v.vehicle_id
LEFT  JOIN customers c 
	ON s.customer_id = c.customer_id 
LEFT JOIN employees e 
	ON s.employee_id = e.employee_id 
LEFT JOIN dealerships d 
	ON s.dealership_id = d.dealership_id; 
	
SELECT 
	d.dealership_id ,
	d.business_name ,
	e.first_name ,
	e.last_name 
FROM dealerships d
LEFT JOIN dealershipemployees d2 
	ON d.dealership_id = d2.dealership_id 
LEFT JOIN employees e 
	ON d2.employee_id = e.employee_id 
	
SELECT 
	v.vehicle_id ,
	v2.body_type ,
	v2.make ,
	v2.model ,
	v.exterior_color 
FROM vehicles v 
LEFT JOIN	vehicletypes v2 
	ON v.vehicle_type_id = v2.vehicle_type_id 