DELIMITER $$
CREATE PROCEDURE remove_from_cart (uid CHAR(32), type VARCHAR(7), pid MEDIUMINT)
BEGIN
	DELETE FROM carts WHERE user_session_id=uid AND product_type=type AND product_id=pid;
END$$
DELIMITER ;