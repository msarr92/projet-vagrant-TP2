<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des Utilisateurs</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 30px auto;
            background: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }
        h1 { color: #667eea; margin-bottom: 30px; }
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .message-ok { background: #d4edda; color: #155724; }
        .message-error { background: #f8d7da; color: #721c24; }
        .form-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 500; }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .btn {
            padding: 12px 30px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover { background: #764ba2; }
        .btn-secondary { background: #6c757d; margin-left: 10px; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background: #667eea;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover { background: #f8f9fa; }
    </style>
</head>
<body>
<div class="container">
    <h1>👥 Gestion des Utilisateurs</h1>

    <%
        String message = (String) request.getAttribute("message");
        String errorMessage = (String) request.getAttribute("errorMessage");
        @SuppressWarnings("unchecked")
        List<Map<String, String>> users = (List<Map<String, String>>) request.getAttribute("users");
    %>

    <% if (message != null) { %>
    <div class="message message-ok"><%= message %></div>
    <% } %>

    <% if (errorMessage != null) { %>
    <div class="message message-error"><%= errorMessage %></div>
    <% } %>

    <div class="form-section">
        <h2>➕ Ajouter un Utilisateur</h2>
        <form method="post" action="users">
            <div class="form-group">
                <label>Nom d'utilisateur:</label>
                <input type="text" name="username" required>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required>
            </div>
            <div class="form-group">
                <label>Nom complet:</label>
                <input type="text" name="fullname" required>
            </div>
            <button type="submit" class="btn">Ajouter</button>
            <a href="index.jsp" class="btn btn-secondary">Retour</a>
        </form>
    </div>

    <h2>📋 Liste des Utilisateurs (<%= users != null ? users.size() : 0 %>)</h2>

    <% if (users != null && !users.isEmpty()) { %>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Nom complet</th>
            <th>Date création</th>
        </tr>
        </thead>
        <tbody>
        <% for (Map<String, String> user : users) { %>
        <tr>
            <td><%= user.get("id") %></td>
            <td><%= user.get("username") %></td>
            <td><%= user.get("email") %></td>
            <td><%= user.get("fullname") %></td>
            <td><%= user.get("created_at") %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } else { %>
    <p style="text-align: center; padding: 40px; color: #666;">Aucun utilisateur trouvé</p>
    <% } %>
</div>
</body>
</html>