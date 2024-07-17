<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Recuperar o nome de usuário da sessão
$username = $_SESSION['username'];

// Recuperar o user_id diretamente do banco de dados
$sql = "SELECT id FROM users WHERE username = ?";
$stmt = $conn->prepare($sql);
if ($stmt) {
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->bind_result($user_id);
    if (!$stmt->fetch()) {
        echo "Erro: usuário não encontrado.";
        $stmt->close();
        $conn->close();
        exit();
    }
    $stmt->close();
} else {
    echo "Erro na preparação da consulta: " . $conn->error;
    exit();
}

$shortlink_id = $_POST['shortlink_id'];

// Registrar que o usuário completou o shortlink
$sql = "INSERT INTO user_shortlinks (user_id, shortlink_id, timestamp) VALUES (?, ?, NOW())";
$stmt = $conn->prepare($sql);
if ($stmt) {
    $stmt->bind_param("ii", $user_id, $shortlink_id);
    if ($stmt->execute()) {
        // Atualizar o saldo do usuário
        $reward = 0.0001; // Substitua este valor pelo valor da recompensa real
        $sql = "UPDATE users SET deposit_balance = deposit_balance + ? WHERE id = ?";
        $stmt = $conn->prepare($sql);
        if ($stmt) {
            $stmt->bind_param("di", $reward, $user_id);
            if ($stmt->execute()) {
                // Redirecionar após sucesso
                header("Location: shortlink.php");
                exit();
            } else {
                echo "Erro ao atualizar o saldo: " . $stmt->error;
            }
            $stmt->close();
        } else {
            echo "Erro na preparação da consulta: " . $conn->error;
        }
    } else {
        echo "Erro ao registrar o shortlink: " . $stmt->error;
    }
    $stmt->close();
} else {
    echo "Erro na preparação da consulta: " . $conn->error;
}

$conn->close();
?>