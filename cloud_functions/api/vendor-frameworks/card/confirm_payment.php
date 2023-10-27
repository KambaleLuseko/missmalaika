<?php
$action = isset($_GET['action']) ? trim(htmlentities($_GET['action'])) : "Inscription";
$amount = isset($_GET['amount']) ? trim(htmlentities($_GET['amount'])) : 10;
$points = 0;
$userUUID = isset($_GET['candidate']) ? trim(htmlentities($_GET['candidate'])) : null;
$eventID = isset($_GET['event_id']) ? trim(htmlentities($_GET['event_id'])) : null;
$paymentID = rand(10000, 1000000) . date('YmdHisv');
if (strtolower($action) == 'vote') {
    if (intval($amount) == 1) {
        $points = 1;
    } else if (intval($amount) == 5) {
        $points = 10;
    } else if (intval($amount) == 10) {
        $points = 30;
    } else if (intval($amount) == 20) {
        $points = 100;
    } else if (intval($amount) == 40) {
        $points = 500;
    }
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
                <h4 class="heading">Confirmer le paiement</h4>
                <p class="text">Vous avez initié le processus de paiement sur la plateforme Miss Malaika. Cette page
                    vous permet de valider le paiement via les cartes bancaires</p>
            </div>
            <div class="pricing p-3 rounded mt-4 d-flex justify-content-between">
                <div class="images d-flex flex-row align-items-center">
                    <!-- <img src="./logo.png" class="rounded"
                        width="60"> -->
                    <div class="d-flex flex-column ml-4"> <span class="business"><?php echo strtoupper($action); ?></span> </div>
                </div> <!--pricing table-->
                <div class="d-flex flex-row align-items-center"> <sup class="dollar font-weight-bold">USD</sup> <span class="amount ml-1 mr-1"><?php echo floatval($amount); ?></span> <span class="year font-weight-bold"></span> </div>
                <!-- /pricing table-->
            </div> <span class="detail mt-5">Details de la transaction</span>
            <div class="credit rounded mt-4 d-flex justify-content-between align-items-center">
                <div class="d-flex flex-row align-items-center"> <img src="./logo.png" class="rounded" width="70">
                    <div class="d-flex flex-column ml-3"> <span class="business"><?php echo strtoupper($action); ?></span> <span class="plan"><?php echo strtolower($action) == 'vote' ? "Vous allez offrir $points points à la candidate <b>$userUUID</b>" : "Inscription à la compétition Miss Malaika"; ?> </span> </div>
                </div>
            </div>
            <form action="https://cardpayment.flexpay.cd/v1/pay" method="POST">
                <input placeholder="authorization" type="text" name="authorization" hidden value="Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzUzMjgyNTcyLCJzdWIiOiIxYmVlNmUwYWFkOTVjZmIwZmQ2NTViZTk5NDU0ZjIzNiJ9.fzamLtEfngWhI_v8fB2VvVcxLYCEvTdZxCf9CovLte4">
                <input placeholder="merchant" type="text" name="merchant" hidden value="OZZONE">
                <input placeholder="amount" type="text" name="amount" hidden value="<?php echo floatval($amount); ?>">
                <input placeholder="currency" type="text" name="currency" hidden value="USD">
                <input placeholder="reference" type="text" name="reference" hidden value="<?php echo $paymentID; ?>">
                <input placeholder="description" type="text" name="description" hidden value="Paiement inscription Miss malaika">
                <input placeholder="callback_url" type="text" name="callback_url" hidden value="https://missmalaikardc.com/api/vendor-frameworks/card/approve.php?action=$action&amount=$amount&candidate=$userUUID&event_id=$eventID&points=$points&reference=$paymentID">
                <input placeholder="approve_url" type="text" name="approve_url" hidden value="https://missmalaikardc.com/api/vendor-frameworks/card/approve.php?action=$action&amount=$amount&candidate=$userUUID&event_id=$eventID&points=$points&reference=$paymentID">
                <input placeholder="cancel_url" type="text" name="cancel_url" hidden value="https://missmalaikardc.com/api/vendor-frameworks/card/cancel.php">
                <input placeholder="decline_url" type="text" name="decline_url" hidden value="https://missmalaikardc.com/api/vendor-frameworks/card/cancel.php">
                <div class="mt-3"> <button type="submit" class="btn btn-primary btn-block payment-button">Confirmer le
                        paiement <i class="fa fa-long-arrow-right"></i></button> </div>
            </form>

        </div>
    </div>
</body>

</html>