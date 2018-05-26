DELIMITER $$
CREATE PROCEDURE select_sale_items (get_all BOOLEAN)
BEGIN
	IF get_all = 1 THEN 
		SELECT CONCAT("G", ncp.id) AS sku, 
		       sa.price AS sale_price, 
		       ncc.category, 
		       ncp.image, 
		       ncp.name, 
		       ncp.price AS price, 
		       ncp.stock, 
		       ncp.description 
		    FROM sales AS sa 
		    INNER JOIN non_coffee_products AS ncp ON sa.product_id=ncp.id 
		    INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id 
		    WHERE sa.product_type="goodies" 
		    AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) )
		UNION 
		SELECT CONCAT("C", sc.id), 
		       sa.price, 
		       gc.category, 
		       gc.image, 
		       CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole), 
		       sc.price, 
		       sc.stock, 
		       gc.description 
		    FROM sales AS sa INNER JOIN specific_coffees AS sc ON sa.product_id=sc.id 
		    INNER JOIN sizes AS s ON s.id=sc.size_id 
		    INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
		    WHERE sa.product_type="coffee" 
		    AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) );
    ELSE 
		(SELECT CONCAT("G", ncp.id) AS sku, 
			    CONCAT("$", FORMAT(sa.price/100, 2)) AS sale_price, 
			    ncc.category, 
			    ncp.image, 
			    ncp.name 
			FROM sales AS sa 
			INNER JOIN non_coffee_products AS ncp ON sa.product_id=ncp.id 
			INNER JOIN non_coffee_categories AS ncc ON ncc.id=ncp.non_coffee_category_id 
			WHERE sa.product_type="goodies" 
			AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) ) 
			ORDER BY RAND() LIMIT 2) 
		UNION 
		(SELECT CONCAT("C", sc.id), 
			    CONCAT("$", FORMAT(sa.price/100, 2)), 
			    gc.category, 
			    gc.image, 
			    CONCAT_WS(" - ", s.size, sc.caf_decaf, sc.ground_whole) 
			FROM sales AS sa 
			INNER JOIN specific_coffees AS sc ON sa.product_id=sc.id 
			INNER JOIN sizes AS s ON s.id=sc.size_id 
			INNER JOIN general_coffees AS gc ON gc.id=sc.general_coffee_id 
			WHERE sa.product_type="coffee" 
			AND ((NOW() BETWEEN sa.start_date AND sa.end_date) OR (NOW() > sa.start_date AND sa.end_date IS NULL) ) 
			ORDER BY RAND() LIMIT 2);
	END IF;
END$$
DELIMITER ;