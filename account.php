<?php
session_start();
include 'db_config.php'; // Certifique-se de que este é o caminho correto

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Recupera o ID do usuário da sessão
$user_id = $_SESSION['id'];

// Inicializa variáveis
$faucetpay_email = '';
$withdrawal_balance = 0.0;
$deposit_balance = 0.0;
$message = '';
$error = '';

// Recupera o email da FaucetPay e os saldos do usuário
$stmt = $conn->prepare("SELECT faucetpay_email, withdrawal_balance, deposit_balance FROM users WHERE id = ?");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$stmt->bind_result($faucetpay_email, $withdrawal_balance, $deposit_balance);
$stmt->fetch();
$stmt->close();

// Atualiza o email da FaucetPay
if (isset($_POST['update_email'])) {
    $faucetpay_email = filter_var($_POST['faucetpay_email'], FILTER_SANITIZE_EMAIL);
    if (filter_var($faucetpay_email, FILTER_VALIDATE_EMAIL)) {
        $stmt = $conn->prepare("UPDATE users SET faucetpay_email = ? WHERE id = ?");
        $stmt->bind_param("si", $faucetpay_email, $user_id);
        if ($stmt->execute()) {
            $message = "Email atualizado com sucesso.";
        } else {
            $error = "Falha ao atualizar o email.";
        }
        $stmt->close();
    } else {
        $error = "Email inválido.";
    }
}

// Troca o saldo de retirada para saldo de compra
if (isset($_POST['exchange_balance'])) {
    $amount = filter_var($_POST['amount'], FILTER_VALIDATE_FLOAT);
    if ($amount && $amount > 0 && $amount <= $withdrawal_balance) {
        $stmt = $conn->prepare("UPDATE users SET withdrawal_balance = withdrawal_balance - ?, deposit_balance = deposit_balance + ? WHERE id = ?");
        $stmt->bind_param("ddi", $amount, $amount, $user_id);
        if ($stmt->execute()) {
            $message = "Saldo trocado com sucesso.";
            $withdrawal_balance -= $amount;
            $deposit_balance += $amount;
        } else {
            $error = "Falha ao trocar saldo.";
        }
        $stmt->close();
    } else {
        $error = "Valor inválido para troca.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account</title>
    <link rel="stylesheet" href="account.css">
</head>
<body>
    <div class="container">
        <h1>Account</h1>
        <?php
        if (!empty($message)) {
            echo '<p class="message">' . htmlspecialchars($message) . '</p>';
        }
        if (!empty($error)) {
            echo '<p class="error">' . htmlspecialchars($error) . '</p>';
        }
        ?>
        <form method="post" action="account.php">
            <label for="faucetpay_email">FaucetPay Email:</label>
            <input type="email" id="faucetpay_email" name="faucetpay_email" value="<?php echo htmlspecialchars($faucetpay_email); ?>" required>
            <button type="submit" name="update_email">Update Email</button>
        </form>
        <form method="post" action="account.php">
            <label for="amount">Exchange Withdrawal Balance:</label>
            <input type="number" step="0.00000001" id="amount" name="amount" required>
            <p>Current Withdrawal Balance: <?php echo htmlspecialchars(number_format($withdrawal_balance, 8)); ?></p>
            <p>Current Deposit Balance: <?php echo htmlspecialchars(number_format($deposit_balance, 8)); ?></p>
            <button type="submit" name="exchange_balance">Exchange</button>
        </form>
    </div>
</body>
</html>