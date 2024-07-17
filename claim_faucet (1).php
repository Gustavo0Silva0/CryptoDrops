<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

$user_id = $_SESSION['user_id'];
$reward = 0.0001; // Substitua pelo valor da recompensa real

// Atualiza o saldo do usuário
$sql = "UPDATE users SET deposit_balance = deposit_balance + ? WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("di", $reward, $user_id);
if ($stmt->execute()) {
    // Registra o claim na tabela de claims
    $sql = "INSERT INTO user_faucet_claims (user_id) VALUES (?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $user_id);
    if ($stmt->execute()) {
        $_SESSION['message'] = "Faucet claimada com sucesso!";
    } else {
        $_SESSION['message'] = "Erro ao registrar o claim: " . $stmt->error;
    }
    $stmt->close();
} else {
    $_SESSION['message'] = "Erro ao atualizar o saldo: " . $stmt->error;
}
$stmt->close();
$conn->close();

header("location: faucet.php");
exit;
?>