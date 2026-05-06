package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * LoginServlet — authenticates users against the in-memory user store
 * (backed by DBConnection) and redirects to dashboard.html on success.
 *
 * POST /LoginServlet
 *   params: username, password
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Allow GET to redirect to login page (helpful for direct URL access)
        response.sendRedirect("login.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Basic null/empty guard
        if (username == null || password == null ||
            username.trim().isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.html?error=empty");
            return;
        }

        username = username.trim();

        if (DBConnection.validateUser(username, password)) {
            // ── Success: store user in session ──────────────────────────────
            HttpSession session = request.getSession();
            session.setAttribute("ir-user",      username);
            session.setAttribute("ir-studentId", DBConnection.getStudentId(username));
            session.setMaxInactiveInterval(60 * 30); // 30 minutes

            response.sendRedirect("dashboard.html");

        } else {
            // ── Failure: back to login with error flag ──────────────────────
            response.sendRedirect("login.html?error=invalid");
        }
    }
}