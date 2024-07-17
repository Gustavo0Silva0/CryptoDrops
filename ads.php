<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Redirecionamento</title>
    <link rel="stylesheet" href="styleads.css">
    <script>
        function startTimer() {
            var timer = 10;
            var interval = setInterval(function() {
                document.getElementById('timer').innerHTML = timer;
                timer--;
                if (timer < 0) {
                    clearInterval(interval);
                    window.location.href = "dashboard.php";
                }
            }, 1000);
        }
    </script>
</head>
<body onload="startTimer()">
    <div class="navbar">
        <span>Redirecionamento em <span id="timer">10</span> segundos</span>
    </div>
    <iframe src="https://www.rotate4all.com/ptp/promote-269118" frameborder="0" style="width:100%; height:90vh;"></iframe>
</body>
</html>