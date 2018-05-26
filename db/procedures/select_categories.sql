DELIMITER $$
CREATE PROCEDURE select_categories (type VARCHAR(7))
BEGIN
    IF type = 'coffee' THEN
        SELECT * FROM general_coffees ORDER by category;
    ELSEIF type = 'goodies' THEN
        SELECT * FROM non_coffee_categories ORDER by category;
    END IF;
END$$
DELIMITER ;