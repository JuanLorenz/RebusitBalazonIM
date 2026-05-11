<?php
session_start(); // ← add this at the very top
header('Content-Type: application/json');
require_once 'db_connect.php';

$idNumber = isset($_POST['idNumber']) ? trim($_POST['idNumber']) : '';
$password = isset($_POST['password']) ? trim($_POST['password']) : '';

if (empty($idNumber) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Please fill in all fields.']);
    exit;
}

$stmt = $conn->prepare("SELECT * FROM tbluser WHERE userID = ? AND password = ?");
$stmt->bind_param("ss", $idNumber, $password);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();

    // ← store in session so any page can access it
    $_SESSION['userID']    = $user['userID'];
    $_SESSION['user_type'] = $user['user_type'];
    $_SESSION['firstName'] = $user['firstName'];

    echo json_encode([
        'success'  => true,
        'role'     => $user['user_type'],
        'userID'   => $user['userID']
    ]);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid ID number or password.']);
}

$stmt->close();
$conn->close();
?>