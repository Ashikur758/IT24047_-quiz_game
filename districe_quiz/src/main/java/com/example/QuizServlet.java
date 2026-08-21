package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (
                session == null ||
                        session.getAttribute("userName") == null
        ) {

            response.sendRedirect("login.jsp");

            return;
        }

        String sql = """
                SELECT *
                FROM questions
                ORDER BY id
                LIMIT 20
                """;

        List<Map<String, Object>> questions =
                new ArrayList<>();

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql);

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                Map<String, Object> question =
                        new HashMap<>();

                question.put(
                        "id",
                        resultSet.getInt("id")
                );

                question.put(
                        "upazila",
                        resultSet.getString("upazila")
                );

                question.put(
                        "question",
                        resultSet.getString("question")
                );

                question.put(
                        "optionA",
                        resultSet.getString("option_a")
                );

                question.put(
                        "optionB",
                        resultSet.getString("option_b")
                );

                question.put(
                        "optionC",
                        resultSet.getString("option_c")
                );

                question.put(
                        "optionD",
                        resultSet.getString("option_d")
                );

                questions.add(question);
            }

            request.setAttribute(
                    "questions",
                    questions
            );

            request.getRequestDispatcher(
                    "quiz.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            throw new ServletException(
                    "Error loading quiz questions",
                    e
            );
        }
    }
}