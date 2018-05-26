DELIMITER $$
CREATE PROCEDURE update_cart (uid CHAR(32), type VARCHAR(7), pid MEDIUMINT, qty TINYINT)
BEGIN
	IF qty > 0 THEN
		UPDATE carts SET quantity=qty, date_modified=NOW() WHERE user_session_id=uid AND product_type=type AND product_id=pid;
	ELSEIF qty = 0 THEN
		CALL remove_from_cart (uid, type, pid);
	END IF;
END$$
DELIMITER ;