<?php
session_start();
header('Content-Type: application/json');

require_once 'db_connect.php';

$page   = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$limit  = 10;
$offset = ($page - 1) * $limit;

// ── Helper ─────────────────────────────────────────────────────────────────
function runQuery($conn, $sql, $limit, $offset) {
    $stmt = $conn->prepare($sql);
    if (!$stmt) return ['error' => 'prepare: ' . $conn->error];
    $stmt->bind_param("ii", $limit, $offset);
    if (!$stmt->execute()) return ['error' => 'execute: ' . $stmt->error];
    $result = $stmt->get_result();
    $rows = [];
    while ($row = $result->fetch_assoc()) $rows[] = $row;
    $stmt->close();
    return ['rows' => $rows];
}

// ── Total count ────────────────────────────────────────────────────────────
$countResult = $conn->query("SELECT COUNT(*) AS total FROM tblreservation");
if (!$countResult) {
    echo json_encode(['success' => false, 'message' => 'Count failed: ' . $conn->error]);
    exit;
}
$total      = (int) $countResult->fetch_assoc()['total'];
$totalPages = max(1, (int) ceil($total / $limit));

// ── Try JOIN with tbluser, fallback to no join ─────────────────────────────
$joinSQL = "
    SELECT r.reservationID, r.userID, r.resourceID,
           r.purpose, r.startTime, r.endTime,
           r.num_participants, r.status_type,
           u.firstName, u.lastName
    FROM tblreservation r
    LEFT JOIN tbluser u ON r.userID = u.userID
    ORDER BY r.reservationID DESC
    LIMIT ? OFFSET ?
";

$simpleSQL = "
    SELECT reservationID, userID, resourceID,
           purpose, startTime, endTime,
           num_participants, status_type,
           NULL AS firstName, NULL AS lastName
    FROM tblreservation
    ORDER BY reservationID DESC
    LIMIT ? OFFSET ?
";

$result = runQuery($conn, $joinSQL, $limit, $offset);

if (isset($result['error'])) {
    $joinErr = $result['error'];
    $result  = runQuery($conn, $simpleSQL, $limit, $offset);
    if (isset($result['error'])) {
        echo json_encode(['success' => false, 'message' => 'JOIN: ' . $joinErr . ' | Simple: ' . $result['error']]);
        exit;
    }
    echo json_encode([
        'success'      => true,
        'reservations' => $result['rows'],
        'total'        => $total,
        'totalPages'   => $totalPages,
        'currentPage'  => $page,
        'warning'      => 'JOIN failed: ' . $joinErr
    ]);
    exit;
}

echo json_encode([
    'success'      => true,
    'reservations' => $result['rows'],
    'total'        => $total,
    'totalPages'   => $totalPages,
    'currentPage'  => $page
]);
?>