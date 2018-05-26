
DELIMITER $$
CREATE PROCEDURE add_to_cart (uid CHAR(32), type VARCHAR(7), pid MEDIUMINT, qty TINYINT)
BEGIN
	
	DECLARE cid INT;
	
	SELECT id INTO cid FROM carts WHERE user_session_id=uid AND product_type=type AND product_id=pid;
	
	IF cid > 0 THEN
		UPDATE carts SET quantity=quantity+qty, date_modified=NOW() WHERE id=cid;
	ELSE 
		INSERT INTO carts (user_session_id, product_type, product_id, quantity) VALUES (uid, type, pid, qty);
	END IF;
END$$
DELIMITER ;