<?php
include_once '../../../api/config.php';
class MobilePayment
{
  public static function makePayment($data)
  {
    $amount = isset($data["amount"]) ? $data["amount"] : 0;
    $phonenumber = isset($data["phonenumber"]) ? $data["phonenumber"] : 0;
    $currency = isset($data["currency"]) ? $data["currency"] : "usd";
    $userUUID = trim(mysqli_real_escape_string(constants::connect(), $data['userUUID']));
    $eventID = trim(mysqli_real_escape_string(constants::connect(), $data['event_id']));
    $action = isset($data['action']) && !empty(trim($data['action'])) ? strtoupper(trim(mysqli_real_escape_string(constants::connect(), $data['action']))) : strtoupper('Inscription');
    $paymentID = isset($data['paymentID']) && !empty(trim($data['paymentID'])) ? trim($data['paymentID']) : rand(10000, 1000000) . date('YmdHisv');
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
    $curl = curl_init();
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
    echo ($response);
  }
}


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
