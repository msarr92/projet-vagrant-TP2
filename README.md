### CRÉATION DES MACHINES VIRTUELLES
Créer le Vagrantfile avec la commande:
    vagrant init 
(voir fichier Vagrantfile)
Démarrer les machines virtuelles avec la commande:
  vagrant up
### CONFIGURATION DE srv-db (BASE DE DONNÉES)
  Connexion à srv-db avec la commande: vagrant ssh srv-db
   Créer le script d'installation MySQL avec la commande: nano install-mysql.sh (voir le fichier install-mysql.sh) 
   Exécuter le script d'installation avec ces commande: chmod +x install-mysql.sh 
                                                        ./install-mysql.sh
  Apres installation verifier le status de mysql: sudo systemctl status mysql
  Sortir de srv-db
### CONFIGURATION DE srv-app (SERVEUR APPLICATION)
Connexion à srv-app avec la commande: vagrant ssh srv-app
    Créer le script d'installation: nano install-jdk-tomcat.sh
    Exécuter le script d'installation : chmod +x install-jdk-tomcat.sh
                                        ./install-jdk-tomcat.sh

<img width="919" height="654" alt="Capture d&#39;écran 2026-01-22 132512" src="https://github.com/user-attachments/assets/f0003233-081e-410a-8d3c-4b7622f2bc86" />

    
<img width="668" height="828" alt="Capture d&#39;écran 2026-01-22 132611" src="https://github.com/user-attachments/assets/c09b22a8-e21d-4002-8282-c8b8af2547da" />


Vérifier le statut de Tomcat: sudo systemctl status tomcat
    Tester l'accès à Tomcat Depuis votre navigateur sur la machine hôte, accédez à: http://localhost:8081
    
<img width="1919" height="1028" alt="Capture d&#39;écran 2026-01-22 131730" src="https://github.com/user-attachments/assets/907af119-6c75-4958-8bc0-57c73b79a966" />

### TESTS DE CONNECTIVITÉ
Tester la connexion entre srv-app et srv-db 
    Créer le script de test dans srv-app avec la commande nano test-mysql-connection.sh (voir fichier test-mysql-connection.sh)
     Exécuter le script de test: chmod +x test-mysql-connection.sh
                                 ./test-mysql-connection.sh

      
<img width="891" height="863" alt="Capture d&#39;écran 2026-01-22 132759" src="https://github.com/user-attachments/assets/51f5cfd8-2190-4da6-ab25-c5378652632f" />

Maintenant il faut creer un projet. Apres creation on du projet Java on execute la commande: mvn clean package
    Copier le WAR dans le dossier Vagrant. Depuis le dossier projet Uploader vers srv-app avec la commande:
      vagrant upload usermanagement.war /home/vagrant/usermanagement.war srv-app 
    Se connecter à srv-app: vagrant ssh srv-app
    Déployer :
        sudo cp /home/vagrant/usermanagement.war /opt/tomcat/webapps/
        sudo chown tomcat:tomcat /opt/tomcat/webapps/usermanagement.war
        sudo systemctl restart tomcat

Ouvrez votre navigateur : http://localhost:8081/usermanagement

<img width="1913" height="1030" alt="Capture d&#39;écran 2026-01-22 141120" src="https://github.com/user-attachments/assets/a4ba2056-46a5-4935-a1eb-e0488ede13a1" />
