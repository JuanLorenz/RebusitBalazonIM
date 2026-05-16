<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

$idNumber = $_POST['idNumber'] ?? '';
$password = $_POST['password'] ?? '';

if (!$idNumber || !$password) {
    echo json_encode([
        'success' => false,
        'message' => 'Please fill in all fields.'
    ]);
    exit;
}

// ─── FETCH USER ─────────────────────────────
$stmt = $conn->prepare("SELECT * FROM tbluser WHERE userID = ?");
$stmt->bind_param("s", $idNumber);
$stmt->execute();

$result = $stmt->get_result();
$user = $result->fetch_assoc();

if (!$user) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid credentials.'
    ]);
    exit;
}

// ─── BLOCK CHECK (FIXED & CLEAN) ─────────────
if (
    $user['blocked_until'] !== null &&
    $user['blocked_until'] !== '0000-00-00 00:00:00' &&
    strtotime($user['blocked_until']) > time() &&
    $user['user_type'] !== 'Admin'
) {

    echo json_encode([
        'success' => false,
        'message' => 'Your account is blocked until ' .
            date("F j, Y g:i A", strtotime($user['blocked_until']))
    ]);

    exit;
}

// ─── PASSWORD CHECK ─────────────────────────
if (!password_verify($password, $user['password'])) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid credentials.'
    ]);
    exit;
}

// ─── CREATE SESSION ─────────────────────────
$_SESSION['userID'] = $user['userID'];
$_SESSION['user_type'] = $user['user_type'];
$_SESSION['firstName'] = $user['firstName'];

// ─── SUCCESS RESPONSE ───────────────────────
echo json_encode([
    'success' => true,
    'role' => $user['user_type'],
    'userID' => $user['userID']
]);

$stmt->close();
$conn->close();
?>