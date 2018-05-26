DELIMITER $$
CREATE PROCEDURE add_order (cid INT, uid CHAR(32), ship INT(10), cc MEDIUMINT, OUT total INT(10), OUT oid INT)
BEGIN
	DECLARE subtotal INT(10);
	
	INSERT INTO orders (customer_id, shipping, credit_card_number, order_date) VALUES (cid, ship, cc, NOW());
	
	SELECT LAST_INSERT_ID() INTO oid;
	
	INSERT INTO order_contents (order_id, 
		                        product_type, 
		                        product_id, 
		                        quantity, 
		                        price_per) 
							SELECT oid, 
							       c.product_type, 
							       c.product_id, 
							       c.quantity, 
							       IFNULL(sales.price, ncp.price) 
							    FROM carts AS c 
							    INNER JOIN non_coffee_products AS ncp ON c.product_id=ncp.id 
							    LEFT OUTER JOIN sales ON (sales.product_id=ncp.id AND sales.product_type='goodies' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
							    WHERE c.product_type="goodies" 
							    AND c.user_session_id=uid 
							UNION 
							SELECT oid, 
							       c.product_type, 
							       c.product_id, 
							       c.quantity, 
							       IFNULL(sales.price, sc.price) 
							    FROM carts AS c 
							    INNER JOIN specific_coffees AS sc ON c.product_id=sc.id 
							    LEFT OUTER JOIN sales ON (sales.product_id=sc.id AND sales.product_type='coffee' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
							    WHERE c.product_type="coffee" 
							    AND c.user_session_id=uid;

	SELECT SUM(quantity*price_per) INTO subtotal FROM order_contents WHERE order_id=oid;

	UPDATE orders SET total = (subtotal + ship) WHERE id=oid;
	
	SELECT (subtotal + ship) INTO total;
END$$
DELIMITER ;