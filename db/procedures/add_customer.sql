DELIMITER $$
CREATE PROCEDURE add_customer (e VARCHAR(80), f VARCHAR(20), l VARCHAR(40), a1 VARCHAR(80), a2 VARCHAR(80), c VARCHAR(60), s CHAR(2), z MEDIUMINT, p INT, OUT cid INT)
BEGIN
	INSERT INTO customers (email, first_name, last_name, address1, address2, city, state, zip, phone) VALUES (e, f, l, a1, a2, c, s, z, p);
	SELECT LAST_INSERT_ID() INTO cid;
END$$
DELIMITER ;