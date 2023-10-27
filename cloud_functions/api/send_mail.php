<?php
include_once './config.php';
$senderEmail = isset($_POST['sender_email']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['sender_email'])) : "";
$senderName = isset($_POST['sender_name']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['sender_name'])) : "";
$subject = isset($_POST['subject']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['subject'])) : "";
$content = isset($_POST['content']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['content'])) : "";

// if($){
//     return http_response_code(403);
// }
$to = 'skysoftwarecompany@gmail.com';


$message = $content;

// To send HTML mail, the Content-type header must be set
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

// Additional headers
// $headers .= 'To: Mary <mary@example.com>, Kelly <kelly@example.com>' . "\r\n";
$headers .= 'From: ' . $senderName ?? "Client" . ' <' . $senderEmail . '>' . "\r\n";

// Mail it
mail($to, $subject, $message, $headers);

return http_response_code(200);
