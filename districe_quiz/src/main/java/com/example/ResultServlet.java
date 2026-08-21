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

@WebServlet("/result")
public class ResultServlet extends HttpServlet {

    @Override
    protected void doPost(
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

        String name =
                (String) session.getAttribute(
                        "userName"
                );

        int score = 0;
        int total = 0;

        String questionSql = """
                SELECT id, correct_answer
                FROM questions
                ORDER BY id
                LIMIT 20
                """;

        try (
                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(
                                questionSql
                        );

                ResultSet resultSet =
                        statement.executeQuery()
        ) {

            while (resultSet.next()) {

                int id =
                        resultSet.getInt("id");

                String correctAnswer =
                        resultSet.getString(
                                "correct_answer"
                        );

                String userAnswer =
                        request.getParameter(
                                "answer_" + id
                        );

                total++;

                if (
                        userAnswer != null &&
                                userAnswer.equals(
                                        correctAnswer
                                )
                ) {

                    score++;
                }
            }

            // Save result to database

            String insertSql = """
                    INSERT INTO quiz_results
                    (name, total_marks)
                    VALUES (?, ?)
                    """;

            try (
                    PreparedStatement insertStatement =
                            connection.prepareStatement(
                                    insertSql
                            )
            ) {

                insertStatement.setString(
                        1,
                        name
                );

                insertStatement.setInt(
                        2,
                        score
                );

                insertStatement.executeUpdate();
            }

            request.setAttribute(
                    "name",
                    name
            );

            request.setAttribute(
                    "score",
                    score
            );

            request.setAttribute(
                    "total",
                    total
            );

            // Clear login session
            session.invalidate();

            request.getRequestDispatcher(
                    "result.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (Exception e) {

            throw new ServletException(
                    "Error processing quiz result",
                    e
            );
        }
    }
}