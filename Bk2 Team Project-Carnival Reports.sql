--Best Sellers Question 1
SELECT 
	e.first_name, 
	e.last_name, 
	SUM(s.price) totalSalesIncome
FROM sales s
JOIN employees e ON e.employee_id = s.employee_id 
GROUP BY e.first_name, e.last_name 
ORDER BY totalSalesIncome DESC
LIMIT 5;

--Best Sellers Question 2
SELECT 
	d.business_name, 
	SUM(s.price) totalSalesIncome
FROM sales s
JOIN dealerships d ON s.dealership_id = d.dealership_id
GROUP BY d.business_name 
ORDER BY totalSalesIncome DESC
LIMIT 5;

--Best Sellers Question 3
SELECT 
	vt.make, 
	vt.model, 
	COUNT(s.sale_id) totalSales, 
	SUM(s.price) totalSalesIncome
FROM vehicles v
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
JOIN sales s ON s.vehicle_id = v.vehicle_id
GROUP BY vt.make, vt.model
ORDER BY totalSalesIncome DESC
LIMIT 1;

--Top Performance Question 1
WITH employee_salespeople AS
	(
		SELECT 
			e.first_name, 
			e.last_name, 
			de.dealership_id, 
			sum(s.price) AS Total_Sales,
       		ROW_NUMBER() OVER(PARTITION BY de.dealership_Id ORDER BY sum(s.price) DESC) as TopEmployee 
       	FROM dealershipemployees de
		JOIN employees e ON e.employee_id = de.employee_id
		JOIN sales s ON s.employee_id = de.employee_id
		GROUP BY de.dealership_id, e.first_name, e.last_name 
		ORDER BY Total_Sales DESC
	)
	SELECT 
		td.business_name,
	    SUM(s.price) AS business_revenue,
	    es.first_name,
	    es.last_name,
	    es.Total_Sales
	FROM dealerships td
	JOIN sales s ON s.dealership_id = td.dealership_id
	INNER JOIN employee_salespeople AS es ON td.dealership_id = es.dealership_id AND TopEmployee = 1
	GROUP BY td.business_name, es.first_name, es.last_name, es.Total_sales, td.dealership_id
	ORDER BY   td.dealership_id, es.Total_Sales DESC

--Inventory Question 1
SELECT 
	vt.make,
	vt.model,
	count(vt.model) models_in_stock 
FROM vehicles v 
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
	WHERE v.is_sold IS FALSE  
GROUP BY vt.make , vt.model 
ORDER BY models_in_stock DESC 

--Inventory Question 2
SELECT 
	vt.make,  
	COUNT(vt.make) totalInStock
FROM vehicles v
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
	WHERE v.is_sold IS FALSE
GROUP BY vt.make
ORDER BY totalInStock DESC

--Inventory Question 3
SELECT 
	vt.body_type, 
	COUNT(vt.body_type) totalOfBodyType
FROM vehicles v
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
	WHERE v.is_sold = FALSE 
GROUP BY vt.body_type 
ORDER BY totalOfBodyType DESC

--Purchasing Power Question 1
SELECT 
	c.state ,
	round( avg(s.price), 2) avg_vehicle_price
FROM sales s 
JOIN customers c ON s.customer_id =c.customer_id 
GROUP BY c.state 
ORDER BY avg_vehicle_price DESC 

--Purchasing Power Question 2
SELECT 
	c.state ,
	round( avg(s.price), 2) avg_vehicle_price
FROM sales s 
JOIN customers c ON s.customer_id =c.customer_id 
GROUP BY c.state 
ORDER BY avg_vehicle_price DESC 
LIMIT 5







	
	