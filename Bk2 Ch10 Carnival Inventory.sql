SELECT DISTINCT 
	vt.model,
	count(vt.model) num_available
FROM vehicletypes vt
JOIN vehicles v ON vt.vehicle_type_id = v.vehicle_type_id 
	WHERE v.is_sold = FALSE 
GROUP BY vt.model
ORDER BY num_available ASC

SELECT DISTINCT 
	vt.model,
	v.is_sold,
	count(vt.model) num_available
FROM vehicles v
JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id 
	WHERE v.is_sold = FALSE 
GROUP BY vt.model, v.is_sold 
ORDER BY num_available DESC

SELECT  DISTINCT 
	d.business_name,
	v2.model ,
	count(v2.model) model_count
FROM dealerships d 
JOIN vehicles v  ON v.dealership_location_id = d.dealership_id 
JOIN vehicletypes v2 ON v2.vehicle_type_id = v.vehicle_type_id  
	WHERE v.is_sold = TRUE 
GROUP BY d.business_name , v2.model 
ORDER BY model_count

SELECT  DISTINCT 
	d.business_name,
	v2.model ,
	count(v2.model) model_count
FROM dealerships d 
JOIN vehicles v  ON v.dealership_location_id = d.dealership_id 
JOIN vehicletypes v2 ON v2.vehicle_type_id = v.vehicle_type_id  
	WHERE v.is_sold = TRUE 
GROUP BY d.business_name , v2.model 
ORDER BY model_count DESC 
