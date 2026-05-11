<?php
$host     = 'localhost';
$db_name  = 'dbwildstar';  // replace with your actual DB name
$username = 'root';                 // replace with your DB user
$password = '';                     // replace with your DB password

$conn = new mysqli($host, $username, $password, $db_name);

if ($conn->connect_error) {
    http_response_code(500);
    die(json_encode(['error' => 'Connection failed: ' . $conn->connect_error]));
}
?>