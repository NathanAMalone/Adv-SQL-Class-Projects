SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name 
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
 WHERE s.sales_type_id =1
ORDER BY d.business_name 

SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE s.sales_type_id = 1 AND s.purchase_date >= '07-01-2020' AND s.purchase_date <= '07-31-2020'
ORDER BY d.business_name 

SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE s.sales_type_id = 1 AND s.purchase_date >= '01-01-2020' AND s.purchase_date <= '12-31-2020'
ORDER BY d.business_name 

SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name 
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE s.sales_type_id =2
ORDER BY d.business_name 

SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name 
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE s.sales_type_id =2 AND s.purchase_date >= '01-01-2020' AND s.purchase_date <= '01-31-2020'
ORDER BY d.business_name 

SELECT DISTINCT 
	sum(s.price) OVER(PARTITION BY d.business_name) total_sales,
	d.business_name 
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
	WHERE s.sales_type_id =2 AND s.purchase_date >= '01-01-2019' AND s.purchase_date <= '12-31-2019'
ORDER BY d.business_name 

SELECT DISTINCT 
	e.last_name || ', ' || e.first_name AS employee_name,
	e.employee_id ,
	d.business_name,
	sum(s.price) OVER(PARTITION BY e.last_name) total_sales
FROM sales s 
JOIN dealerships d ON s.dealership_id = d.dealership_id
JOIN employees e ON e.employee_id = s.employee_id 
ORDER BY d.business_name                 