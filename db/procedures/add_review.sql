DELIMITER $$
CREATE PROCEDURE add_review (type VARCHAR(7), pid MEDIUMINT, n VARCHAR(60), e VARCHAR(80), r TEXT)
BEGIN
  INSERT INTO reviews (product_type, product_id, name, email, review) VALUES (type, pid, n, e, r);
END$$
DELIMITER ;