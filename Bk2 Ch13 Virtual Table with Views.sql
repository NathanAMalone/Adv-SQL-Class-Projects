CREATE VIEW	vehicle_specs AS
	SELECT
		v.body_type,
		vmake.make,
		vmodel.model
	FROM vehicletypes vt 
	JOIN vehiclebodytype v ON v.vehicle_body_type_id = vt.vehicle_body_type_id
	JOIN vehiclemake vmake ON vmake.vehicle_make_id = vt.vehicle_make_id 
	JOIN vehiclemodel vmodel ON vmodel.vehicle_model_id = vt.vehicle_model_id
	
SELECT 
	*
FROM vehicle_specs 

DROP VIEW vehicle_specs

CREATE VIEW	num_employees_per_type AS
	SELECT 
		count(e.employee_id) num_of_employees,
		et.employee_type_name
	FROM employees e 
	JOIN employeetypes et ON e.employee_type_id = et.employee_type_id
	GROUP BY et.employee_type_name
	
SELECT 
	*
FROM num_employees_per_type 


CREATE VIEW public_customer_data AS
	SELECT 
		concat(c.last_name, ', ', c.first_name) customer_name,
		c.city,
		c.state,
		c.zipcode,
		c.company_name
	FROM customers c 
	
SELECT
	*
FROM public_customer_data 

CREATE VIEW sales2018 AS
	SELECT	
		count(s.sale_id) num_of_sales,
		st.sales_type_name
	FROM sales s 
	JOIN salestypes st ON s.sales_type_id = st.sales_type_id
		WHERE s.purchase_date >= '2018-01-01' AND s.purchase_date <= '2018-12-31'
	GROUP BY st.sales_type_name
	
SELECT 
	*
FROM sales2018

CREATE VIEW top_employee AS	
	WITH top_dealerships AS 
		(
			SELECT d.dealership_id, d.business_name , SUM(s.price) AS Money_Made FROM dealerships d 
			JOIN sales s ON d.dealership_id = s.dealership_id 
			WHERE s.price IS NOT NULL
			GROUP BY d.business_name, d.dealership_id
			ORDER BY Money_Made DESC
		),
		employee_salespeople AS 
		(
			--For the top 5 dealerships, which employees made the most sales?
			SELECT e.first_name , e.last_name, de.dealership_id, COUNT(s.sale_id) AS Number_of_Sales,
	        ROW_NUMBER() OVER(PARTITION BY de.dealership_Id ORDER BY COUNT(s.sale_id) DESC) as TopEmployee  
	        FROM dealershipemployees de 
			JOIN employees e ON e.employee_id = de.employee_id 
			JOIN sales s ON s.employee_id = de.employee_id 
			GROUP BY de.dealership_id, e.first_name, e.last_name  
			ORDER BY Number_of_Sales DESC
		)
		SELECT td.business_name,
	     td.Money_Made, 
	     es.first_name, 
	     es.last_name, 
	     es.Number_of_Sales
		FROM top_dealerships td
		INNER JOIN employee_salespeople AS es ON td.dealership_id = es.dealership_id AND TopEmployee = 1
		ORDER BY   td.dealership_id, es.number_of_sales DESC 

	SELECT
		*
	FROM top_employee 
