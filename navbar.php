<!-- Navbar fixa no topo -->
<nav class="navbar">
  <div class="nav-content">
    <div class="btn-expandir">
      <i class="bi bi-list" id="btn-exp"></i>
    </div>
  </div>
</nav>

<!-- Barra lateral -->
<nav class="menu-lateral">
  <ul>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/dashboard.php') ? 'ativo' : ''; ?>">
      <a href="dashboard.php">
        <span class="icon"><i class="bi bi-house-door"></i></span>
        <span class="txt-link">Dashboard</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/coming_soon.php') ? 'ativo' : ''; ?>">
      <a href="reward.php">
        <span class="icon"><i class="bi bi-gift"></i></span>
        <span class="txt-link">COMING SOON</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/shopminer.php') ? 'ativo' : ''; ?>">
      <a href="shopminer.php">
        <span class="icon"><i class="bi bi-shop"></i></span>
        <span class="txt-link">ShopMiner</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/faucet.php') ? 'ativo' : ''; ?>">
      <a href="faucet.php">
        <span class="icon"><i class="bi bi-coin"></i></span>
        <span class="txt-link">Faucet</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/shortlink.php') ? 'ativo' : ''; ?>">
      <a href="shortlink.php">
        <span class="icon"><i class="bi bi-link-45deg"></i></span>
        <span class="txt-link">Shortlink</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/coming_soon_2.php') ? 'ativo' : ''; ?>">
      <a href="reward.php">
        <span class="icon"><i class="bi bi-controller"></i></span>
        <span class="txt-link">COMING SOON</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/withdrawal.php') ? 'ativo' : ''; ?>">
      <a href="withdrawal.php">
        <span class="icon"><i class="bi bi-wallet2"></i></span>
        <span class="txt-link">Withdrawal</span>
      </a>
    </li>
    <li class="item-menu <?php echo ($_SERVER['PHP_SELF'] == '/account.php') ? 'ativo' : ''; ?>">
      <a href="account.php">
        <span class="icon"><i class="bi bi-person-fill-gear"></i></span>
        <span class="txt-link">Account</span>
      </a>
    </li>
  </ul>
</nav>

<!-- Importar CSS -->
<link rel="stylesheet" href="styles.css">