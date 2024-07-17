<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Jogos</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            max-width: 600px;
            width: 90%;
        }

        h1 {
            margin-bottom: 20px;
            font-size: 24px;
        }

        .game-list {
            list-style: none;
            padding: 0;
        }

        .game-list li {
            margin-bottom: 15px;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Jogos Disponíveis</h1>
        <ul class="game-list">
            <li>
                <strong>Jogo da Memória</strong> - Power: 10 GHS
                <br>
                <button onclick="location.href='memory_game.php'">Jogar</button>
            </li>
            <li>
                <strong>Jogo do Quiz</strong> - Power: 15 GHS
                <br>
                <button onclick="location.href='quiz_game.php'">Jogar</button>
            </li>
            <li>
                <strong>Jogo da Aventura</strong> - Power: 20 GHS
                <br>
                <button onclick="location.href='adventure_game.php'">Jogar</button>
            </li>
        </ul>
    </div>
</body>
</html>