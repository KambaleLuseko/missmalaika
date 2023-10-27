<?php
include_once 'config.php';
class SelectAll
{

    public function select($query)
    {
        if (Constants::connect() != null) {
            $result = Constants::connect()->query($query);
            // var_dump($result);
            if ($result->num_rows > 0) {
                $array = array();
                while ($row = $result->fetch_assoc()) {
                    array_push($array, $row);
                }
                print(json_encode($array));
            } else {
                print(json_encode("No data found"));
            }
        } else {
            print(json_encode("Cannot connect to Database Server"));
        }
    }
}
$sql = "";
if ($_POST['transaction'] == 'login') {
    $username = $_POST['username'];
    $pwd = $_POST['password'];
    $sql = "SELECT * FROM tusers where username='$username' and password='$pwd' AND LOWER(role)='admin'";
} else if (strtolower($_POST['transaction']) == "getvotes") {
    $uuid = isset($_POST['candidate_uuid']) && !empty(trim($_POST['candidate_uuid'])) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['candidate_uuid'])) : null;
    $sql = "";
    if ($uuid != null)
        $sql = "SELECT * FROM candidate_payments where candidate_uuid'$uuid'";
    else
        $sql = "SELECT * FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1";
} else if (strtolower($_POST['transaction']) == "getevent") {
    // $agentID=trim(mysqli_real_escape_string(Constants::connect(),$_POST['agentID']));
    $sql = "SELECT * from `events` where state='Pending' or state='Running'";
} else if (strtolower($_POST['transaction']) == "getnews") {
    if (!isset($_POST['filter']) || strtolower(trim($_POST['filter'])) == 'none') {
        $sql = "SELECT * FROM news ORDER BY id DESC";
    } else {
        $sql = "SELECT * FROM news ORDER BY id DESC LIMIT 3";
    }
} else if (strtolower($_POST['transaction']) == "getimages") {
    if (!isset($_POST['filter']) || strtolower(trim($_POST['filter'])) == 'none') {
        $sql = "SELECT * FROM galery_images ORDER BY id DESC";
    } else {
        $sql = "SELECT * FROM galery_images ORDER BY id DESC LIMIT 20";
    }
} else if ($_POST['transaction'] == 'testpayment') {
    // $confirmationData = ['fullname' => 'John', 'username' => rand(10000, 1000000), "pwd" => rand(), "transaction" => "newuser"];
    // $data = [
    //     "merchant_id" => $_POST['merchant_id'],
    //     "amount" => $_POST['amount'],
    //     "currency" => "USD",
    //     "description" => "Payment for cart",
    //     "confirmation_data" => $confirmationData,
    //     "confirmation_url" => "https://testprojects01.000webhostapp.com/ceremonies/saveClass.php",
    //     "confirmation_method" => "POST",
    //     "notificationMethod" => "email",
    //     "notificationValue" => $_POST['email'],

    // ];

    $data = ["authorizaton" => "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJcL2xvZ2luIiwicm9sZXMiOlsiTUVSQ0hBTlQiXSwiZXhwIjoxNzUzMjgyNTcyLCJzdWIiOiIxYmVlNmUwYWFkOTVjZmIwZmQ2NTViZTk5NDU0ZjIzNiJ9.fzamLtEfngWhI_v8fB2VvVcxLYCEvTdZxCf9CovLte4", "merchant" => "OZZONE", "reference" => "20231007151826078", "amount" => 10, "description" => "Paymentinscription", "callback_url" => "https://missmalaikardc.com/api/get_data.php", "approve_url" => "https://missmalaikardc.com/api/get_data.php", "decline_url" => "https://missmalaikardc.com/api/get_data.php", "cancel_url" => "https://missmalaikardc.com/api/get_data.php"];
    $ch = curl_init();
    try {
        curl_setopt($ch, CURLOPT_URL, 'https://cardpayment.flexpay.cd/v1/pay');
        // curl_setopt($ch, CURLOPT_URL, 'https://dpay-z4ib.onrender.com/transactions/merchant/initiate-payment');
        curl_setopt($ch, CURLOPT_HEADER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data),);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        // curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        // curl_setopt($ch, CURLOPT_HTTPHEADER, array(
        //     // "api_key: " . $_POST['api_key'],
        //     'Content-Type: application/x-www-form-urlencoded',
        // ));
        $response = curl_exec($ch);

        if (curl_errno($ch)) {
            echo curl_error($ch);
            die();
        }

        $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        if ($http_code == intval(200)) {
            echo $response;
            return;
        } else {
            echo "Ressource introuvable : " . $http_code;
            return;
        }
    } catch (Throwable $th) {
        throw $th;
    } finally {
        curl_close($ch);
    }
    return print(json_encode("No route found "));
} else {
    return print(json_encode("No route found "));
}
$delivery = new SelectAll();
$delivery->select($sql);
