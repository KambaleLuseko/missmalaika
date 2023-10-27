<?php
include_once '../../../api/config.php';
$amount = isset($_POST["amount"]) ? $_POST["amount"] : 0;
$phonenumber = isset($_POST["phonenumber"]) ? $_POST["phonenumber"] : 0;
$currency = isset($_POST["currency"]) ? $_POST["currency"] : "usd";
$userUUID = trim(htmlentities($_POST['userUUID']));
$eventID = trim(htmlentities($_POST['event_id']));
$action = isset($_POST['action']) && !empty(trim($_POST['action'])) ? strtoupper(trim(htmlentities($_POST['action']))) : strtoupper('Inscription');
/* echo json_encode([
  "amount"=>$amount,
  "phone"=>$phonenumber,
  "currency"=>$currency
]); */
$phonenumber = '243' . substr($phonenumber, -9);
function generateRandomReference($length = 10)
{
  $characters = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  $reference = '';

  for ($i = 0; $i < $length; $i++) {
    $randomIndex = mt_rand(0, strlen($characters) - 1);
    $reference .= $characters[$randomIndex];
  }

  return $reference;
}
$msg = array();
$msg["error"] = "";
$msg["state"] = "";
$curl = curl_init();
if (!isset($userUUID) || empty($userUUID)) {
  $msg['state'] = false;
  $msg["error"] = "Invalid user reference";
  echo json_encode($msg);
  return;
}

if (strtolower($action) == 'inscription' && intval($amount) < 10) {
  $msg['state'] = false;
  $msg["error"] = "Le montant requis pour l'inscription est de 10\$";
  echo json_encode($msg);
  return;
}

$checkUser = "select * from tusers where uuid='$userUUID';";
$response = mysqli_query(Constants::connect(), $checkUser);
if (mysqli_num_rows($response) < 1) {
  $msg['state'] = false;
  $msg["error"] .= "Aucune candidate trouvée";
  echo json_encode($msg);
  return;
}
$points = 0;
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

if ($points == 0 && strtolower($action) == 'vote') {
  $msg['state'] = false;
  $msg["error"] .= "Le montant saisi est invalide, consultez le catalogue de vote";
  echo json_encode($msg);
  return;
}

$paymentID = rand(10000, 1000000) . date('YmdHisv');
if (strtolower($action) == 'inscription') {
  $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `payment_reference`) VALUES('$phonenumber', 'Mobile Money', '$amount', '$currency', '$userUUID', '$eventID', '$paymentID');";
  $res = mysqli_query(Constants::connect(), $query1);
} else if (strtolower($action) == 'vote') {
  $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `action`, `points`, `payment_reference`) VALUES('$phonenumber', 'Mobile Money', '$amount', '$currency', '$userUUID', '$eventID', '$action', '$points', '$paymentID');";
  $res = mysqli_query(Constants::connect(), $query1);
}

curl_setopt_array(
  $curl,
  array(
    CURLOPT_URL => 'https://backend.flexpay.cd/api/rest/v1/paymentService',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => '',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => '{
    "merchant":"OZZONE",
    "type":"1",
    "phone":"' . $phonenumber . '", 
    "reference":"' . $paymentID . '",
    "amount":"' . $amount . '",
    "currency":"' . $currency . '",
    "callbackUrl":"http://missmalaikardc.com/api/vendor-frameworks/php/flexpaypicallback.php?uuid=' . $userUUID . '&event=' . $eventID . '&action=' . $action . '&reference=' . $paymentID . '"

}',
    CURLOPT_HTTPHEADER => array(
      'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzUzMjgyNTcyLCJzdWIiOiIxYmVlNmUwYWFkOTVjZmIwZmQ2NTViZTk5NDU0ZjIzNiJ9.fzamLtEfngWhI_v8fB2VvVcxLYCEvTdZxCf9CovLte4',
      'Content-Type: application/json'
    ),
  )
);

$response = curl_exec($curl);

curl_close($curl);
echo $response;


// $ch = curl_init();
// curl_setopt($ch, CURLOPT_URL, "http://127.0.0.1:8000/vendor-frameworks/php/flexpaypicallback.php?uuid=$userUUID&event=$eventID&action=$action&reference=$paymentID");
// curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
// curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
// curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
// curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
// curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
// curl_setopt($ch, CURLOPT_TIMEOUT, 10);
// curl_setopt($ch, CURLOPT_VERBOSE, 1);
// $res = curl_exec($ch);
// echo $res;
