WITH top_5_dealerships AS
(
	SELECT
		d.business_name, 
		sum(s.price) AS total_sales
	FROM dealerships d 
	JOIN sales s ON s.dealership_id = d.dealership_id 
	GROUP BY d.business_name
	ORDER BY  total_sales DESC
	LIMIT 5
),
	dealership_employees AS 
(
	SELECT 
		d.business_name,
		e.last_name || ', ' || e.first_name full_name,
		count(s.sale_id) AS number_employee_sales
	FROM dealerships d
	JOIN dealershipemployees de ON de.dealership_id = d.dealership_id 
	JOIN employees e ON e.employee_id = de.employee_id 
	JOIN sales s ON s.employee_id = e.employee_id 
	GROUP BY full_name, d.business_name 
	ORDER BY d.business_name 
)
SELECT DISTINCT 
	td.business_name,       
	de.number_employee_sales,
	de.full_name
FROM top_5_dealerships td
JOIN dealership_employees de ON de.business_name = td.business_name
ORDER BY td.business_name, de.number_employee_sales DESC 

WITH top_5_dealerships AS
(
	SELECT
		d.business_name, 
		sum(s.price) AS total_sales
	FROM dealerships d 
	JOIN sales s ON s.dealership_id = d.dealership_id 
	GROUP BY d.business_name
	ORDER BY  total_sales DESC
	LIMIT 5
),
	vehicle_models AS 
(
	SELECT 
		d.business_name,
		vt.model,
		count (vt.model) num_available
	FROM dealerships d
	JOIN vehicles v ON v.dealership_location_id = d.dealership_id 
	JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
	GROUP BY d.business_name, vt.model 
	ORDER BY d.business_name 
)
SELECT DISTINCT 
	td.business_name,
	td.total_sales,
	vm.model,
	vm.num_available
FROM top_5_dealerships td
JOIN vehicle_models vm ON vm.business_name = td.business_name
ORDER BY td.business_name , num_available DESC 

WITH top_5_dealerships AS
(
	SELECT
		d.dealership_id,
		d.business_name, 
		count(s.sale_id) AS total_sales
	FROM dealerships d 
	JOIN sales s ON s.dealership_id = d.dealership_id 
	GROUP BY d.business_name, d.dealership_id 
	ORDER BY  total_sales DESC
	LIMIT 5
)
SELECT 
	td.business_name ,
	count(CASE WHEN s2.sales_type_name = 'Purchase' THEN s2.sales_type_name END) AS purchases,
	count(CASE WHEN s2.sales_type_name = 'Lease' THEN s2.sales_type_name END) AS leases
FROM top_5_dealerships td
INNER JOIN	sales s ON	td.dealership_id = s.dealership_id 
INNER JOIN salestypes s2 ON	s.sales_type_id = s2.sales_type_id
--INNER JOIN salestypes s3 ON s.sales_type_id = s3.sales_type_id 
	--WHERE s3.sales_type_name = 'Lease' OR s2.sales_type_name = 'Purchase'
GROUP BY td.business_name 

WITH used_cars_sold AS
(
	SELECT
		s.sale_id,	
		v.is_new,
		v.is_sold,
		v.dealership_location_id 
	FROM sales s
	JOIN vehicles v ON v.vehicle_id = s.vehicle_id 
		WHERE v.is_new = FALSE AND v.is_sold = TRUE
)
SELECT 
	d.state,
	count(d.state) AS sales_per_state
FROM used_cars_sold uc
JOIN dealerships d ON d.dealership_id = uc.dealership_location_id
GROUP BY d.state 
ORDER BY sales_per_state DESC  

WITH used_cars_inventory AS
(
	SELECT
		s.sale_id,	
		v.vehicle_type_id,
		v.is_sold,
		v.is_new 
	FROM sales s
	JOIN vehicles v ON v.vehicle_id = s.vehicle_id 
		WHERE v.is_new = FALSE AND v.is_sold = FALSE 
)
SELECT 
	vt.model,
	count(vt.model) AS num_in_inventory
FROM used_cars_inventory uc
JOIN vehicletypes vt ON uc.vehicle_type_id = vt.vehicle_type_id 
GROUP BY vt.model
ORDER BY num_in_inventory DESC 

WITH used_cars_inventory AS
(
	SELECT
		s.sale_id,	
		v.vehicle_type_id,
		v.is_sold,
		v.is_new 
	FROM sales s
	JOIN vehicles v ON v.vehicle_id = s.vehicle_id 
		WHERE v.is_new = FALSE AND v.is_sold = FALSE 
)
SELECT 
	vt.make ,
	count(vt.make) AS num_in_inventory
FROM used_cars_inventory uc
JOIN vehicletypes vt ON uc.vehicle_type_id = vt.vehicle_type_id 
GROUP BY vt.make 
ORDER BY num_in_inventory DESC 

-- Lynn's solution to first question
WITH top5_dealerships AS 
	(
		SELECT d.dealership_id, d.business_name , SUM(s.price) AS Money_Made FROM dealerships d 
		JOIN sales s ON d.dealership_id = s.dealership_id 
		WHERE s.price IS NOT NULL
		GROUP BY d.business_name, d.dealership_id
		ORDER BY Money_Made DESC
		LIMIT 5	
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
	FROM top5_dealerships td
	INNER JOIN employee_salespeople AS es ON td.dealership_id = es.dealership_id AND TopEmployee = 1
	ORDER BY   td.dealership_id, es.number_of_sales DESC 
