package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty()) {

            response.sendRedirect("login.jsp");

            return;
        }

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "userName",
                name.trim()
        );

        response.sendRedirect("quiz");

    }
}