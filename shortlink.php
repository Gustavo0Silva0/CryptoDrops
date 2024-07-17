<?php
session_start();
include 'db_config.php';

// Check if the user is logged in
if (!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true) {
    header("location: login.php");
    exit;
}

// Get the user data
$user_id = $_SESSION["id"];

// Select all available shortlinks
$sql = "SELECT id, name, reward, daily_limit FROM shortlinks";
$result = $conn->query($sql);

// Check if the query was successful
if (!$result) {
    die("Error fetching shortlinks: " . $conn->error);
}

// Check how many times the user has completed each shortlink today
$sql_user_shortlinks = "SELECT shortlink_id, COUNT(*) as count FROM user_shortlinks WHERE user_id = ? AND DATE(timestamp) = CURDATE() GROUP BY shortlink_id";
$stmt_user_shortlinks = $conn->prepare($sql_user_shortlinks);

// Check if the query preparation was successful
if (!$stmt_user_shortlinks) {
    die("Error preparing query: " . $conn->error);
}

$stmt_user_shortlinks->bind_param("i", $user_id);
$stmt_user_shortlinks->execute();
$result_user_shortlinks = $stmt_user_shortlinks->get_result();

$user_shortlink_counts = [];
while ($row_user_shortlinks = $result_user_shortlinks->fetch_assoc()) {
    $user_shortlink_counts[$row_user_shortlinks['shortlink_id']] = $row_user_shortlinks['count'];
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shortlinks</title>
    <link rel="stylesheet" href="css/shortlink.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="navbar.js"></script>
    <link rel="stylesheet" href="navbar.css">
</head>
<body>
        <?php include 'navbar.php'; ?>
        <br>
        <br>
        <br>
    <div class="container">
        <h1>Available Shortlinks</h1>
        <?php
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $shortlink_id = $row['id'];
                $name = htmlspecialchars($row['name']);
                $reward = number_format($row['reward'], 8);
                $daily_limit = $row['daily_limit'];
                $user_shortlink_count = isset($user_shortlink_counts[$shortlink_id]) ? $user_shortlink_counts[$shortlink_id] : 0;
                $remaining_visits = $daily_limit - $user_shortlink_count;
                ?>
                <div class="shortlink-container">
                    <h2><?php echo $name; ?></h2>
                    <p>Reward: <?php echo $reward; ?> USD</p>
                    <p>Visits available today: <?php echo $remaining_visits; ?></p>
                    <?php if ($remaining_visits > 0): ?>
                        <a href="short1.php?shortlink_id=<?php echo htmlspecialchars($shortlink_id); ?>" class="button">Start</a>
                    <?php else: ?>
                        <button class="button disabled" disabled>No more visits today</button>
                    <?php endif; ?>
                </div>
                <?php
            }
        } else {
            echo "<p>No shortlinks available.</p>";
        }
        ?>
    </div>
</body>
</html>