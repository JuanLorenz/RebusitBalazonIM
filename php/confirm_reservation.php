<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"), true);

$reservationID = $data['reservationID'] ?? null;

if (!$reservationID) {
    echo json_encode([
        'success' => false,
        'message' => 'Missing reservationID.'
    ]);
    exit;
}

try {

    $stmt = $conn->prepare("
        UPDATE tblreservation
        SET status_type = 'Active'
        WHERE reservationID = ?
    ");

    if (!$stmt) {
        throw new Exception($conn->error);
    }

    $stmt->bind_param("i", $reservationID);

    if (!$stmt->execute()) {
        throw new Exception($stmt->error);
    }

    $stmt->close();

    echo json_encode([
        'success' => true,
        'message' => 'Reservation set to Active.'
    ]);

} catch (Exception $e) {

    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>