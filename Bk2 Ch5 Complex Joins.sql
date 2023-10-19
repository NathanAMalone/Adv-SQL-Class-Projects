-- Find employees who haven't made any sales and the name of the dealership they work at.
SELECT
    e.first_name,
    e.last_name,
    d.business_name,
    s.price
FROM employees e
INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
INNER JOIN dealerships d ON d.dealership_id = de.dealership_id
LEFT JOIN sales s ON s.employee_id = e.employee_id
WHERE s.price IS NULL;

-- Get all the departments in the database,
-- all the employees in the database and the floor price of any vehicle they have sold.
SELECT
    d.business_name,
    e.first_name,
    e.last_name,
    v.floor_price
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON e.employee_id = de.employee_id
INNER JOIN sales s ON s.employee_id = e.employee_id
INNER JOIN vehicles v ON s.vehicle_id = v.vehicle_id;

-- Use a self join to list all sales that will be picked up on the same day,
-- including the full name of customer picking up the vehicle. .
SELECT
    CONCAT  (c.first_name, ' ', c.last_name) AS last_name,
    s1.invoice_number,
    s1.pickup_date
FROM sales s1
INNER JOIN sales s2
    ON s1.sale_id <> s2.sale_id 
    AND s1.pickup_date = s2.pickup_date
INNER JOIN customers c
   ON c.customer_id = s1.customer_id;
   
-- Get employees and customers who have interacted through a sale.
-- Include employees who may not have made a sale yet.
-- Include customers who may not have completed a purchase.

SELECT
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM employees e
FULL OUTER JOIN sales s ON e.employee_id = s.employee_id
FULL OUTER JOIN customers c ON s.customer_id = c.customer_id;

-- Get a list of all dealerships and which roles each of the employees hold.
SELECT
    d.business_name,
    et.employee_type_name 
FROM dealerships d
LEFT JOIN dealershipemployees de ON d.dealership_id = de.dealership_id
INNER JOIN employees e ON de.employee_id = e.employee_id
RIGHT JOIN employeetypes et ON e.employee_type_id = et.employee_type_id;

SELECT 
	d.business_name ,
	count(CASE WHEN s2.sales_type_name = 'Purchase' THEN s2.sales_type_name END) AS purchases,
	count(CASE WHEN s2.sales_type_name = 'Lease' THEN s2.sales_type_name END) AS leases
FROM dealerships d 
INNER JOIN	sales s ON	d.dealership_id = s.dealership_id 
INNER JOIN salestypes s2 ON	s.sales_type_id = s2.sales_type_id
--INNER JOIN salestypes s3 ON s.sales_type_id = s3.sales_type_id 
	--WHERE s3.sales_type_name = 'Lease' OR s2.sales_type_name = 'Purchase'
GROUP BY d.business_name 

SELECT 
	v2.model ,
	count(s.sale_id) AS number_of_sales
FROM sales s 
JOIN salestypes s2 ON s.sales_type_id = s2.sales_type_id 
JOIN vehicles v  ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes v2 ON v.vehicle_type_id = v2.vehicle_type_id
	WHERE s2.sales_type_name = 'Lease'
GROUP BY v2.model 
ORDER BY number_of_sales DESC 

SELECT 
	v2.model ,
	count(s.sale_id) AS number_of_sales
FROM sales s 
JOIN salestypes s2 ON s.sales_type_id = s2.sales_type_id 
JOIN vehicles v  ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes v2 ON v.vehicle_type_id = v2.vehicle_type_id
	WHERE s2.sales_type_name = 'Purchase'
GROUP BY v2.model 
ORDER BY number_of_sales DESC 

SELECT 
	v2.model ,
	count(s.sale_id) AS number_of_sales,
	e2.employee_type_name 
FROM sales s 
JOIN salestypes s2 ON s.sales_type_id = s2.sales_type_id 
JOIN vehicles v  ON s.vehicle_id = v.vehicle_id 
JOIN vehicletypes v2 ON v.vehicle_type_id = v2.vehicle_type_id
JOIN  employees e ON s.employee_id = e.employee_id 
JOIN employeetypes e2 ON e.employee_type_id = e2.employee_type_id 
	WHERE s2.sales_type_name = 'Purchase'
GROUP BY v2.model, e2.employee_type_name 
ORDER BY number_of_sales DESC 

