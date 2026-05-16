<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

// ─── CHECK LOGIN ─────────────────────────────
if (!isset($_SESSION['userID'])) {
    echo json_encode([
        'success' => false,
        'message' => 'User not logged in.'
    ]);
    exit;
}

// ─── READ JSON INPUT ─────────────────────────
$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid JSON input.'
    ]);
    exit;
}

// ─── ASSIGN VALUES ───────────────────────────
$userID          = $_SESSION['userID'];
$resourceID      = $data['resourceID'] ?? null;
$purpose         = trim($data['purpose'] ?? '');
$startTime       = $data['startTime'] ?? null;
$endTime         = $data['endTime'] ?? null;
$numParticipants = $data['numParticipants'] ?? null;

// ─── VALIDATION ──────────────────────────────
if (
    !$resourceID ||
    $purpose === '' ||
    !$startTime ||
    !$endTime ||
    $numParticipants === null
) {
    echo json_encode([
        'success' => false,
        'message' => 'Missing required fields.'
    ]);
    exit;
}

try {

    // ─── MYSQLI PREPARED STATEMENT ─────────────
    $stmt = $conn->prepare("
        INSERT INTO tblreservation
        (
            userID,
            resourceID,
            purpose,
            startTime,
            endTime,
            num_participants,
            status_type
        )
        VALUES (?, ?, ?, ?, ?, ?, 'Pending')
    ");

    if (!$stmt) {
        throw new Exception($conn->error);
    }

    $stmt->bind_param(
        "iisssi",
        $userID,
        $resourceID,
        $purpose,
        $startTime,
        $endTime,
        $numParticipants
    );

    if (!$stmt->execute()) {
        throw new Exception($stmt->error);
    }

    echo json_encode([
        'success' => true,
        'message' => 'Reservation submitted successfully.'
    ]);

} catch (Exception $e) {

    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>