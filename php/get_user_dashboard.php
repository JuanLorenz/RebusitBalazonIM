<?php
session_start();
header('Content-Type: application/json');
require_once 'db_connect.php';

$userID = $_SESSION['userID'] ?? null;
if (!$userID) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

// Pagination setup
$limit = 10;
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$offset = ($page - 1) * $limit;

try {
    // --- AUTO-STATUS TRANSITION LOGIC ---
    // 1. If Pending and StartTime has passed -> NoShow
    $stmtNoShow = $conn->prepare("UPDATE tblreservation SET status_type = 'NoShow' WHERE status_type = 'Pending' AND startTime < NOW()");
    $stmtNoShow->execute();

    // 2. If Active and EndTime has passed -> Completed
    $stmtComplete = $conn->prepare("UPDATE tblreservation SET status_type = 'Completed' WHERE status_type = 'Active' AND endTime < NOW()");
    $stmtComplete->execute();


    // --- FETCH DATA ---
    // Check if User is Blocked
    $userStmt = $conn->prepare("SELECT blocked_until FROM tbluser WHERE userID = ?");
    $userStmt->bind_param("s", $userID);
    $userStmt->execute();
    $userData = $userStmt->get_result()->fetch_assoc();
    
    $isBlocked = false;
    $blockedDate = null;
    if ($userData && !empty($userData['blocked_until'])) {
        $blockedDate = $userData['blocked_until'];
        if (strtotime($blockedDate) > time()) $isBlocked = true;
    }

    // Get current active/pending box
    $activeStmt = $conn->prepare("
        SELECT r.*, res.resourceName, sa.areaName
        FROM tblreservation r
        LEFT JOIN tblresource res ON r.resourceID = res.resourceID
        LEFT JOIN tblstudyarea sa ON res.areaID = sa.areaID
        WHERE r.userID = ? AND (r.status_type = 'Pending' OR r.status_type = 'Active')
        LIMIT 1
    ");
    $activeStmt->bind_param("s", $userID);
    $activeStmt->execute();
    $activeRes = $activeStmt->get_result()->fetch_assoc();

    // History Pagination count
    $countStmt = $conn->prepare("SELECT COUNT(*) as total FROM tblreservation WHERE userID = ? AND status_type NOT IN ('Pending', 'Active')");
    $countStmt->bind_param("s", $userID);
    $countStmt->execute();
    $totalRows = $countStmt->get_result()->fetch_assoc()['total'];
    $totalPages = ceil($totalRows / $limit);

    // Get History
    $historyStmt = $conn->prepare("
        SELECT r.*, res.resourceName, sa.areaName
        FROM tblreservation r
        LEFT JOIN tblresource res ON r.resourceID = res.resourceID
        LEFT JOIN tblstudyarea sa ON res.areaID = sa.areaID
        WHERE r.userID = ? AND (r.status_type != 'Pending' AND r.status_type != 'Active')
        ORDER BY r.startTime DESC
        LIMIT ? OFFSET ?
    ");
    $historyStmt->bind_param("sii", $userID, $limit, $offset);
    $historyStmt->execute();
    $historyResult = $historyStmt->get_result();
    
    $history = [];
    while ($row = $historyResult->fetch_assoc()) { $history[] = $row; }

    echo json_encode([
        'success' => true,
        'isBlocked' => $isBlocked,
        'blockedUntil' => $blockedDate,
        'activeReservation' => $activeRes,
        'history' => $history,
        'totalPages' => $totalPages,
        'currentPage' => $page
    ]);

} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>