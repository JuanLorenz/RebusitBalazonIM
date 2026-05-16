<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

$firstName = $_POST['firstName'] ?? '';
$lastName  = $_POST['lastName'] ?? '';
$userID    = $_POST['userID'] ?? '';
$deptID    = $_POST['deptID'] ?? '';
$email     = $_POST['email'] ?? '';
$password  = $_POST['password'] ?? '';

if (!$userID || !$password) {
    echo json_encode(['success' => false, 'message' => 'Missing data.']);
    exit;
}

$hashedPassword = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("
    INSERT INTO tblUser 
    (userID, departmentID, firstName, lastName, email, password, user_type)
    VALUES (?, ?, ?, ?, ?, ?, 'Patron')
");

if (!$stmt) {
    echo json_encode(['success' => false, 'message' => $conn->error]);
    exit;
}

$stmt->bind_param(
    "ssssss",
    $userID,
    $deptID,
    $firstName,
    $lastName,
    $email,
    $hashedPassword
);

if ($stmt->execute()) {
    echo json_encode(['success' => true]);
} else {
    echo json_encode(['success' => false, 'message' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>