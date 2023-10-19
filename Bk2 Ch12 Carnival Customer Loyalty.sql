SELECT DISTINCT 
	c.state ,
	count(c.state) state_count 
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id 
	WHERE s.sales_type_id = 1
GROUP BY c.state 
ORDER BY state_count DESC
LIMIT 5

SELECT DISTINCT 
	c.zipcode ,
	count(c.zipcode) zipcode_count 
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id 
	WHERE s.sales_type_id = 1
GROUP BY c.zipcode 
ORDER BY zipcode_count DESC
LIMIT 5

SELECT 
	count(d.dealership_id) num_of_customers,
	d.business_name 
FROM customers c 
JOIN sales s ON c.customer_id = s.customer_id 
JOIN dealerships d ON s.dealership_id = d.dealership_id 
GROUP BY business_name 
ORDER BY num_of_customers DESC
LIMIT 5

