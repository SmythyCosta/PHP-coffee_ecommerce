DROP PROCEDURE select_products;
DELIMITER $$
CREATE PROCEDURE select_products(type VARCHAR(7), cat TINYINT)
BEGIN
IF type = 'coffee' THEN
SELECT gc.description, gc.image, CONCAT("C", sc.id) AS sku, 
CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole, CONCAT("$", FORMAT(sc.price/100, 2))) AS name, 
sc.stock, sc.price, sales.price AS sale_price 
FROM specific_coffees AS sc INNER JOIN sizes AS s ON s.id=sc.size_id 
INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
LEFT OUTER JOIN sales ON (sales.product_id=sc.id 
AND sales.product_type='coffee' AND 
((NOW() BETWEEN sales.start_date AND sales.end_date) 
OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
WHERE general_coffee_id=cat AND stock>0 
ORDER by name;
ELSEIF type = 'goodies' THEN
SELECT ncc.description AS g_description, ncc.image AS g_image, 
CONCAT("G", ncp.id) AS sku, ncp.name, ncp.description, ncp.image, ncp.price, ncp.stock, sales.price AS sale_price
FROM non_coffee_products AS ncp INNER JOIN non_coffee_categories AS ncc 
ON ncc.id=ncp.non_coffee_category_id 
LEFT OUTER JOIN sales ON (sales.product_id=ncp.id 
AND sales.product_type='goodies' AND 
((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) )
WHERE non_coffee_category_id=cat ORDER by date_created DESC;
END IF;
END$$
DELIMITER ;