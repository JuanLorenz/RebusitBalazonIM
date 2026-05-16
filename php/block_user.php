<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"), true);

$userID = $data['userID'] ?? null;

if (!$userID) {
    echo json_encode([
        'success' => false,
        'message' => 'Missing userID.'
    ]);
    exit;
}

try {

    $stmt = $conn->prepare("
        UPDATE tbluser
        SET blocked_until = NOW()
        WHERE userID = ?
    ");

    $stmt->bind_param("i", $userID);

    if (!$stmt->execute()) {
        throw new Exception($stmt->error);
    }

    $stmt->close();

    echo json_encode([
        'success' => true,
        'message' => 'User blocked successfully.'
    ]);

} catch (Exception $e) {

    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>