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

public class FileCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String branch = request.getParameter("branch");
        String sem = request.getParameter("sem");
        String filename = request.getParameter("filename");
        String comment = request.getParameter("comment");

        if (branch != null && sem != null && filename != null && comment != null && !comment.trim().isEmpty()) {
            try {
                // Base path: /shared/{branch}/sem{sem}/comments/
                String appPath = request.getServletContext().getRealPath("");
                String commentDirRel = "shared" + File.separator + branch + File.separator + "sem" + sem
                        + File.separator + "comments";
                String commentDirPath = appPath + File.separator + commentDirRel;

                File commentDir = new File(commentDirPath);
                if (!commentDir.exists()) {
                    commentDir.mkdirs();
                }

                // Comment file: {filename}.txt
                File commentFile = new File(commentDir, filename + ".txt");

                // Format: [YYYY-MM-DD HH:mm:ss] Comment text
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String timestamp = sdf.format(new Date());
                String logEntry = "[" + timestamp + "] " + comment.trim();

                // Append to file
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(commentFile, true))) {
                    writer.write(logEntry);
                    writer.newLine();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect back to resources page
        response.sendRedirect("semesterResources.jsp?branch=" + branch + "&sem=" + sem);
    }
}
