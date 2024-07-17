<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Obtém o ID do usuário da sessão
$user_id = $_SESSION["id"];

// Obtém os dados do usuário
$sql = "SELECT email, withdrawal_balance FROM users WHERE id = ?";
if ($stmt = $conn->prepare($sql)) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();
    $stmt->close();
} else {
    die("Erro na preparação da consulta: " . $conn->error);
}

// Verifica se o email FaucetPay está salvo
if (empty($user['email'])) {
    echo "Please configure your FaucetPay email in the Account section.";
    exit;
}

// Função para realizar o saque
function process_withdrawal($conn, $user_id, $balance_usdt, $email) {
    // Converte o saldo de USDT para um número inteiro
    $usdt_amount = intval($balance_usdt * 100000000); // 1 USDT = 100000000 unidades

    // Configurações da API da FaucetPay
    $api_key = "b3f41415e5ea78749813ffedd3e89a9e351184ec1c904d189fcfe45d90482307";
    $to = $email;
    $currency = "usdt";
    $amount = $usdt_amount;

    // Envia o pagamento para a FaucetPay usando a API
    $api_url = "https://faucetpay.io/api/v1/send";
    $data = [
        'api_key' => $api_key,
        'to' => $to,
        'amount' => $amount,
        'currency' => $currency
    ];
    $options = [
        'http' => [
            'header' => "Content-type: application/x-www-form-urlencoded\r\n",
            'method' => 'POST',
            'content' => http_build_query($data)
        ]
    ];
    $context = stream_context_create($options);
    $response = file_get_contents($api_url, false, $context);
    $response_data = json_decode($response, true);

    if ($response_data['status'] == 200) {
        // Sucesso no pagamento, subtrai o valor do saldo do usuário
        $new_balance = $balance_usdt - ($amount / 100000000);
        $sql = "UPDATE users SET withdrawal_balance = ? WHERE id = ?";
        if ($stmt = $conn->prepare($sql)) {
            $stmt->bind_param("di", $new_balance, $user_id);
            $stmt->execute();
            $stmt->close();
        } else {
            die("Erro na preparação da consulta de atualização: " . $conn->error);
        }

        return "Payment successful! Your new balance is: " . number_format($new_balance, 8);
    } else {
        return "Payment failed: " . $response_data['message'];
    }
}

$message = '';
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $message = process_withdrawal($conn, $user_id, $user['withdrawal_balance'], $user['email']);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Withdrawal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="navbar.js"></script>
    <link rel="stylesheet" href="navbar.css">
    <?php include 'navbar.php'; ?>
    <link rel="stylesheet" href="css/withdrawal.css">
</head>
<body>
    <div class="container">
        <h2>Withdrawal</h2>
        <p>Current Balance: <?php echo number_format($user['withdrawal_balance'], 8); ?> USDT</p>
        <form method="post" action="withdrawal.php">
            <button type="submit">Withdraw</button>
        </form>
        <?php if (!empty($message)): ?>
            <p class="message"><?php echo $message; ?></p>
        <?php endif; ?>
    </div>
</body>
</html>