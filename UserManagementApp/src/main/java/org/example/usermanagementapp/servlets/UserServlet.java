package org.example.usermanagementapp.servlets;


import org.example.usermanagementapp.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/users")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> users = new ArrayList<>();
        String errorMessage = null;

        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM users ORDER BY id")) {

            while (rs.next()) {
                Map<String, String> user = new HashMap<>();
                user.put("id", String.valueOf(rs.getInt("id")));
                user.put("username", rs.getString("username"));
                user.put("email", rs.getString("email"));
                user.put("fullname", rs.getString("fullname"));
                user.put("created_at", rs.getTimestamp("created_at").toString());
                users.add(user);
            }

        } catch (SQLException e) {
            errorMessage = "Erreur: " + e.getMessage();
        }

        request.setAttribute("users", users);
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String message = null;

        if (username != null && !username.trim().isEmpty()) {
            try (Connection conn = DatabaseUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO users (username, email, fullname) VALUES (?, ?, ?)")) {

                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, fullname);

                int rows = stmt.executeUpdate();
                message = rows > 0 ? "✓ Utilisateur ajouté avec succès!" : "✗ Erreur lors de l'ajout";

            } catch (SQLException e) {
                message = "✗ Erreur: " + e.getMessage();
            }
        }

        request.setAttribute("message", message);
        doGet(request, response);
    }
}