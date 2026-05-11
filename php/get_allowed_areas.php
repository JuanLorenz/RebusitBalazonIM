<?php
header('Content-Type: application/json');
session_start();
require_once 'db_connect.php';

// Get current user's departmentID from session
$userID = $_SESSION['userID'] ?? null;

if (!$userID) {
    echo json_encode([]);
    exit;
}

// Fetch user's department
$stmt = $conn->prepare("SELECT departmentID FROM tbluser WHERE userID = ?");
$stmt->bind_param("s", $userID);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();
$departmentID = $user['departmentID'] ?? null;

if (!$departmentID) {
    echo json_encode([]);
    exit;
}

// Get only study areas the user's department has access to
$stmt2 = $conn->prepare("
    SELECT sa.*
    FROM tblstudyarea sa
    LEFT JOIN tblarearestrictions ar 
        ON sa.areaID = ar.areaID

    WHERE 
        ar.departmentID = ?
        OR sa.areaID NOT IN (
            SELECT areaID FROM tblarearestrictions
        )

    GROUP BY sa.areaID
");
$stmt2->bind_param("s", $departmentID);
$stmt2->execute();
$result2 = $stmt2->get_result();

$areas = [];
while ($row = $result2->fetch_assoc()) {
    $areas[] = $row;
}

echo json_encode($areas);
$stmt2->close();
$conn->close();
?>