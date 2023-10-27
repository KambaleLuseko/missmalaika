<?php
include_once 'config.php';
if (isset($_POST)) {
    if (strtolower($_POST['transaction']) == 'getcandidate') {
        $mainData = array();

        if (Constants::connect() != null) {
            $query = "SELECT tusers.*,event_candidates.isActive AS status, (SELECT path FROM candidate_images WHERE candidate_uuid=tusers.uuid ORDER BY id DESC LIMIT 1) AS imageUrl FROM tusers INNER JOIN event_candidates ON event_candidates.candidate_uuid=tusers.uuid INNER JOIN events ON event_candidates.event_id=events.id WHERE LOWER(role)='candidate' AND event_candidates.isActive=2 AND events.isActive=1 ORDER BY id DESC";
            if (isset($_POST['username']) && isset($_POST['password']) && !empty($_POST['username']) && !empty($_POST['password'])) {
                $username = trim(mysqli_real_escape_string(constants::connect(), $_POST['username']));
                $password = trim(mysqli_real_escape_string(constants::connect(), $_POST['password']));
                $query = "SELECT tusers.*,event_candidates.isActive AS status,(SELECT path FROM candidate_images WHERE candidate_uuid=tusers.uuid ORDER BY id DESC LIMIT 1) AS imageUrl FROM tusers INNER JOIN event_candidates ON event_candidates.candidate_uuid=tusers.uuid INNER JOIN events ON event_candidates.event_id=events.id WHERE LOWER(role)='candidate' AND username='$username' AND tusers.password='$password' AND event_candidates.isActive<>0 AND events.isActive=1 ORDER BY id DESC";
                // echo $query;
            }
            // print_r($query);
            $result = Constants::connect()->query($query);
            while ($row = $result->fetch_assoc()) {
                $details = array();
                $outStockData = array();
                $id = $row['uuid'];
                // print_r($row);
                $detQuery = "SELECT event_candidates.event_id, events.eventName, events.eventDescription, events.price from `events` INNER JOIN event_candidates on event_candidates.candidate_uuid='$id' AND events.id=event_candidates.event_id";
                $detResult = Constants::connect()->query($detQuery);
                // print_r(json_encode($subQuery));
                while ($detailRow = $detResult->fetch_assoc()) {
                    // print_r(json_encode($subRow));
                    array_push($details, $detailRow);
                }
                array_push($mainData, [
                    'id' => $row['id'],
                    'fullname' => $row['fullname'],
                    'email' => $row['email'],
                    'address' => $row['address'],
                    'phone' => $row['phone'],
                    'uuid' => $row['uuid'],
                    'created_at' => $row['created_at'],
                    'imageUrl' => $row['imageUrl'],
                    'isActive' => $row['isActive'],
                    'status' => $row['status'],
                    'event' => $details
                ]);
            }
            echo (json_encode($mainData));
        } else {
            echo (json_encode("Cannot connect to Database Server"));
        }
    } else if (strtolower($_POST['transaction']) == 'getvotes') {
        $mainData = array();
        $dashboard = array();

        if (Constants::connect() != null) {

            $dashReq = "SELECT (SELECT COUNT(*) FROM event_candidates WHERE event_id=events.id) AS totalCandidates, (SELECT COUNT(*) FROM event_candidates WHERE isActive=2 AND event_id=events.id) AS confirmedInscriptions,(SELECT COUNT(*) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id) AS userConfirmedVotes,(SELECT COUNT(*) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=0 AND event_id=events.id) AS userPendingVotes,IFNULL((SELECT SUM(points) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id), 0) AS totalUserConfirmedPoints,IFNULL((SELECT SUM(points) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=0 AND event_id=events.id),0) AS totalUserPendingPoints FROM events WHERE events.isActive=1;";
            $dashResult = Constants::connect()->query($dashReq);
            // print_r(json_encode($subQuery));
            while ($dashRow = $dashResult->fetch_assoc()) {
                // print_r(json_encode($subRow));
                array_push($dashboard, $dashRow);
            }
            $query = "SELECT tusers.*,event_candidates.isActive AS status, (SELECT path FROM candidate_images WHERE candidate_uuid=tusers.uuid ORDER BY id DESC LIMIT 1) AS imageUrl FROM tusers INNER JOIN event_candidates ON event_candidates.candidate_uuid=tusers.uuid INNER JOIN events ON event_candidates.event_id=events.id WHERE LOWER(role)='candidate' AND events.isActive=1 ORDER BY id DESC";
            if (isset($_POST['uuid']) && !empty($_POST['uuid'])) {
                $userUUID = trim(mysqli_real_escape_string(constants::connect(), $_POST['uuid']));
                $query = "SELECT tusers.*, event_candidates.isActive AS status FROM tusers INNER JOIN event_candidates ON event_candidates.candidate_uuid=tusers.uuid INNER JOIN events ON event_candidates.event_id=events.id WHERE LOWER(role)='candidate' AND uuid='$userUUID' AND events.isActive=1";
                // echo $query;
            }
            // print_r($query);
            $result = Constants::connect()->query($query);
            while ($row = $result->fetch_assoc()) {
                $details = array();
                $historyData = array();
                $id = $row['uuid'];
                // print_r($row);
                $detQuery = "SELECT (SELECT COUNT(*) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id) AS countConfirmed, (SELECT SUM(points) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id) AS totalConfirmedPoints,(SELECT COUNT(*) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id AND userUUID='$id') AS userConfirmedVotes,(SELECT COUNT(*) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=0 AND event_id=events.id AND userUUID='$id') AS userPendingVotes,IFNULL((SELECT SUM(points) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=1 AND event_id=events.id AND userUUID='$id'), 0) AS totalUserConfirmedPoints,IFNULL((SELECT SUM(points) FROM candidate_payments WHERE LOWER(action)='vote' AND isPayed=0 AND event_id=events.id AND userUUID='$id'),0) AS totalUserPendingPoints FROM events WHERE events.isActive=1;";
                $detResult = Constants::connect()->query($detQuery);
                // print_r(json_encode($subQuery));
                while ($detailRow = $detResult->fetch_assoc()) {
                    // print_r(json_encode($subRow));
                    array_push($details, $detailRow);
                }
                if (isset($userUUID) && !empty($userUUID)) {
                    $voteHistory = "SELECT candidate_payments.* FROM candidate_payments INNER JOIN events ON events.id=event_id WHERE LOWER(action)='vote' AND events.isActive=1 AND userUUID='$userUUID' ORDER BY candidate_payments.id DESC";
                    $voteRes = Constants::connect()->query($voteHistory);
                    // print_r(json_encode($subQuery));
                    while ($voteRow = $voteRes->fetch_assoc()) {
                        // print_r(json_encode($subRow));
                        array_push($historyData, $voteRow);
                    }
                }
                array_push($mainData, [
                    'id' => $row['id'],
                    'fullname' => $row['fullname'],
                    'email' => $row['email'],
                    'phone' => $row['phone'],
                    'uuid' => $row['uuid'],
                    'created_at' => $row['created_at'],
                    'imageUrl' => $row['imageUrl'] ?? null,
                    'isActive' => $row['isActive'],
                    'status' => $row['status'],
                    'votes' => $details[0],
                    'history' => (isset($userUUID)) ? $historyData : []
                ]);
            }
            echo (json_encode(["dashboard" => $dashboard[0], "candidatesStats" => $mainData]));
        } else {
            echo (json_encode("Cannot connect to Database Server"));
        }
    } else {
        echo json_encode('this route not found');
    }
} else {
    echo json_encode('Invalid data submitted');
}
