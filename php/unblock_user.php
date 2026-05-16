<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

// Get JSON input
$data = json_decode(file_get_contents("php://input"), true);
$userID = $data['userID'] ?? null;

// Validate input
if (!$userID) {
    echo json_encode([
        'success' => false,
        'message' => 'Missing userID.'
    ]);
    exit;
}

try {

    // Prepare statement (mysqli)
    $stmt = $conn->prepare("
        UPDATE tbluser
        SET blocked_until = NULL
        WHERE userID = ?
    ");

    if (!$stmt) {
        throw new Exception($conn->error);
    }

    // Bind parameter (STRING is safer unless you're 100% sure it's int)
    $stmt->bind_param("s", $userID);

    $stmt->execute();

    // Check if any row was actually updated
    if ($stmt->affected_rows === 0) {
        echo json_encode([
            'success' => false,
            'message' => 'No matching user found or already unblocked.'
        ]);
        $stmt->close();
        exit;
    }

    $stmt->close();

    echo json_encode([
        'success' => true,
        'message' => 'User unblocked successfully.'
    ]);

} catch (Exception $e) {

    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage()
    ]);
}
?>