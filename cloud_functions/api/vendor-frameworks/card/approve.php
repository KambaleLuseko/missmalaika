<?php
include_once '../../config.php';
$action = isset($_GET['action']) ? trim(htmlentities($_GET['action'])) : "Inscription";
$amount = isset($_GET['amount']) ? trim(htmlentities($_GET['amount'])) : 1;
$currency = "USD";
$points = 0;
$userUUID = isset($_GET['candidate']) ? trim(htmlentities($_GET['candidate'])) : null;
$eventID = isset($_GET['event_id']) ? trim(htmlentities($_GET['event_id'])) : null;
$paymentID = isset($_GET['reference']) ? trim(htmlentities($_GET['reference'])) : null;
if (strtolower($action) == 'inscription') {
    $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `payment_reference`,`isPayed`) VALUES('Unknown', 'Bank card', '$amount', '$currency', '$userUUID', '$eventID', '$paymentID', 1);";
    $res = mysqli_query(Constants::connect(), $query1);
} else if (strtolower($action) == 'vote') {
    $points = isset($_GET['points']) ? trim(htmlentities($_GET['points'])) : null;
    $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `action`, `points`, `payment_reference`, `isPayed`) VALUES('Unknown', 'Bank card', '$amount', '$currency', '$userUUID', '$eventID', '$action', '$points', '$paymentID',1);";
    $res = mysqli_query(Constants::connect(), $query1);
}
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="bootstrapp.css">
    <link rel="stylesheet" href="style.css">
    <title>Paiement</title>
</head>

<body>

    <div class="container mt-5 mb-5 d-flex justify-content-center align-items-center" style="width:600px;">
        <div class="card p-5">
            <div>
                <h4 class="heading">Miss malaika</h4>
                <p class="text">Vous avez initié le processus de paiement sur la plateforme Miss Malaika.</p>
                <p>Félicitation, la transaction est passée avec succès.</p>
                <p>Merci pour votre confiance</p>
                <p><b>L'équipe d'organisation</b></p>
            </div>
        </div>
    </div>
</body>

</html>