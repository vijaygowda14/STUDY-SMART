package com.studysmart.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String msg = req.getParameter("message");

        String path = getServletContext().getRealPath("/") + "feedback.txt";

        try (FileWriter fw = new FileWriter(path, true)) {
            fw.write(msg + "\n----------------\n");
        }

        res.sendRedirect("index.jsp");
    }
}
