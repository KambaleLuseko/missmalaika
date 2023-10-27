<?php
header("Access-Control-Allow-Origin: *");
ini_set('upload_max_filesize', '50M');
ini_set('post_max_size', '55M');
include_once '../../../api/config.php';
class PaymentProcessor2
{
    private $apiUrl; // The API URL for payment processing
    private $merchantId; // The merchant ID
    private $encryptKey; // The encryption key
    private $staticEncryptKey; // The static encryption key

    private $header;

    private $step;

    public function __construct($apiUrl, $merchantId, $encryptKey, $staticEncryptKey, $header, $step)
    {
        $this->apiUrl = $apiUrl; // Assign the provided API URL to the private property $apiUrl
        $this->merchantId = $merchantId; // Assign the provided merchant ID to the private property $merchantId
        $this->encryptKey = $encryptKey; // Assign the provided encryption key to the private property $encryptKey
        $this->staticEncryptKey = $staticEncryptKey; // Assign the provided static encryption key to the private property $staticEncryptKey
        $this->header = $header; // Assign the provided headers to the private property $header
        $this->step = $step; // Assign the provided step to the private property $step
    }

    /**
     * Generate a random invoice number.
     * 
     * @param int $length The length of the invoice number (default: 8)
     * @return string The generated invoice number
     */
    public function generateRandomInvoiceNumber($length = 8)
    {
        $characters = '0123456789'; // Define a string of characters containing digits 0-9
        $invoiceNumber = ''; // Initialize an empty string to store the generated invoice number

        $charactersLength = strlen($characters); // Get the length of the characters string
        for ($i = 0; $i < $length; $i++) {
            $invoiceNumber .= $characters[rand(0, $charactersLength - 1)]; // Append a random character from the characters string to the invoice number
        }

        return $invoiceNumber; // Return the generated invoice number
    }

    /**
     * Convert amount to ISO currency format.
     *
     * @param float $amount The amount to convert
     * @return string The amount in ISO currency format
     */
    public function convertToISOCurrencyFormat($amount)
    {
        return number_format($amount, 2, '.', ''); // Format the amount to have two decimal places and use dot as the decimal separator
    }

    /**
     * Process a payment.
     * 
     * @param string $mobileNumber The mobile number for payment
     * @param float $amount The payment amount
     * @param array $headers The request headers
     * @return array The payment response
     */

    private function handleResponse($result)
    {
        if (isset($result['http_status']) && intval($result['http_status']) === 200 && isset($result["respcode"]) && $result["respcode"] === "00") {
            return json_decode($result['server_response']); // If the response has HTTP status 200 and respcode is "00", decode the server response as JSON and return it
        } else {
            $decodedResult = json_decode($result['server_response']); // Otherwise, decode the server response as JSON
            return $decodedResult; // Return the decoded result
        }
    }

    public function runApi($mobileNumber, $amount, $currency)
    {
        if ($this->step === "getotp") {
            return $this->processPayment($mobileNumber, $amount, $currency); // If the step is "getotp", process the payment
        }
        if ($this->step === "terminate") {
            return $this->terminatePayment(); // If the step is "terminate", terminate the payment
        }
    }

    private function terminatePayment()
    {
        return $this->talkToApi([]); // Terminate the payment by calling the API with an empty data array
    }
    private function processPayment($mobileNumber, $amount, $currency)
    {
        // Validate input
        if (!is_numeric($amount) || $amount <= 0) {
            return ["error" => "Invalid amount"]; // If the amount is not numeric or less than or equal to 0, return an error message
        }

        $amountISO = $this->convertToISOCurrencyFormat($amount); // Convert the amount to ISO currency format

        $data = [
            "mobilenumber" => $mobileNumber, // Set the mobile number in the data array
            "trancurrency" => $currency, // Set the transaction currency to USD
            "amounttransaction" => $amountISO, // Set the transaction amount in ISO currency format
            "merchantid" => $this->merchantId, // Set the merchant ID
            "invoiceid" => $this->generateRandomInvoiceNumber(), // Generate a random invoice number
            "terminalid" => "12345986789012", // Set the terminal ID
            "encryptkey" => $this->staticEncryptKey, // Set the encryption key
            //"staticencryptkey" => $this->staticEncryptKey,
            "securityparams" => [
                "gpslatitude" => "24.864190", // Set the GPS latitude
                "gpslongitude" => "67.090420" // Set the GPS longitude
            ]
        ];
        return $this->talkToApi($data); // Call the API with the prepared data


    }
    private function runCurl($data = [])
    {
        if ($this->step === "getotp") {
            return $this->postCurl($data); // If the step is "getotp", perform a POST request using cURL
        }
        if ($this->step === "terminate") {
            return $this->getCurl(); // If the step is "terminate", perform a GET request using cURL
        }
    }

    private function getCurl()
    {
        $ch = curl_init(); // Initialize a cURL session
        curl_setopt($ch, CURLOPT_HTTPHEADER, $this->header); // Set the HTTP headers for the request
        curl_setopt($ch, CURLOPT_URL, $this->apiUrl); // Set the URL to which the request is sent
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); // Return the response instead of outputting it directly
        curl_setopt($ch, CURLOPT_TIMEOUT, 20); // Set the maximum time in seconds that the request is allowed to take
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10); // Set the maximum time in seconds to wait for a connection to be established
        $result = array(); // Initialize an array to store the result
        $result['server_response'] = curl_exec($ch); // Execute the cURL request and store the server response

        if ($result['server_response'] === false) {
            $result['error'] = curl_error($ch); // If an error occurred, store the error message
        } else {
            $curl_info = curl_getinfo($ch);
            $result['http_status'] = $curl_info['http_code']; // Get the HTTP status code of the response
        }

        curl_close($ch); // Close the cURL session
        return $result; // Return the result
    }

    private function postCurl($data)
    {
        $postBody = json_encode($data); // Convert the data array to JSON format
        $ch = curl_init(); // Initialize a cURL session
        curl_setopt($ch, CURLOPT_HTTPHEADER, $this->header); // Set the HTTP headers for the request
        curl_setopt($ch, CURLOPT_URL, $this->apiUrl); // Set the URL to which the request is sent
        curl_setopt($ch, CURLOPT_POST, 1); // Set the request method to POST
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); // Return the response instead of outputting it directly
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postBody); // Set the POST data
        curl_setopt($ch, CURLOPT_TIMEOUT, 20); // Set the maximum time in seconds that the request is allowed to take
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10); // Set the maximum time in seconds to wait for a connection to be established
        $result = array(); // Initialize an array to store the result
        $result['server_response'] = curl_exec($ch); // Execute the cURL request and store the server response

        if ($result['server_response'] === false) {
            $result['error'] = curl_error($ch); // If an error occurred, store the error message
        } else {
            $curl_info = curl_getinfo($ch);
            $result['http_status'] = $curl_info['http_code']; // Get the HTTP status code of the response
        }

        curl_close($ch); // Close the cURL session
        return $result; // Return the result
    }
    private function talkToApi($data)
    {
        $result = $this->runCurl($data); // Perform the cURL request and get the result
        return $this->handleResponse($result); // Handle the API response and return it
    }
}

// Example usage:
function getApiUrl($defaultUrl, $step, $otp = false, $referenceNumber = false)
{
    if ($otp !== false && $referenceNumber !== false && $step === "terminate") {
        return $defaultUrl . "/" . $otp . "/" . $referenceNumber; // If OTP, reference number, and step are provided for termination, append them to the default URL
    }
    return $defaultUrl; // Otherwise, return the default URL
}


$step = isset($_REQUEST["step"]) ? $_REQUEST["step"] : "undefined"; // Get the step from the request parameters or set it to "undefined" if not provided
$otp = isset($_REQUEST["otp"]) ? $_REQUEST["otp"] : false; // Get the OTP from the request parameters or set it to false if not provided
$referenceNumber = isset($_REQUEST["referencenumber"]) ? $_REQUEST["referencenumber"] : false; // Get the reference number from the request parameters or set it to false if not provided

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

$paymentProcessor = new PaymentProcessor2($apiUrl, $merchantId, $encryptKey, $staticEncryptKey, $headers, $step); // Create an instance of the PaymentProcessor class

$mobileNumber = isset($_POST["mobilenumber"]) ? $_POST["mobilenumber"] : '0000000000'; // Get the mobile number from the request parameters or set it to '0000000000' if not provided
$amount = isset($_POST["amount"]) ? $_POST["amount"] : 0; // Get the amount from the request parameters or set it to 0 if not provided
$currency = isset($_POST["currency"]) ? $_POST["currency"] : "USD"; // Get the amount from the request parameters or set it to 0 if not provided
// print($mobileNumber);
// print($amount);
// print($currency);
$result = $paymentProcessor->runApi($mobileNumber, $amount, $currency); // Process the payment with the provided mobile number and amount
if (is_object($result)) {
    $result->apiurl = $apiUrl; // Add the API URL to the result object
    $result->step = $step; // Add the step to the result object
    $result->otp = $otp; // Add the OTP to the result object
}
echo json_encode($result); // Convert the result to JSON format and echo it as the response
