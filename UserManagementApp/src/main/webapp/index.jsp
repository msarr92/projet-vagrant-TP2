<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.usermanagementapp.util.DatabaseUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Management App</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }
        h1 { color: #667eea; text-align: center; margin-bottom: 30px; }
        .status {
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            text-align: center;
        }
        .status-ok { background: #d4edda; color: #155724; }
        .status-error { background: #f8d7da; color: #721c24; }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 30px 0;
        }
        .info-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #667eea;
        }
        .info-card h3 { color: #667eea; font-size: 14px; margin-bottom: 10px; }
        .info-card p { font-size: 16px; font-weight: bold; color: #333; }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s;
            margin: 10px;
        }
        .btn:hover { background: #764ba2; transform: translateY(-2px); }
        .footer {
            margin-top: 40px;
            text-align: center;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>🚀 User Management Application</h1>

    <% boolean dbConnected = DatabaseUtil.testConnection(); %>

    <div class="status <%= dbConnected ? "status-ok" : "status-error" %>">
        <%= dbConnected ? "✓ Connexion MySQL active" : "✗ Connexion MySQL échouée" %>
    </div>

    <div class="info-grid">
        <div class="info-card">
            <h3>SERVEUR APP</h3>
            <p>srv-app<br>192.168.56.10</p>
        </div>
        <div class="info-card">
            <h3>SERVEUR DB</h3>
            <p>srv-db<br>192.168.56.11</p>
        </div>
        <div class="info-card">
            <h3>JAVA VERSION</h3>
            <p><%= System.getProperty("java.version") %></p>
        </div>
        <div class="info-card">
            <h3>STATUT DB</h3>
            <p><%= dbConnected ? "Connectée ✓" : "Déconnectée ✗" %></p>
        </div>
    </div>

    <div style="text-align: center; margin-top: 30px;">
        <a href="users" class="btn">👥 Gérer les Utilisateurs</a>
    </div>

    <div class="footer">
        <p>Architecture Multi-VM avec Vagrant | Tomcat 9 + MySQL</p>
    </div>
</div>
</body>
</html>