<?php
require_once 'db_connect.php';

// Collect POST data
$firstName = $_POST['firstName'] ?? '';
$lastName = $_POST['lastName'] ?? '';
$userID = $_POST['userID'] ?? '';
$deptID = $_POST['deptID'] ?? '';
$email = $_POST['email'] ?? '';
$plainPassword = $_POST['password'] ?? '';

// Check if variables are empty
if(empty($userID) || empty($plainPassword)) {
    echo json_encode(['success' => false, 'message' => 'Missing data.']);
    exit;
}

// Hash the password
$hashedPassword = password_hash($plainPassword, PASSWORD_DEFAULT);

try {
    // Insert into tblUser
    // Default blocked_until is NULL and user_type is 'Patron'
    $sql = "INSERT INTO tblUser (userID, departmentID, firstName, lastName, email, password, user_type) 
            VALUES (?, ?, ?, ?, ?, ?, 'Patron')";
    
    $stmt = $conn->prepare($sql);
    $stmt->execute([$userID, $deptID, $firstName, $lastName, $email, $hashedPassword]);

    echo json_encode(['success' => true]);

} catch (PDOException $e) {
    // Handle duplicate ID or foreign key error (e.g. invalid Dept ID)
    echo json_encode(['success' => false, 'message' => "Database Error: " . $e->getMessage()]);
}
?>