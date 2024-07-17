<?php
session_start();
include 'db_config.php';

$email_username = $password = "";
$email_username_err = $password_err = $login_err = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validar email ou nome de usuário
    if (empty(trim($_POST["email_username"]))) {
        $email_username_err = "Please enter an email or username.";
    } else {
        $email_username = htmlspecialchars(trim($_POST["email_username"])); 
    }
    
    // Validar senha
    if (empty(trim($_POST["password"]))) {
        $password_err = "Please enter your password.";
    } else {
        $password = htmlspecialchars(trim($_POST["password"]));
    }
    
    // Validar credenciais
    if (empty($email_username_err) && empty($password_err)) {
        $sql = "SELECT id, username, email, password FROM users WHERE username = ? OR email = ?";
        
        if ($stmt = $conn->prepare($sql)) {
            $param_email_username = $email_username;
            $stmt->bind_param("ss", $param_email_username, $param_email_username);

            if ($stmt->execute()) {
                $stmt->store_result();
                
                if ($stmt->num_rows == 1) {
                    $stmt->bind_result($id, $username, $email, $hashed_password);
                    if ($stmt->fetch()) {
                        if (password_verify($password, $hashed_password)) {
                            $_SESSION["loggedin"] = true;
                            $_SESSION["id"] = $id;
                            $_SESSION["username"] = $username;
                            
                            setcookie("loggedin", true, time() + (86400), "/"); // 86400 segundos = 24 horas
                            setcookie("id", $id, time() + (86400), "/");
                            setcookie("username", $username, time() + (86400), "/");

                            header("location: dashboard.php");
                            exit;
                        } else {
                            $login_err = "Invalid username or password.";
                        }
                    }
                } else {
                    $login_err = "Invalid username or password.";
                }
            } else {
                echo "Something went wrong. Please try again.";
            }

            $stmt->close();
        }
    }

    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="wrapper">
        <h2>Login</h2>
        <p>Please fill in your credentials to login.</p>
        <?php 
        if (!empty($login_err)) {
            echo '<div class="alert alert-danger">' . htmlspecialchars($login_err) . '</div>';
        }        
        ?>
        <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="post">
            <div class="form-group <?php echo (!empty($email_username_err)) ? 'has-error' : ''; ?>">
                <label>Email or Username</label>
                <input type="text" name="email_username" value="<?php echo htmlspecialchars($email_username); ?>">
                <span class="help-block"><?php echo htmlspecialchars($email_username_err); ?></span>
            </div>    
            <div class="form-group <?php echo (!empty($password_err)) ? 'has-error' : ''; ?>">
                <label>Password</label>
                <input type="password" name="password">
                <span class="help-block"><?php echo htmlspecialchars($password_err); ?></span>
            </div>
            <div class="form-group">
                <input type="submit" class="btn" value="Login">
            </div>
            <p>Don't have an account? <a href="register.php">Register now</a>.</p>
        </form>
    </div>    
</body>
</html>