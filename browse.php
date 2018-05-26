<?php

// This file lists products in a specific category
// This script is begun in Chapter 8.

// Require the configuration before any PHP code:
require('./includes/config.inc.php');

// Validate the required values:
$type = $sp_cat = $category = false;
if (isset($_GET['type'], $_GET['category'], $_GET['id']) && filter_var($_GET['id'], FILTER_VALIDATE_INT, array('min_range' => 1))) {
	
	// Make the associations:
	$category = $_GET['category'];
	$sp_cat = $_GET['id'];
	
	// Validate the type:
	if ($_GET['type'] === 'goodies') {
		
		$type = 'goodies';
		
	} elseif ($_GET['type'] === 'coffee') {
		
		$type = 'coffee';	
		
	}

}

// If there's a problem, display the error page:
if (!$type || !$sp_cat || !$category) {
	$page_title = 'Error!';
	include('./includes/header.html');
	include('./views/error.html');
	include('./includes/footer.html');
	exit();
}

// Create a page title:
$page_title = ucfirst($type) . ' to Buy::' . $category;

// Include the header file:
include('./includes/header.html');

// Call the stored procedure:
$r = mysqli_query($dbc, "CALL select_products('$type', $sp_cat)");

// For debugging purposes:
//if (!$r) echo mysqli_error($dbc);

// If records were returned, include the view file:
if (mysqli_num_rows($r) > 0) {
	if ($type === 'goodies') {
		// Three versions of this file:
		// include('./views/list_goodies.html');
		// include('./views/list_goodies2.html');
		include('./views/list_goodies3.php');
	} elseif ($type === 'coffee') {
		// include('./views/list_coffees.html');
		include('./views/list_coffees2.php');

		// Clear the stored procedure results:
		mysqli_next_result($dbc);

		// Added in Chapter 13...
		// Handle and show reviews...
		include('./includes/handle_review.php');
		
		$r = mysqli_query($dbc, "CALL select_reviews('$type', $sp_cat)");
		//include('./views/review.php');

	}
} else { // Include the "noproducts" page:
	include('./views/noproducts.php');
}

// Include the footer file:
include('./includes/footer.html');
?>