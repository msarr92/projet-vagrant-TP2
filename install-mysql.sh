#!/bin/bash

echo "================================================"
echo "  Installation MySQL Server sur srv-db"
echo "================================================"

# Mise à jour du système
echo "[1/5] Mise à jour du système..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Installation de MySQL Server
echo "[2/5] Installation de MySQL Server..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# Démarrage et activation de MySQL
echo "[3/5] Démarrage de MySQL..."
sudo systemctl start mysql
sudo systemctl enable mysql

# Configuration pour accepter les connexions externes
echo "[4/5] Configuration de MySQL pour les connexions externes..."
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Redémarrage de MySQL
sudo systemctl restart mysql

# Création de la base de données et de l'utilisateur
echo "[5/5] Création de la base de données et de l'utilisateur..."

sudo mysql <<EOF
-- Création de la base de données
CREATE DATABASE IF NOT EXISTS appdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur
CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'AppPass123!';

-- Attribution des privilèges
GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%';
FLUSH PRIVILEGES;

-- Utilisation de la base
USE appdb;

-- Création de la table users
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    fullname VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_username (username)
) ENGINE=InnoDB;

-- Insertion de données de test
INSERT INTO users (username, email, fullname) VALUES 
    ('admin', 'admin@example.com', 'Administrateur'),
    ('john_doe', 'john@example.com', 'John Doe'),
    ('jane_smith', 'jane@example.com', 'Jane Smith')
ON DUPLICATE KEY UPDATE username=username;

EOF

echo ""
echo "================================================"
echo "  Installation MySQL terminée avec succès!"
echo "================================================"
echo ""
echo "Informations de connexion MySQL:"
echo "  • Host      : 192.168.56.11"
echo "  • Port      : 3306"
echo "  • Database  : appdb"
echo "  • User      : appuser"
echo "  • Password  : AppPass123!"
echo ""
echo "Commandes utiles:"
echo "  sudo systemctl status mysql"
echo "  sudo mysql"
echo "  mysql -u appuser -p'AppPass123!' -h 192.168.56.11 appdb"
echo ""
echo "================================================"