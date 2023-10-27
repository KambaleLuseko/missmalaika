<?php
$dateExp = date("Y-m-d H:i:s", strtotime("+1 years", strtotime(date("Y-m-d H:i:s"))));
$dateExpir = date("Y-m-d", strtotime(date("Y-m-d H:i:s")));
print_r($dateExpir);

$matriculeClient = rand(10000, 1000000) . date('YmdHis');
print_r('\n' . $matriculeClient);
?>
<html>

<head>
	<title></title>
</head>

<body>
	<form action="saveClass.php" method="POST">
		<input placeholder="userID" type="text" name="userID">
		<input placeholder="details" type="text" name="details[]">
		<input placeholder="details" type="text" name="details[]">
		<input placeholder="details" type="text" name="details[]">
		<input placeholder="newbillboard" value="newbillboard" type="text" name="transaction">
		<input type="submit" value="valider">
	</form>


	<br>
	GET DATA
	<form action="get_data.php" method="POST">
		<input placeholder="plaque" type="text" name="plaque">
		<input placeholder="Scan" value="getscan" type="text" name="transaction">
		<input type="submit" value="valider">
	</form>

	GET Transaction
	<form action="transactions.php" method="POST">
		<input placeholder="uuid" type="text" name="uuid">
		<input placeholder="transaction" value="stats" type="text" name="transaction">
		<input type="submit" value="valider">
	</form>


	payment
	<form action="./vendor-frameworks/php/flexpayapi.php" method="POST">
		<input placeholder="phonenumber" type="text" name="phonenumber">
		<input placeholder="amount" type="text" name="amount">
		<input placeholder="currency" type="text" name="currency">
		<input placeholder="User reference" type="text" name="userUUID">
		<input placeholder="event reference" type="text" name="event_id">
		<input placeholder="action" type="text" name="action">
		<input placeholder="transaction" value="testpayment" type="text" name="transaction">
		<input type="submit" value="valider">
	</form>
	illico
	<form action="./vendor-frameworks/php/illicocashapi.php" method="POST">
		<input placeholder="mobilenumber" type="text" name="mobilenumber">
		<input placeholder="amount" type="text" name="amount">
		<input placeholder="currency" type="text" name="currency">
		<input placeholder="referencenumber" type="text" name="referencenumber">
		<input placeholder="step" type="text" name="step">
		<input placeholder="otp" type="text" name="otp">
		<input placeholder="transaction" value="testpayment" type="text" name="transaction">
		<input type="submit" value="valider">
	</form>

</body>

</html>