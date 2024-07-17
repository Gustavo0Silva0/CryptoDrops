CREATE TABLE user_machines (
    id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    machine_id INT NOT NULL,
    purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (machine_id) REFERENCES mining_machines(machine_id)
);