<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$power_ghs = 0.0;

try {
    $sql = "SELECT power_ghs FROM network_power WHERE user_id = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $stmt->bind_result($power_ghs);
        $stmt->fetch();
        $stmt->close();
    }
} catch (Exception $e) {
    // Tratamento de erros
    error_log($e->getMessage());
    $power_ghs = 0.0;
}

// Proteção contra XSS
$power_ghs = htmlspecialchars($power_ghs, ENT_QUOTES, 'UTF-8');

$conn->close();
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Poder de Mineração</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Poder de Mineração</h1>
        <p>Seu poder de mineração atual é: <strong><?php echo $power_ghs; ?> GHS</strong></p>
    </div>
</body>
</html>