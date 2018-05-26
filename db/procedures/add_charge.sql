DELIMITER $$
CREATE PROCEDURE add_charge (charge_id VARCHAR(60), oid INT, trans_type VARCHAR(18), amt INT(10), charge TEXT)
BEGIN
  INSERT INTO charges VALUES (NULL, charge_id, oid, trans_type, amt, charge, NOW());
END$$
DELIMITER ;