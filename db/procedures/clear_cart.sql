DELIMITER $$
CREATE PROCEDURE clear_cart (uid CHAR(32))
BEGIN
	DELETE FROM carts WHERE user_session_id=uid;
END$$
DELIMITER ;