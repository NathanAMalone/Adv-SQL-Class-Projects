CREATE OR REPLACE PROCEDURE dismissedEmployee(IN dismissed_id INT)
LANGUAGE plpgsql
AS $$

BEGIN 
	
	DELETE FROM dealershipemployees 
	WHERE employee_id = dismissed_id;

	DELETE  FROM employees 
	WHERE employee_id = dismissed_id;
	
END;
$$;

CALL dismissedEmployee(2)


SELECT * FROM employees
WHERE employee_id = 2

SELECT * FROM dealershipemployees d 
WHERE employee_id = 2

SELECT * FROM sales s 
WHERE sale_id = 2259
