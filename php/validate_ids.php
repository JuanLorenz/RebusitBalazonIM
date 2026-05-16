<?php
header('Content-Type: application/json');
require_once 'db_connect.php';

$data = json_decode(file_get_contents("php://input"), true);

$idNumbers = $data['idNumbers'] ?? [];

if (empty($idNumbers)) {
    echo json_encode([
        'success' => false,
        'message' => 'No ID numbers provided.'
    ]);
    exit;
}

$invalidIDs = [];

$stmt = $conn->prepare("SELECT userID FROM tblUser WHERE userID = ?");

foreach ($idNumbers as $id) {

    $stmt->bind_param("s", $id);
    $stmt->execute();

    $result = $stmt->get_result();

    if ($result->num_rows === 0) {
        $invalidIDs[] = $id;
    }
}

$stmt->close();
$conn->close();

if (!empty($invalidIDs)) {

    echo json_encode([
        'success' => false,
        'invalidIDs' => $invalidIDs
    ]);

} else {

    echo json_encode([
        'success' => true
    ]);
}
?>