<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

$areaID = isset($_GET['areaID']) ? intval($_GET['areaID']) : 0;

if ($areaID === 0) {
    echo json_encode([]);
    exit;
}

$stmt = $conn->prepare("SELECT * FROM tblresource WHERE areaID = ?");
$stmt->bind_param("i", $areaID);
$stmt->execute();
$result = $stmt->get_result();

$resources = [];
while ($row = $result->fetch_assoc()) {
    $resources[] = $row;
}

echo json_encode($resources);
$stmt->close();
$conn->close();
?>