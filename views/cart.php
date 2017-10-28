<?php echo BOX_BEGIN; ?>

<h2>Your Shopping Cart</h2>
<p>Please use this form to update your shopping cart. You may change the quantities, move items to your wish list for future purchasing, or remove items entirely. The shipping and handling cost is based upon the order total. When you are ready to complete your purchase, please click Checkout to be taken to a secure page for processing.</p>
<form action="<?php echo BASE_URL; ?>cart.php" method="POST">
<table border="0" cellspacing="8" cellpadding="6">
	<tr>
		<th align="center">Item</th>
		<th align="center">Quantity</th>
		<th align="right">Price</th>
		<th align="right">Subtotal</th>
		<th align="center">Options</th>
	</tr>
<?php // Display the products:

// Initialize the total:
$total = 0;

// Fetch each product:
while ($row = mysqli_fetch_array($r, MYSQLI_ASSOC)) {
	
	// Get the correct price:
	$price = get_just_price($row['price'], $row['sale_price']);
	
	// Calculate the subtotal:
	$subtotal = $price * $row['quantity'];
	
	// Print out a table row:
	echo '<tr><td>' . $row['category'] . '::' . $row['name'] . '</td>
		<td align="center"><input type="text" name="quantity[' . $row['sku'] . ']" value="' . $row['quantity'] . '" size="2" class="small" /></td>
		<td align="right">$' . $price . '</td>
		<td align="right">$' . number_format($subtotal, 2) . '</td>
		<td align="right"><a href="' . BASE_URL . 'wishlist.php?sku=' . $row['sku'] . '&action=move&qty=' . $row['quantity'] .'">Move to Wish List</a><br /><a href="'.BASE_URL.'cart.php?sku=' . $row['sku'] . '&action=remove">Remove from Cart</a></td>
	</tr>
	';
	
	// Check the stock status:
	if ($row['stock'] < $row['quantity']) {
		echo '<tr class="error"><td colspan="5" align="center">There are only ' . $row['stock'] . ' left in stock of the ' . $row['name'] . '. Please update the quantity, remove the item entirely, or move it to your wish list.</td></tr>';
	}

	// Add the subtotal to the total:
  	$total += $subtotal;

} // End of WHILE loop. 

// Add the shipping:
// Added later in Chapter 9.
$shipping = get_shipping($total);
$total += $shipping;
echo '<tr>
	<td colspan="3" align="right"><strong>Shipping &amp; Handling</strong></td>
	<td align="right">$' . number_format($shipping, 2) . '</td>
	<td>&nbsp;</td>
</tr>
';

// Display the total:
echo '<tr>
	<td colspan="3" align="right"><strong>Total</strong></td>
	<td align="right">$' . number_format($total, 2) . '</td>
	<td>&nbsp;</td>
</tr>
';

echo '</table><br /><p align="center"><input type="submit" value="Update Quantities" class="button" /></form></p><br /><p align="center"><a href="' . BASE_URL . 'checkout.php" class="button">Checkout</a></p>';

echo BOX_END; 
?>