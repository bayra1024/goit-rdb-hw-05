1
SELECT 
    od.*, 
    (
        SELECT 
            o.customer_id 
        FROM 
            orders o
        WHERE 
            o.id = od.order_id
    ) AS customer_id
FROM 
    order_details od;


2
SELECT 
    od.*
FROM 
    order_details od
WHERE 
    od.order_id IN (
        SELECT 
            o.id
        FROM 
            orders o
        WHERE 
            o.shipper_id = 3
    );


3
SELECT 
    subquery.order_id,
    AVG(subquery.quantity) AS average_quantity
FROM 
    (
        SELECT 
            order_id, 
            quantity
        FROM 
            order_details
        WHERE 
            quantity > 10
    ) AS subquery
GROUP BY 
    subquery.order_id;


4
WITH temp AS (
    SELECT 
        order_id, 
        quantity
    FROM 
        order_details
    WHERE 
        quantity > 10
)
SELECT 
    order_id,
    AVG(quantity) AS average_quantity
FROM 
    temp
GROUP BY 
    order_id;


5
DROP FUNCTION IF EXISTS divide_floats 

DELIMITER //

CREATE FUNCTION divide_floats(a FLOAT, b FLOAT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF b = 0 THEN
        RETURN NULL;
    ELSE
        RETURN a / b;
    END IF;
END //

DELIMITER ;
SELECT 
    order_id,
    quantity,
    divide_floats(quantity, 2.5) AS divided_quantity
FROM 
    order_details;            