package com.studysmart.servlet;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String branch = request.getParameter("branch");
        String sem = request.getParameter("sem");
        String filename = request.getParameter("file");
        String username = request.getParameter("username");
        String comment = request.getParameter("comment");

        if (branch != null && sem != null && filename != null && username != null && comment != null
                && !comment.trim().isEmpty()) {
            try {
                // Base path: /shared/{branch}/sem{sem}/{filename}.comments.txt
                String appPath = request.getServletContext().getRealPath("");
                String relativePath = "shared" + File.separator + branch + File.separator + "sem" + sem;
                String dirPath = appPath + File.separator + relativePath;

                File dir = new File(dirPath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File commentFile = new File(dir, filename + ".comments.txt");

                // Format: [yyyy-MM-dd HH:mm] username: comment
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String timestamp = sdf.format(new Date());
                String logEntry = "[" + timestamp + "] " + username + ": " + comment.trim();

                // Append to file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(commentFile, true))) {
                    writer.write(logEntry);
                    writer.newLine();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to resources page with file selected
        response.sendRedirect("semesterResources.jsp?branch=" + branch + "&sem=" + sem + "&file=" + filename);
    }
}
