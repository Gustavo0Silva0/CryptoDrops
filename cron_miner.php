<?php
include 'db_config.php';

// Função para processar recompensas das miners
function processMinerRewards($conn) {
    // Seleciona todas as miners ativas
    $sql = "SELECT um.id AS user_miner_id, um.user_id, um.miner_id, um.start_date
            FROM user_miners um
            WHERE um.active = 1";
    $result = $conn->query($sql);

    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $user_miner_id = $row['user_miner_id'];
            $user_id = $row['user_id'];
            $miner_id = $row['miner_id'];
            $start_date = $row['start_date'];

            // Definir a recompensa diária e duração com base no ID da miner
            $reward = 0.00000000;
            $duration_days = 0;
            if ($miner_id == 1) {
                $reward = 0.00002800; // Recompensa diária da Basic Miner
                $duration_days = 30; // Duração da Basic Miner
            } elseif ($miner_id == 2) {
                $reward = 0.00005600; // Recompensa diária da Advanced Miner
                $duration_days = 30; // Duração da Advanced Miner
            }

            $start_datetime = new DateTime($start_date);
            $current_datetime = new DateTime();
            $interval = $start_datetime->diff($current_datetime);
            $days_active = $interval->days;

            if ($days_active < $duration_days) {
                // Atualiza o saldo de retirada do usuário
                $update_sql = "UPDATE users SET withdrawal_balance = withdrawal_balance + ? WHERE id = ?";
                if ($stmt = $conn->prepare($update_sql)) {
                    $stmt->bind_param("di", $reward, $user_id);
                    $stmt->execute();
                    $stmt->close();
                }

                // Atualiza o total de ganhos das miners do usuário
                $update_sql = "UPDATE users SET total_miner_earnings = total_miner_earnings + ? WHERE id = ?";
                if ($stmt = $conn->prepare($update_sql)) {
                    $stmt->bind_param("di", $reward, $user_id);
                    $stmt->execute();
                    $stmt->close();
                }
            } else {
                // Desativa a miner se o período ativo exceder a duração da miner
                $update_sql = "UPDATE user_miners SET active = 0 WHERE id = ?";
                if ($stmt = $conn->prepare($update_sql)) {
                    $stmt->bind_param("i", $user_miner_id);
                    $stmt->execute();
                    $stmt->close();
                }

                // Atualiza o número de miners ativos do usuário
                $update_sql = "UPDATE users SET active_miners_count = active_miners_count - 1 WHERE id = ?";
                if ($stmt = $conn->prepare($update_sql)) {
                    $stmt->bind_param("i", $user_id);
                    $stmt->execute();
                    $stmt->close();
                }
            }
        }
    } else {
        echo "Erro ao selecionar miners ativas: " . $conn->error;
    }
}

processMinerRewards($conn);
$conn->close();
?>