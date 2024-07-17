<?php
session_start();
include 'db_config.php';

// Check if the database connection was established successfully
if (!$conn) {
    die("Database connection failed: " . mysqli_connect_error());
}

// Check if the user is logged in
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

$user_id = $_SESSION["id"];
$current_time = new DateTime();
$current_date = $current_time->format('Y-m-d');

// Check if the user completed a shortlink today
$stmt = $conn->prepare("SELECT timestamp FROM user_shortlinks WHERE user_id = ? AND DATE(timestamp) = ?");
$stmt->bind_param("is", $user_id, $current_date);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows == 0) {
    $message = "You need to complete at least one shortlink today to use the faucet.";
    $stmt->close();
} else {
    $stmt->close();

    // Check if the user claimed the faucet in the last 10 minutes
    $stmt = $conn->prepare("SELECT claimed_at FROM user_faucet WHERE user_id = ? ORDER BY claimed_at DESC LIMIT 1");
    $stmt->bind_param("i", $user_id);
    $stmt->execute();
    $stmt->bind_result($claimed_at);
    $stmt->fetch();
    $stmt->close();

    if ($claimed_at) {
        $last_claim_time = new DateTime($claimed_at);
        $interval = $current_time->diff($last_claim_time);
        if ($interval->i < 10) {
            $remaining_time = 10 - $interval->i;
            $message = "You need to wait $remaining_time minutes to use the faucet again.";
        }
    }

    if ($_SERVER["REQUEST_METHOD"] == "POST" && !isset($message)) {
        // Credit the reward to the user
        $reward = 0.0001;
        $stmt = $conn->prepare("UPDATE users SET deposit_balance = deposit_balance + ? WHERE id = ?");
        $stmt->bind_param("di", $reward, $user_id);
        $stmt->execute();
        $stmt->close();

        // Log the claim in the user_faucet table
        $stmt = $conn->prepare("INSERT INTO user_faucet (user_id) VALUES (?)");
        $stmt->bind_param("i", $user_id);
        $stmt->execute();
        $stmt->close();

        $message = "Reward credited successfully!";
    }
}

// Check if the user can use the faucet
$can_claim = true;
$stmt = $conn->prepare("SELECT claimed_at FROM user_faucet WHERE user_id = ? ORDER BY claimed_at DESC LIMIT 1");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$stmt->bind_result($claimed_at);
$stmt->fetch();
$stmt->close();

if ($claimed_at) {
    $last_claim_time = new DateTime($claimed_at);
    $interval = $current_time->diff($last_claim_time);
    if ($interval->i < 10) {
        $can_claim = false;
        $remaining_time = 10 - $interval->i;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faucet</title>
    <link rel="stylesheet" href="css/faucet.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="navbar.js"></script>
    <link rel="stylesheet" href="navbar.css">
</head>
<body>
        <?php include 'navbar.php'; ?>
    <div class="container">
        <h1></h1>
        <div class="ads">
            <script async src="https://ss.mrmnd.com/native.js"></script>
            <div data-mndazid="52e05d34-a77c-4c7b-b797-ff0914e2445a"></div>
        </div>
        <?php if (isset($message)): ?>
            <div class="message">
                <p><?php echo htmlspecialchars($message); ?></p>
            </div>
        <?php elseif ($can_claim): ?>
            <form method="post">
                <button type="submit">Claim</button>
            </form>
        <?php else: ?>
            <div class="message">
                <p>You need to wait <?php echo htmlspecialchars($remaining_time); ?> minutes to use the faucet again.</p>
            </div>
        <?php endif; ?>
    </div>
</body>
</html>