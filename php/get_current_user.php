<?php
session_start();
header('Content-Type: application/json');

echo json_encode([
    'userID'    => $_SESSION['userID']    ?? null,
    'user_type' => $_SESSION['user_type'] ?? null,
    'firstName' => $_SESSION['firstName'] ?? null
]);
?>