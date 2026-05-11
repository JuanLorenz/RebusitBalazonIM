<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

$areaID    = isset($_GET['areaID'])    ? intval($_GET['areaID'])        : 0;
$startTime = isset($_GET['startTime']) ? trim($_GET['startTime'])       : '';
$endTime   = isset($_GET['endTime'])   ? trim($_GET['endTime'])         : '';

if (!$areaID || !$startTime || !$endTime) {
    echo json_encode([]);
    exit;
}

// Get all resources for this area, excluding ones with overlapping reservations
$stmt = $conn->prepare("
    SELECT r.* FROM tblresource r
    WHERE r.areaID = ?
    AND r.resourceID NOT IN (
        SELECT res.resourceID FROM tblreservation res
        WHERE res.resourceID = r.resourceID
        AND res.status_type != 'Cancelled'
        AND res.startTime < ? 
        AND res.endTime > ?
    )
");
$stmt->bind_param("iss", $areaID, $endTime, $startTime);
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