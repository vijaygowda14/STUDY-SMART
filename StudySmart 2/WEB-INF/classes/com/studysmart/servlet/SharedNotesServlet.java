package com.studysmart.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class SharedNotesServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String sem = req.getParameter("sem");
        String msg = req.getParameter("message");

        String path = getServletContext().getRealPath("/") + "shared_sem" + sem + ".txt";

        try (FileWriter fw = new FileWriter(path, true)) {
            fw.write(msg + "\n---\n");
        }

        res.sendRedirect("semesterBoard.jsp?sem=" + sem);
    }
}
