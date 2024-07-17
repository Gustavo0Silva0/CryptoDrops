<?php
$servername = "localhost"; // Endereço do servidor de banco de dados
$username = "barrycoin"; // Nome de usuário do banco de dados
$password = "@Contaapp.2021"; // Senha do banco de dados
$dbname = "barrycoin"; // Nome do banco de dados

// Cria a conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Verifica a conexão
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>