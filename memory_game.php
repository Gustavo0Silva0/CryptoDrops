<?php
session_start();

// Conexão com o banco de dados
include 'db_config.php';

// Supondo que o user_id e power estejam armazenados na sessão após o login
$user_id = $_SESSION['user_id'] ?? null;
$power = $_SESSION['power'] ?? null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Registrar o jogo no banco de dados
    if (isset($_POST['reward'])) {
        if ($user_id) {
            try {
                $stmt = $pdo->prepare("INSERT INTO user_games (user_id, game_id, created_at) VALUES (?, ?, NOW())");
                $stmt->execute([$user_id, 1]); // 1 representa o ID do jogo da memória
                echo "Recompensa registrada!";
            } catch (PDOException $e) {
                echo "Erro ao registrar recompensa: " . $e->getMessage();
            }
        } else {
            echo "Usuário não autenticado.";
        }
        exit;
    }
}
?>


<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jogo da Memória</title>
    <link rel="stylesheet" href="css/games/memory_game.css"> <!-- Corrigido para styles.css -->
</head>
<body>
    <div class="container">
        <h1>Barry-Flip</h1>
        <div class="timer-container">
            <span id="timer">60</span> segundos restantes
        </div>
        <div id="message"></div>
        <div id="game-board"></div>
        <button id="restart">Reiniciar Jogo</button>
        <button id="reward" style="display: none;">Receber Recompensa</button>
    </div>
    <script src="js/games/memory_game.js"></script>
</body>
</html>