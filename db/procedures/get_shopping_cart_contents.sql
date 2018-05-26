DELIMITER $$
CREATE PROCEDURE get_shopping_cart_contents (uid CHAR(32))
BEGIN
	SELECT CONCAT("G", ncp.id) AS sku, 
	       c.quantity, 
	       ncc.category, 
	       ncp.name, 
	       ncp.price, 
	       ncp.stock, 
	       sales.price AS sale_price 
	       FROM carts AS c 
	       INNER JOIN non_coffee_products AS ncp ON c.product_id=ncp.id 
	       INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id 
	       LEFT OUTER JOIN sales ON (sales.product_id=ncp.id AND sales.product_type='goodies' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
	       WHERE c.product_type="goodies" 
	       AND c.user_session_id=uid 
	UNION 
	SELECT CONCAT("C", sc.id), 
	       c.quantity, 
	       gc.category, 
	       CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), 
	       sc.price, 
	       sc.stock, 
	       sales.price 
	    FROM carts AS c 
	    INNER JOIN specific_coffees AS sc ON c.product_id=sc.id 
	    INNER JOIN sizes AS s ON s.id=sc.size_id 
	    INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
	    LEFT OUTER JOIN sales ON (sales.product_id=sc.id AND sales.product_type='coffee' AND ((NOW() BETWEEN sales.start_date AND sales.end_date) OR (NOW() > sales.start_date AND sales.end_date IS NULL)) ) 
	    WHERE c.product_type="coffee" 
	    AND c.user_session_id=uid;
END$$
DELIMITER ;