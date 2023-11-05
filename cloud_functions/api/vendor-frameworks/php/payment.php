<?php
include_once '../../../api/config.php';
include_once '../../../api/vendor-frameworks/php/flexpayapi_new.php';
include_once '../../../api/vendor-frameworks/php/illicocashapi_new.php';

class Payment
{
    public static function initPayment($data)
    {
        $gateway = isset($data["gateway"]) ? $data["gateway"] : 'Mobile money';
        $amount = isset($data["amount"]) ? $data["amount"] : 0;
        $phonenumber = isset($data["phonenumber"]) ? $data["phonenumber"] : 0;
        $currency = isset($data["currency"]) ? $data["currency"] : "usd";
        $userUUID = trim(mysqli_real_escape_string(constants::connect(), $data['userUUID']));
        $eventID = trim(mysqli_real_escape_string(constants::connect(), $data['event_id']));
        $action = isset($data['action']) && !empty(trim($data['action'])) ? strtoupper(trim(mysqli_real_escape_string(constants::connect(), $data['action']))) : strtoupper('Inscription');

        $msg = array();
        $msg["error"] = "";
        $msg["state"] = "";
        if (!isset($gateway) || empty($gateway)) {
            $msg['state'] = false;
            $msg["error"] = "Bad gateway";
            echo json_encode($msg);
            return;
        }
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
            $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `payment_reference`) VALUES('$phonenumber', '$gateway', '$amount', '$currency', '$userUUID', '$eventID', '$paymentID');";
            $res = mysqli_query(Constants::connect(), $query1);
        } else if (strtolower($action) == 'vote') {
            $query1 = "INSERT INTO `candidate_payments` (`number`,`type`, `amount`, `currency`,`userUUID`, `event_id`, `action`, `points`, `payment_reference`) VALUES('$phonenumber', '$gateway', '$amount', '$currency', '$userUUID', '$eventID', '$action', '$points', '$paymentID');";
            $res = mysqli_query(Constants::connect(), $query1);
        }

        if (strtolower(trim($gateway)) == 'mobile money') {
            MobilePayment::makePayment(["amount" => $amount, "currency" => $currency, "action" => $action, "paymentID" => $paymentID, "phonenumber" => $phonenumber, "userUUID" => $userUUID, "event_id" => $eventID]);
        } else if (strtolower(trim($gateway)) == 'illicocash') {
            $step = isset($_REQUEST["step"]) ? $_REQUEST["step"] : "undefined"; // Get the step from the request parameters or set it to "undefined" if not provided
            $otp = isset($_REQUEST["otp"]) ? $_REQUEST["otp"] : false; // Get the OTP from the request parameters or set it to false if not provided
            $referenceNumber = isset($_REQUEST["referencenumber"]) ? $_REQUEST["referencenumber"] : $paymentID; // Get the reference number from the request parameters or set it to false if not provided
            function getApiUrl($defaultUrl, $step, $otp = false, $referenceNumber = false)
            {
                if ($otp !== false && $referenceNumber !== false && $step === "terminate") {
                    // $req = "";
                    // if (strtolower($action) == 'inscription') {
                    //     $req .= "UPDATE  `event_candidates` SET isActive=2 WHERE candidate_uuid='$userUUID' AND event_id='$eventID';";
                    // }
                    // $req .= "UPDATE  `candidate_payments`SET isPayed=1 WHERE userUUID='$userUUID' AND event_id='$eventID' AND payment_reference='$reference';";
                    // $res = mysqli_multi_query(Constants::connect(), $req);
                    return $defaultUrl . "/" . $otp . "/" . $referenceNumber; // If OTP, reference number, and step are provided for termination, append them to the default URL
                }
                return $defaultUrl; // Otherwise, return the default URL
            }


            $apiUrl = getApiUrl("https://new.rawbankillico.com:4004/RAWAPIGateway/ecommerce/payment", $step, $otp, $referenceNumber); // Generate the API URL based on the provided step, OTP, and reference number
            $merchantId = "merch0000000000001201"; // Set the merchant ID
            $encryptKey = "12c672107a77dc0cbc497745ba485d83757d12bca441ef1aa435f1155f37769d"; // Set the encryption key
            $staticEncryptKey = "AX8dsXSKqWlJqRhpnCeFJ03CzqMsCisQVUNSymXKqeiaQdHf8eQSyITvCD6u3CLZJBebnxj5LbdosC/4OvUtNbAUbaIgBKMC5MpXGRXZdfAlGsVRfHTmjaGDe1RIiHKP"; // Set the static encryption key

            $headers = [
                "LogInName: e80ab5132d0371228c9a9bf4a6683f24c64ed034b62dbac0d6e14f3bbc159e25", // Set the login name header
                "LogInPass: 13b877262110efa70d83758943be359b18c12bb197f913f3c1219a87078ae142", // Set the login password header
                "Content-Type: application/json", // Set the content type header
                "Authorization: Basic " . base64_encode("37c135abe1b18aa42f46475d4097936d3594c1cc4106ddce4fe837380617cdce:2db4f4ba43a5230191212ab839cba69fbb93f3d46e0f406373c5232d6c6e33b5"), // Set the authorization header
            ];
            $phonenumber = '00243' . substr($phonenumber, -9);
            $paymentProcessor = new PaymentProcessor($apiUrl, $merchantId, $encryptKey, $staticEncryptKey, $headers, $step);
            $result = $paymentProcessor->runApi($phonenumber, $amount, $currency); // Process the payment with the provided mobile number and amount
            if (is_object($result)) {
                $result->apiurl = $apiUrl; // Add the API URL to the result object
                $result->step = $step; // Add the step to the result object
                $result->otp = $otp; // Add the OTP to the result object
            }
            echo json_encode($result);
        } else {
            $msg['state'] = false;
            $msg["error"] = "Bad gateway";
            echo json_encode($msg);
        }
    }
}
$payment = Payment::initPayment($_REQUEST);
