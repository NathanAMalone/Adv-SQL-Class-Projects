CREATE PROCEDURE vehicle_sold(IN is_car_sold boolean, IN car_vin varchar)
LANGUAGE plpgsql
AS $$
BEGIN

UPDATE vehicles 
SET is_sold = is_car_sold 
WHERE vin = car_vin;
	
END
$$;

CALL vehicle_sold(TRUE, '2HNYD18245H890440')

SELECT * FROM vehicles v WHERE v.vin = '2HNYD18245H890440' 

CREATE PROCEDURE vehicle_returned(IN is_car_returned boolean, IN car_vin varchar )
LANGUAGE plpgsql
AS $$
DECLARE returned_vehicle_id INT;

BEGIN 
		
	SELECT v.vehicle_id INTO returned_vehicle_id
	FROM vehicles v
	WHERE v.vin = car_vin;
	
	
	UPDATE vehicles 
	SET is_sold = FALSE AND is_new = FALSE 
	WHERE vin = car_vin;	

--	FROM vehicles v 
--	SET @returned_vehicle_id = v.vehicle_id;
	
	UPDATE sales 
	SET sale_returned = is_car_returned
	WHERE vehicle_id = returned_vehicle_id; 
	
END
$$;

CALL vehicle_returned(TRUE, '2HNYD18245H890440')

DROP PROCEDURE vehicle_returned

SELECT * FROM employees e 

SELECT * FROM oilchangelogs o 

SELECT * FROM sales s WHERE s.vehicle_id = 4

SELECT * FROM vehicles v WHERE v.vin = '2HNYD18245H890440'

SELECT * FROM vehicles v 