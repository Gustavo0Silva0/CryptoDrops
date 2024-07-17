<?php
session_start();
include 'db_config.php';

// Verifica se o usuário está logado
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Obtém o ID do usuário
$user_id = $_SESSION["id"];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shortlink</title>
    <link rel="stylesheet" href="css/short1.css">
</head>
<body>
    <div class="container">
        <h1 class="short-name">Nome do Shortlink</h1>
        <div class="ads-container">
            <script async src="https://ss.mrmnd.com/native.js"></script>
            <div data-mndazid="52e05d34-a77c-4c7b-b797-ff0914e2445a"></div>
        </div>
        <p>Por favor, clique no anúncio e espere 15 segundos.</p>
        <div class="countdown" id="countdown"></div>
        <form id="shortlink-form" action="short_verify.php" method="POST" style="display:none;">
            <input type="hidden" name="shortlink_id" value="<?php echo $_GET['shortlink_id']; ?>">
            <button type="submit" class="button" id="start-button">Começar</button>
        </form>
    </div>

    <script>
        var adClicked = false;

        document.querySelector('.ads-container').addEventListener('click', function() {
            if (!adClicked) {
                adClicked = true;
                startCountdown();
            }
        });

        function startCountdown() {
            var countdown = document.getElementById('countdown');
            var form = document.getElementById('shortlink-form');
            var timeLeft = 15;

            var timer = setInterval(function() {
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    countdown.innerHTML = "Você pode prosseguir.";
                    form.style.display = 'block';
                } else {
                    countdown.innerHTML = "Aguarde " + timeLeft + " segundos.";
                }
                timeLeft -= 1;
            }, 1000);
        }
    </script>
</body>
</html>