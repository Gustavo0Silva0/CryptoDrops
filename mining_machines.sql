CREATE TABLE mining_machines (
    machine_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    power_gps DECIMAL(10, 2) NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    PRIMARY KEY (machine_id)
);