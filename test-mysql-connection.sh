#!/bin/bash

echo "================================================"
echo "  Test de connexion MySQL depuis srv-app"
echo "================================================"

DB_HOST="192.168.56.11"
DB_PORT="3306"
DB_NAME="appdb"
DB_USER="appuser"
DB_PASS="AppPass123!"

echo ""
echo "[Test 1/4] Test de connectivité réseau (ping)..."
if ping -c 3 $DB_HOST > /dev/null 2>&1; then
    echo "✓ Serveur $DB_HOST est accessible"
else
    echo "✗ Serveur $DB_HOST n'est pas accessible"
    exit 1
fi

echo ""
echo "[Test 2/4] Test du port MySQL ($DB_PORT)..."
if nc -zv $DB_HOST $DB_PORT 2>&1 | grep -q succeeded; then
    echo "✓ Port $DB_PORT est ouvert"
else
    echo "✗ Port $DB_PORT est fermé"
    exit 1
fi

echo ""
echo "[Test 3/4] Test de connexion MySQL..."
if mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✓ Connexion MySQL réussie"
else
    echo "✗ Connexion MySQL échouée"
    exit 1
fi

echo ""
echo "[Test 4/4] Récupération des données de test..."
echo ""
echo "Liste des bases de données:"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e "SHOW DATABASES;"

echo ""
echo "Tables dans la base '$DB_NAME':"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e "SHOW TABLES;"

echo ""
echo "Utilisateurs dans la table 'users':"
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM users;"

echo ""
echo "================================================"
echo "  ✓ Tous les tests sont passés avec succès!"
echo "================================================"
echo ""
echo "Informations de connexion:"
echo "  Host     : $DB_HOST"
echo "  Port     : $DB_PORT"
echo "  Database : $DB_NAME"
echo "  User     : $DB_USER"
echo "  Password : $DB_PASS"
echo ""