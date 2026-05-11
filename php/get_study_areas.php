<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

$result = $conn->query("SELECT areaID, areaName FROM tblstudyarea ORDER BY areaName ASC");

$areas = [];
while ($row = $result->fetch_assoc()) {
    $areas[] = $row;
}

echo json_encode($areas);
$conn->close();
?>