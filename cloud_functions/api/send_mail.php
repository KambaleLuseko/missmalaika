<?php
include_once './config.php';
// $senderEmail = isset($_POST['sender_email']) ? trim(htmlspecialchars($_POST['sender_email'])) : "";
// $senderName = isset($_POST['sender_name']) ? trim(htmlspecialchars($_POST['sender_name'])) : "";
// $subject = isset($_POST['subject']) ? trim(htmlspecialchars($_POST['subject'])) : "";
// $content = isset($_POST['content']) ? trim(htmlspecialchars($_POST['content'])) : "";

// if($){
//     return http_response_code(403);
// }
$to = 'providencekambale@nalediservices.com';


$message = "This is my test message";
$subject = "My subject";

// To send HTML mail, the Content-type header must be set
$headers  = 'MIME-Version: 1.0' . "\r\n";
$headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

// Additional headers
// $headers .= 'To: Mary <mary@example.com>, Kelly <kelly@example.com>' . "\r\n";
//$headers .= 'From: ' . $senderName ?? "Client" . ' <' . $senderEmail . '>' . "\r\n";
$headers .= "From: providencekambaleluseko@gmail.com\r\n";
$headers .= "X-Priority: 1\r\n";

// Mail it
echo mail($to, $subject, $message, $headers);

return http_response_code(200);





/**
 * Send an email using the PHP mail function.
 *
 * @param string $senderEmail The email address of the sender.
 * @param string $receiverEmail The email address of the recipient.
 * @param string $subject The subject of the email.
 * @param string $htmlContent The HTML content of the email.
 * @param string $from The name to appear as the sender in the email. (Optional, defaults to "Miss Malaika")
 * @return int Returns 1 if the email was sent successfully, 0 otherwise.
 */

// $receiverEmail = 'providencekambaleluseko@gmail.com';

// $htmlContent = "This is my test message";
// $subject = "My subject";
// $from = 'Providence';
// // Set the necessary email headers
// $headers = 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
// $headers .= 'MIME-Version: 1.0' . "\r\n";
// $senderEmail = 'skysoftwarecompany@gmail.com';

// // Set the "Return-Path" header based on the $from parameter (If $from is false, use $senderEmail as the return path)
// $headers .= 'Return-Path: ' . ($from == false ? $senderEmail : $from) . "\r\n";

// // Customize the "From" header, which will display the name and email of the sender in the recipient's email client.
// $headers .= 'From: ' . $from . ' <' . $senderEmail . '>' . "\r\n";

// // Initialize the $result variable to keep track of the success of sending the email
// $result = false;

// // Attempt to send the email using the mail() function
// if (mail('providencekambaleluseko@gmail.com', $subject, $htmlContent, $headers, '-f' . $senderEmail . '') == false) {
//     // If the email failed to send, set $result to 0 (failure)
//     $result = 0;
// } else {
//     // If the email was sent successfully, set $result to 1 (success)
//     $result = 1;
// }

// // Return the result indicating the success of sending the email
// echo $result;
// return $result;
