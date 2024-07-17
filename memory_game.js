const cardValues = ['A', 'A', 'B', 'B', 'C', 'C', 'D', 'D', 'E', 'E', 'F', 'F', 'G', 'G', 'H', 'H'];
let cardElements = [];
let firstCard, secondCard;
let lockBoard = false;
let matchedCards = 0;
let timerInterval;
let timeRemaining = 60;

const gameBoard = document.getElementById('game-board');
const restartButton = document.getElementById('restart');
const timerDisplay = document.getElementById('timer');
const messageDisplay = document.getElementById('message');
const rewardButton = document.getElementById('reward');

function shuffle(array) {
    for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
}

function createCard(value) {
    const card = document.createElement('div');
    card.classList.add('card');
    card.dataset.value = value;
    card.addEventListener('click', flipCard);
    gameBoard.appendChild(card);
    return card;
}

function flipCard() {
    if (lockBoard || this === firstCard) return;

    this.classList.add('flipped');
    this.textContent = this.dataset.value;

    if (!firstCard) {
        firstCard = this;
    } else {
        secondCard = this;
        lockBoard = true;
        checkForMatch();
    }
}

function checkForMatch() {
    if (firstCard.dataset.value === secondCard.dataset.value) {
        matchedCards += 2;
        resetBoard();
        if (matchedCards === cardValues.length) {
            clearInterval(timerInterval);
            messageDisplay.textContent = 'Você venceu!';
            rewardButton.style.display = 'block'; // Torna o botão visível
            restartButton.style.display = 'none'; // Esconde o botão reiniciar
        }
    } else {
        setTimeout(() => {
            firstCard.classList.remove('flipped');
            secondCard.classList.remove('flipped');
            firstCard.textContent = '';
            secondCard.textContent = '';
            resetBoard();
        }, 1000);
    }
}

function resetBoard() {
    [firstCard, secondCard] = [null, null];
    lockBoard = false;
}

function startGame() {
    gameBoard.innerHTML = '';
    matchedCards = 0;
    timeRemaining = 60;
    timerDisplay.textContent = timeRemaining;
    messageDisplay.textContent = '';
    rewardButton.style.display = 'none'; // Esconde o botão ao reiniciar
    restartButton.style.display = 'inline-block'; // Mostra o botão reiniciar

    clearInterval(timerInterval);
    timerInterval = setInterval(updateTimer, 1000);

    shuffle(cardValues).forEach(value => {
        cardElements.push(createCard(value));
    });
}

function updateTimer() {
    timeRemaining--;
    timerDisplay.textContent = timeRemaining;

    if (timeRemaining <= 0) {
        clearInterval(timerInterval);
        messageDisplay.textContent = 'Tempo esgotado! Você perdeu!';
        startGame();
    }
}

// Função para enviar recompensa ao servidor
rewardButton.addEventListener('click', () => {
    fetch('memory_game.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({ reward: true })
    })
    .then(response => response.text())
    .then(data => {
        messageDisplay.textContent = data;
        rewardButton.style.display = 'none'; // Esconde o botão após a recompensa ser recebida
    });
});

restartButton.addEventListener('click', startGame);

startGame();