#!/bin/bash

echo "================================================"
echo "  Installation JDK 8, 11, 17 et Tomcat 9"
echo "================================================"

# Mise à jour du système
echo "[1/7] Mise à jour du système..."
sudo apt-get update -y

# Installation de JDK 8, 11, 17
echo "[2/7] Installation de JDK 8, 11, 17..."
sudo apt-get install -y openjdk-8-jdk openjdk-11-jdk openjdk-17-jdk

# Vérification des installations JDK
echo ""
echo "Versions JDK installées:"
echo "------------------------"
/usr/lib/jvm/java-8-openjdk-amd64/bin/java -version 2>&1 | head -1
/usr/lib/jvm/java-11-openjdk-amd64/bin/java -version 2>&1 | head -1
/usr/lib/jvm/java-17-openjdk-amd64/bin/java -version 2>&1 | head -1
echo ""

# Configuration de JDK 11 par défaut
echo "[3/7] Configuration de JDK 11 par défaut..."
sudo update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

# Installation des outils nécessaires
echo "[4/7] Installation des outils (wget, netcat)..."
sudo apt-get install -y wget netcat mysql-client

# Création de l'utilisateur tomcat
echo "[5/7] Création de l'utilisateur tomcat..."
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat

# Installation de Tomcat 9
echo "[6/7] Téléchargement et installation de Tomcat 9..."
TOMCAT_VERSION="9.0.95"
cd /tmp
wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Extraction
sudo tar xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /opt/tomcat --strip-components=1

# Téléchargement du connecteur MySQL JDBC
echo "Téléchargement du connecteur MySQL JDBC..."
cd /opt/tomcat/lib
sudo wget -q https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar

# Configuration des permissions
sudo chown -R tomcat:tomcat /opt/tomcat/
sudo chmod -R u+x /opt/tomcat/bin/

# Création du service systemd
echo "[7/7] Configuration du service Tomcat..."
sudo bash -c 'cat > /etc/systemd/system/tomcat.service << EOF
[Unit]
Description=Apache Tomcat 9 Web Application Server
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF'

# Configuration du Tomcat Manager
sudo bash -c 'cat > /opt/tomcat/conf/tomcat-users.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="admin-gui"/>
  <user username="admin" password="admin123" roles="manager-gui,manager-script,admin-gui"/>
</tomcat-users>
EOF'

sudo chown tomcat:tomcat /opt/tomcat/conf/tomcat-users.xml

# Démarrage de Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

# Attendre que Tomcat démarre
sleep 5

echo ""
echo "================================================"
echo "  Installation terminée avec succès!"
echo "================================================"
echo ""
echo "Versions installées:"
echo "  • JDK 8, 11, 17"
echo "  • Apache Tomcat ${TOMCAT_VERSION}"
echo "  • MySQL Connector JDBC 8.2.0"
echo ""
echo "Accès Tomcat:"
echo "  • URL: http://192.168.56.10:8081"
echo "  • URL: http://localhost:8081 (depuis l'hôte)"
echo ""
echo "Tomcat Manager:"
echo "  • Username: admin"
echo "  • Password: admin123"
echo ""
echo "Configuration MySQL:"
echo "  • Host: 192.168.56.11"
echo "  • Port: 3306"
echo "  • Database: appdb"
echo "  • User: appuser"
echo "  • Password: AppPass123!"
echo ""
echo "================================================"