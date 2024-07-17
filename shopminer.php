<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado, se não, redireciona para a página de login
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Função para processar a compra da miner
function processPurchase($conn, $miner_id, $user_id) {
    // Busca as informações da miner no banco de dados
    $sql = "SELECT * FROM shop_miners WHERE id = ?";
    if ($stmt = $conn->prepare($sql)) {
        $stmt->bind_param("i", $miner_id);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            $miner = $result->fetch_assoc();
            $miner_cost = $miner['cost'];
            $daily_reward = $miner['daily_reward'];

            // Busca o saldo de depósito do usuário
            $sql = "SELECT deposit_balance FROM users WHERE id = ?";
            if ($stmt = $conn->prepare($sql)) {
                $stmt->bind_param("i", $user_id);
                $stmt->execute();
                $result = $stmt->get_result();
                $user = $result->fetch_assoc();
                $deposit_balance = $user['deposit_balance'];

                // Verifica se o usuário tem saldo suficiente
                if ($deposit_balance >= $miner_cost) {
                    // Desconta o custo da miner do saldo de depósito
                    $new_deposit_balance = $deposit_balance - $miner_cost;
                    $update_sql = "UPDATE users SET deposit_balance = ? WHERE id = ?";
                    if ($stmt = $conn->prepare($update_sql)) {
                        $stmt->bind_param("di", $new_deposit_balance, $user_id);
                        $stmt->execute();

                        // Adiciona a miner para o usuário
                        $start_date = date('Y-m-d');
                        $insert_sql = "INSERT INTO user_miners (user_id, miner_id, start_date, active) VALUES (?, ?, ?, 1)";
                        if ($stmt = $conn->prepare($insert_sql)) {
                            $stmt->bind_param("iis", $user_id, $miner_id, $start_date);
                            $stmt->execute();

                            // Atualiza o número de miners ativos do usuário
                            $update_sql = "UPDATE users SET active_miners_count = active_miners_count + 1 WHERE id = ?";
                            if ($stmt = $conn->prepare($update_sql)) {
                                $stmt->bind_param("i", $user_id);
                                $stmt->execute();

                                // Redireciona o usuário para a página de confirmação ou dashboard
                                header("Location: dashboard.php");
                                exit();
                            } else {
                                echo "Erro ao preparar a atualização dos miners ativos: " . htmlspecialchars($conn->error);
                            }
                        } else {
                            echo "Erro ao preparar a inserção da miner: " . htmlspecialchars($conn->error);
                        }
                    } else {
                        echo "Erro ao preparar a atualização do saldo de depósito: " . htmlspecialchars($conn->error);
                    }
                } else {
                    echo "Saldo insuficiente para comprar esta miner.";
                }
            } else {
                echo "Erro ao preparar a consulta do saldo de depósito: " . htmlspecialchars($conn->error);
            }
        } else {
            echo "Miner não encontrada.";
        }
    } else {
        echo "Erro ao preparar a consulta da miner: " . htmlspecialchars($conn->error);
    }
}

// Verifica se o formulário de compra foi enviado
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['miner_id'])) {
    $miner_id = intval($_POST['miner_id']);
    $user_id = $_SESSION["id"];
    processPurchase($conn, $miner_id, $user_id);
} else {
    // Exibe a interface da loja de miners se o formulário não foi enviado
    $sql = "SELECT * FROM shop_miners";
    $result = $conn->query($sql);
    
    echo '<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Shop Miners</title>
        <link rel="stylesheet" href="css/shopminer.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="navbar.css">
        <script src="navbar.js"></script>
    </head>
    <body>
        <br><br><br>
        <div class="shop-container">';
        
    while ($miner = $result->fetch_assoc()) {
        $image_path = 'miner' . htmlspecialchars($miner['id']) . '.png';  // Assumindo que as imagens estão no mesmo diretório e seguem o padrão miner1.png, miner2.png, etc.
        echo '<div class="miner-card">
                <img src="' . htmlspecialchars($image_path) . '" alt="' . htmlspecialchars($miner['miner_name']) . '">
                <h3>' . htmlspecialchars($miner['mining_power']) . ' GH/s</h3>
                <p>Daily Reward: ' . htmlspecialchars($miner['daily_reward']) . ' USD</p>
                <p>Price: ' . htmlspecialchars($miner['cost']) . ' USD</p>
                <form method="post" action="shopminer.php">
                    <button type="submit" name="miner_id" value="' . htmlspecialchars($miner['id']) . '">Buy Miner</button>
                </form>
              </div>';
    }

    echo '</div>
    </body>
    </html>';
}

$conn->close();
?>
<?php include 'navbar.php'; ?>