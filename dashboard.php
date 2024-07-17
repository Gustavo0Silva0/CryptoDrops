<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado, se não, redireciona para a página de login
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Recupera os dados do usuário da sessão
$user_id = $_SESSION["id"];

// Recupera informações do usuário do banco de dados
$sql = "SELECT username, deposit_balance, withdrawal_balance FROM users WHERE id = ?";
if ($stmt = $conn->prepare($sql)) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $stmt->bind_result($username, $deposit_balance, $withdrawal_balance);
    $stmt->fetch();
    $stmt->close();
}

// Recupera informações das miners do usuário
$miners = [];
$total_mining_power = 0;
$total_daily_reward = 0;
$sql = "SELECT sm.miner_name, sm.mining_power, sm.daily_reward 
        FROM user_miners um 
        JOIN shop_miners sm ON um.miner_id = sm.id 
        WHERE um.user_id = ?";
if ($stmt = $conn->prepare($sql)) {
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
        $miners[] = $row;
        $total_mining_power += $row['mining_power'];
        $total_daily_reward += $row['daily_reward'];
    }
    $stmt->close();
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="css/dashboard.css">
    <link rel="stylesheet" href="navbar.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="navbar.js"></script>
</head>
<body>
    
    <?php include 'navbar.php'; ?>
    
    <br>
    <br>
    <br>
    
    <div class="balance">
        <p>Deposit Balance: <?php echo htmlspecialchars($deposit_balance); ?></p>
        <p>Withdrawal Balance: <?php echo htmlspecialchars($withdrawal_balance); ?></p>
    </div>
    <div class="mining-section">
        <h2>Miner</h2>
        <div class="miner-info">
            <img src="mining.gif" alt="Miner">
            <div>
                <p>Mining Power: <?php echo htmlspecialchars($total_mining_power); ?> GH/s</p>
                <p>Daily Reward: <?php echo htmlspecialchars($total_daily_reward); ?> USD</p>
                <p>Active Miners: <?php echo htmlspecialchars(count($miners)); ?></p>
            </div>
        </div>
        <a href="shopminer.php"><button>Buy Miners</button></a>
    </div>
    <div class="carousel">
        <h2>My Miners</h2>
        <div class="miner-carousel">
            <?php foreach ($miners as $miner): ?>
                <div class="miner-item">
                    <p>Miner Name: <?php echo htmlspecialchars($miner['miner_name']); ?></p>
                    <p>Mining Power: <?php echo htmlspecialchars($miner['mining_power']); ?> GH/s</p>
                    <p>Daily Reward: <?php echo htmlspecialchars($miner['daily_reward']); ?> USD</p>
                </div>
            <?php endforeach; ?>
        </div>
    </div>
    <script>
        $(document).ready(function(){
            $('.miner-carousel').slick({
                infinite: true,
                slidesToShow: 3,
                slidesToScroll: 1
            });
        });
    </script>
</body>
</html>