<?php
include_once '../../../api/config.php';
function getTransactionLog($orderNumber)
{
    // Step 1: Using file_get_contents
    $logContents = file_get_contents('flexpay_callback_log.txt');

    // Step 2: Using json_decode
    $decodedLog = json_decode($logContents, true);

    // Execute the sequence of server tasks and return the result.
    if (is_array($decodedLog) && count($decodedLog) > 0) {
        foreach ($decodedLog as $row) {
            $elementRow = json_decode($row, true);
            if ($elementRow['orderNumber'] === $orderNumber) {
                return $elementRow;
            }
        }
    }
}

// Read the incoming data from the callback
// Read the incoming data from the callback
$logFile = 'flexpay_callback_log.txt';



$callbackData = file_get_contents('php://input');
$existingLog = file_get_contents($logFile);

if (empty($existingLog)) {
    $dataArr = [$callbackData];
} else {
    $dataArr = json_decode($existingLog, true); // Decode as associative array
    $dataArr[] = $callbackData;
}

// Convert the array to JSON format
$newLog = json_encode($dataArr, JSON_PRETTY_PRINT);

// Write the new log back to the file
file_put_contents($logFile, $newLog);

// Updating tables for payment confirmation
$userUUID = trim(htmlentities($_GET['uuid']));
$eventID = trim(htmlentities($_GET['event']));
$action = trim(htmlentities($_GET['action']));
$reference = trim(htmlentities($_GET['reference']));

$req = "";
if (strtolower($action) == 'inscription') {
    $req .= "UPDATE  `event_candidates` SET isActive=2 WHERE candidate_uuid='$userUUID' AND event_id='$eventID';";
}
$req .= "UPDATE  `candidate_payments`SET isPayed=1 WHERE userUUID='$userUUID' AND event_id='$eventID' AND payment_reference='$reference';";
$res = mysqli_multi_query(Constants::connect(), $req);
echo $req;
