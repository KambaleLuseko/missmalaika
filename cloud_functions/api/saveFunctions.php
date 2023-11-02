<?php include_once 'config.php';

class Save
{
    public function saveEvent()
    {
        $msg = array();
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";

            $eventName  = trim(mysqli_real_escape_string(constants::connect(), $_POST['eventName']));
            $eventDescription = trim(mysqli_real_escape_string(constants::connect(), $_POST['eventDescription']));
            $eventCategorie = trim(mysqli_real_escape_string(constants::connect(), $_POST['eventCategorie']));
            $eventDate = trim(mysqli_real_escape_string(constants::connect(), $_POST['eventDate']));
            $startAt = trim(mysqli_real_escape_string(constants::connect(), $_POST['startAt']));
            $endAt = trim(mysqli_real_escape_string(constants::connect(), $_POST['endAt']));
            $price = trim(mysqli_real_escape_string(constants::connect(), $_POST['price']));
            $places = trim(mysqli_real_escape_string(constants::connect(), $_POST['places']));

            if ($eventName == "" || $eventDescription == "" || $eventCategorie == "" || $eventDate == "" || $startAt == "" || $endAt == "" || $price == "" || $places == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                try {
                    $querry1 = "INSERT INTO `events` (`eventName`, `eventDescription`, `eventCategorie`, `eventDate`, `startAt`, `endAt`, `price`, `places`) VALUES ('$eventName', '$eventDescription', '$eventCategorie', '$eventDate', '$startAt', '$endAt', '$price', '$places')";
                    $res = mysqli_query(Constants::connect(), $querry1);
                    if ($res) {
                        $msg["state"] = "Event added successfuly";
                    } else
                        $msg["error"] .= "Server error while saving";
                } catch (Exception $e) {
                    $msg["error"] = "server error";
                    Constants::connect()->rollback();
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg["error"] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function saveCandidate()
    {
        $msg = array();
        // print('request');
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";
            // $client=json_decode($_POST['client']);
            $nom  = trim(mysqli_real_escape_string(Constants::connect(), $_POST['fullname']));;
            $adresse = trim(mysqli_real_escape_string(Constants::connect(), $_POST['address']));
            $telephone = trim(mysqli_real_escape_string(Constants::connect(), $_POST['phone']));
            $email = trim(mysqli_real_escape_string(Constants::connect(), $_POST['email']));
            $username = trim(mysqli_real_escape_string(Constants::connect(), $_POST['username']));
            $password = trim(mysqli_real_escape_string(Constants::connect(), $_POST['password']));
            $image = isset($_POST['imageBytes']) && !empty($_POST['imageBytes']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['imageBytes'])) : null;
            $uuid = rand(10000, 1000000) . date('YmdHis');

            $eventID = "";
            if ($nom == "" || $adresse == "" || $telephone == "" || $email == "" || $username == "" || $password == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                $checkUser = "select * from tusers where username='$username';";
                $userRes = mysqli_query(Constants::connect(), $checkUser);
                if (mysqli_num_rows($userRes) >= 1) {
                    $msg['state'] = "false";
                    $msg["error"] .= "Ce nom d'utilisateur est deja utilisé.";
                    echo json_encode($msg);
                    return;
                }
                $checkEvent = "select id from events where isActive=1 LIMIT 1;";
                $response = mysqli_query(Constants::connect(), $checkEvent);
                if (mysqli_num_rows($response) < 1) {
                    $msg["error"] .= "Aucun evenement ouvert pour les inscriptions";
                } else {

                    while ($row = mysqli_fetch_assoc($response)) {
                        $eventID = $row['id'];
                    }
                    try {

                        $to = $email;

                        // subject
                        $subject = 'Inscription Miss Malaika';

                        $message = "
                            <html>
                            <head>
                            <title>Miss Malaika</title>
                            </head>
                            <body>
                            <p>
                                Bienvenue dans MISS MALAIKA 2024. Pour valider votre compte candidate, cliquez sur le bouton <b>J'active mon compte sur la page des candidates</b> et payez votre inscription 10$. 
                                Tapez votre adresse mail et votre mot de passe puis payez les frais d'inscription. Une fois le paiement confirmé, vous pouvez vous connecter. Vous y suivrez en temps réel l'évolution de vos votes pendant la compétition.<br/>Les votes commencent le 1er Janvier 2024. Si vous avez des questions, n'hésitez pas à nous écrire à candidates@missmalaikardc.com ou dans le groupe whatsapp des candidates. Nous sommes à votre disposition. <br/>Bonne chance pour la compétition!<br/><b>L'Équipe d'Organisation</b>
                            </p>
                            </body>
                            </html>
                            ";

                        // To send HTML mail, the Content-type header must be set
                        $headers  = 'MIME-Version: 1.0' . "\r\n";
                        $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";

                        // Additional headers
                        // $headers .= 'To: Mary <mary@example.com>, Kelly <kelly@example.com>' . "\r\n";
                        $headers .= 'From: Miss Malaika <info@missmalaikardc.com>' . "\r\n";

                        // Mail it
                        mail($to, $subject, $message, $headers);

                        $fileName = 'candidate-' . rand(1000000, 1000000000000) . date('YmdHis') . '.png';
                        $path = "/uploads/$fileName";
                        if (isset($image)) {
                            file_put_contents('.' . $path, base64_decode($image));
                        }
                        $uuid = $this->generateUuid($eventID);
                        $query1 = "INSERT INTO `tusers` (`fullname`,`address`, `phone`, `email`,`username`, `password`, `uuid`) VALUES('$nom', '$adresse','$telephone','$email', '$username', '$password', '$uuid');";
                        $query2 = "INSERT INTO `event_candidates` (`event_id`,`candidate_uuid`) VALUES('$eventID', '$uuid');";
                        if (isset($image)) {
                            $query3 = "INSERT INTO `candidate_images` (`candidate_uuid`,`path`, `file_name`, `event_id`) VALUES('$uuid', '$path', '$fileName', '$eventID');";
                            // $res=mysqli_query(Constants::connect(), $querry5);
                            $res = mysqli_multi_query(Constants::connect(), $query1 . $query2 . $query3);
                        } else {
                            $res = mysqli_multi_query(Constants::connect(), $query1 . $query2);
                        }
                        if ($res) {
                            $msg["state"] = "success";
                            Constants::connect()->query("commit;");
                        } else {
                            var_dump(Constants::connect()->error);
                            Constants::connect()->query("rollback;");
                            $msg["error"] .= "Server error while saving";
                        }
                    } catch (Exception $e) {
                        var_dump($e);
                        $msg["error"] .= "Server error";
                        Constants::connect()->query("rollback;");
                    }
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg['error'] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    static function generateUuid($eventID)
    {
        $eventDate = "";
        $candidateID = "";
        $event = mysqli_query(Constants::connect(), "SELECT events.*, (SELECT COUNT(*)+1 FROM event_candidates WHERE event_id=$eventID) AS lastID FROM events WHERE id=$eventID");
        while ($row = mysqli_fetch_assoc($event)) {
            $eventDate = $row['eventDate'];
            $candidateID = "MM" . substr($eventDate, 2, 2) . '-' . str_pad((intval($row['lastID'])), 4, '0', STR_PAD_LEFT);
        }
        return $candidateID;
    }

    public function candidatePayment()
    {
        $msg = array();
        if (isset($_POST)) {
            $msg["error"] = "";
            $msg["state"] = "";
            $ref_IDcarte = trim(mysqli_real_escape_string(Constants::connect(), $_POST['cardID']));
            $agentID = trim(mysqli_real_escape_string(Constants::connect(), $_POST['agentID']));
            $eventID = trim(mysqli_real_escape_string(Constants::connect(), $_POST['eventID']));

            if ($ref_IDcarte == "" || $agentID == "" || $eventID == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                $checkCard = "select * from t_client where cardID='$ref_IDcarte';";
                $response = mysqli_query(Constants::connect(), $checkCard);
                if (mysqli_num_rows($response) < 1) {
                    $msg["error"] .= "Cette carte n'existe pas";
                } else {
                    $checkUsageState = "select * from ticket_control where cardID='$ref_IDcarte' and eventID='$eventID';";
                    $response = mysqli_query(Constants::connect(), $checkUsageState);
                    if (mysqli_num_rows($response) >= 1) {
                        $msg["error"] .= "Cette carte est déjà utilisé";
                    } else {
                        try {
                            $query = "INSERT INTO `ticket_control`(eventID, agentID, cardID) values('$eventID', '$agentID', '$ref_IDcarte');";
                            // $res=mysqli_query(Constants::connect(), $querry5);
                            $res = mysqli_query(Constants::connect(), $query);
                            if ($res) {
                                $msg["state"] = "success";
                                Constants::connect()->query("commit;");
                            } else {
                                var_dump(Constants::connect()->error);
                                Constants::connect()->query("rollback;");
                                $msg["error"] .= "Server error while saving";
                            }
                        } catch (Exception $e) {
                            var_dump($e);
                            $msg["error"] .= "Server error";
                            Constants::connect()->query("rollback;");
                        }
                    }
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg['error'] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function saveNews()
    {
        $msg = array();
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";

            $id  = isset($_POST['id']) && !empty($_POST['id']) ? trim(mysqli_real_escape_string(Constants::connect(), $_POST['id'])) : NULL;
            $title  = trim(mysqli_real_escape_string(Constants::connect(), $_POST['title']));
            $summary = trim(mysqli_real_escape_string(constants::connect(), $_POST['summary']));
            $content = trim(mysqli_real_escape_string(constants::connect(), $_POST['content']));
            $publisher = isset($_POST['publisher']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['publisher'])) : null;
            $uuid = isset($_POST['uuid']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['uuid'])) : rand(1000000, 1000000000000) . date('YmdHis');
            $image = isset($_POST['imageBytes']) && !empty($_POST['imageBytes']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['imageBytes'])) : null;
            if (!isset($uuid) || empty($uuid)) {
                $uuid = rand(10000, 1000000) . date('YmdHisv');
            }
            if (!isset($image) || empty($image)) {
                $image = null;
            }

            if (!isset($publisher) || empty($publisher)) {
                $publisher = "Miss Malaika";
            }

            if ($title == "" || $summary == "" || $content == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                try {
                    $fileName = '';
                    $path = "";
                    if (isset($image)) {
                        $fileName = 'news-' . rand(1000000, 1000000000000) . date('YmdHis') . '.png';
                        $path = "/uploads/$fileName";
                        file_put_contents('.' . $path, base64_decode($image));
                    }
                    $querry1 = "INSERT INTO `news` (`title`, `summary`, `content`, `publisher`, `uuid`, `image`) VALUES ('$title', '$summary', '$content', '$publisher', '$uuid', '$path')";
                    if (isset($id) && !empty($id) && $id != NULL) {
                        $querry1 = "INSERT INTO `news` (`id`,`title`, `summary`, `content`, `publisher`, `uuid`, `image`) VALUES ('$id','$title', '$summary', '$content', '$publisher', '$uuid', '$path') ON DUPLICATE KEY UPDATE `title`='$title', `summary`='$summary', `content`='$content'";
                    }
                    $res = mysqli_query(Constants::connect(), $querry1);
                    if ($res) {
                        $msg["state"] = "success";
                    } else
                        $msg["error"] .= "Server error while saving";
                } catch (Exception $e) {
                    $msg["error"] = "server error";
                    Constants::connect()->rollback();
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg["error"] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function saveGaleryImage()
    {
        $msg = array();
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";

            $title  = trim(mysqli_real_escape_string(constants::connect(), $_POST['title']));
            $image = isset($_POST['imageBytes']) && !empty($_POST['imageBytes']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['imageBytes'])) : null;

            if (!isset($publisher) || empty($publisher)) {
                $publisher = "Miss Malaika";
            }

            if ($title == "" || $image == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                try {
                    $fileName = 'galery-' . rand(1000000, 1000000000000) . date('YmdHis') . '.png';
                    $path = "/uploads/$fileName";
                    if (isset($image)) {
                        file_put_contents('.' . $path, base64_decode($image));
                    }
                    $querry1 = "INSERT INTO `galery_images` (`title`, `path`) VALUES ('$title', '$path')";
                    $res = mysqli_query(Constants::connect(), $querry1);
                    if ($res) {
                        $msg["state"] = "success";
                    } else
                        $msg["error"] .= "Server error while saving";
                } catch (Exception $e) {
                    $msg["error"] = "server error";
                    Constants::connect()->rollback();
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg["error"] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function deleteGaleryImage()
    {
        $msg = array();
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";

            $id  = trim(mysqli_real_escape_string(constants::connect(), $_POST['id']));
            $image = isset($_POST['path']) && !empty($_POST['path']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['path'])) : null;

            if ($id == "" || $image == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                try {
                    if (isset($image)) {
                        unlink('.' . $image);
                    }
                    $querry1 = "DELETE FROM `galery_images` WHERE id=$id";
                    $res = mysqli_query(Constants::connect(), $querry1);
                    if ($res) {
                        $msg["state"] = "success";
                    } else
                        $msg["error"] .= "Server error while saving";
                } catch (Exception $e) {
                    $msg["error"] = "server error";
                    Constants::connect()->rollback();
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg["error"] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function deleteNews()
    {
        $msg = array();
        if (isset($_POST)) {

            $msg["error"] = "";
            $msg["state"] = "";

            $id  = trim(mysqli_real_escape_string(constants::connect(), $_POST['id']));
            $image = isset($_POST['path']) && !empty($_POST['path']) ? trim(mysqli_real_escape_string(constants::connect(), $_POST['path'])) : null;

            if ($id == "") {
                $msg["error"] .= 'Donnees invalides';
            } else {
                try {
                    if (isset($image) && !empty($image)) {
                        unlink('.' . $image);
                    }
                    $querry1 = "DELETE FROM `news` WHERE id=$id";
                    $res = mysqli_query(Constants::connect(), $querry1);
                    if ($res) {
                        $msg["state"] = "success";
                    } else
                        $msg["error"] .= "Server error while saving";
                } catch (Exception $e) {
                    $msg["error"] = "server error";
                    Constants::connect()->rollback();
                }
            }

            mysqli_close(Constants::connect());
        } else {
            $msg["error"] .= 'Data not received';
        }
        echo json_encode($msg);
    }

    public function updateAgentPwd()
    {
        if (isset($_POST)) {
            $msg = "";
            $matricule = trim(mysqli_real_escape_string(Constants::connect(), $_POST['matricule']));
            $lastPwd = trim(mysqli_real_escape_string(Constants::connect(), $_POST['lastPwd']));
            $newPwd = trim(mysqli_real_escape_string(Constants::connect(), $_POST['newPwd']));
            if ($lastPwd == "" || $newPwd == "") {
                $msg = "Donnees invalides";
            } else {
                $checkAccount = "SELECT * FROM devise where ref_matricule='$matricule' and pwd='$lastPwd'";
                $response = mysqli_query(Constants::connect(), $checkAccount);
                if (mysqli_num_rows($response) == 1) {
                    $updateAccount = "UPDATE devise set pwd='$newPwd' where ref_matricule='$matricule'";
                    $execQuery = mysqli_query(Constants::connect(), $updateAccount);
                    if ($execQuery) {
                        $msg = "success";
                    } else {
                        $msg = "error occured";
                    }
                } else {
                    $msg = "Ancien mot de passe incorrect";
                }
            }
        } else {
            $msg = 'Data not received';
        }
        echo json_encode($msg);
    }
}
$saveInstance = new Save();
if (strtolower($_POST['transaction']) == "addevent") {
    $saveInstance->saveEvent();
} else if (strtolower($_POST['transaction']) == "newcandidate") {
    $saveInstance->saveCandidate();
} else if (strtolower($_POST['transaction']) == "addnews") {
    $saveInstance->saveNews();
} else if (strtolower($_POST['transaction']) == "addimage") {
    $saveInstance->saveGaleryImage();
} else if (strtolower($_POST['transaction']) == "deleteimage") {
    $saveInstance->deleteGaleryImage();
} else if (strtolower($_POST['transaction']) == "deletenews") {
    $saveInstance->deleteNews();
} else {
    echo 'no transaction';
}
