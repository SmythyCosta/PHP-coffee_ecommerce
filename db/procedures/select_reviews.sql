DELIMITER $$
CREATE PROCEDURE select_reviews(type VARCHAR(7), pid MEDIUMINT)
BEGIN
IF type = 'coffee' THEN
SELECT review FROM reviews WHERE type='coffee' AND product_id=pid ORDER by date_created DESC;
ELSEIF type = 'goodies' THEN
SELECT review FROM reviews WHERE type='goodies' AND product_id=pid ORDER by date_created DESC;
END IF;
END$$
DELIMITER ;