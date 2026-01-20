package com.studysmart.servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 20) // 20 MB
public class SemesterUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final List<String> ALLOWED_BRANCHES = Arrays.asList("cse", "ise", "aiml", "mech", "eee");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sem = request.getParameter("sem");
        String branch = request.getParameter("branch");
        Part filePart = request.getPart("file");

        // Basic validation
        if (sem == null || sem.isEmpty() || branch == null || !ALLOWED_BRANCHES.contains(branch)) {
            response.sendRedirect("semesterResources.jsp?sem=" + (sem != null ? sem : "1") + "&branch="
                    + (branch != null ? branch : "") + "&error=Invalid parameters");
            return;
        }

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect("semesterResources.jsp?sem=" + sem + "&branch=" + branch + "&error=No file selected");
            return;
        }

        // Validate PDF
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!fileName.toLowerCase().endsWith(".pdf")) {
            response.sendRedirect(
                    "semesterResources.jsp?sem=" + sem + "&branch=" + branch + "&error=Only PDF files are allowed");
            return;
        }

        // Get upload path: /shared/{branch}/sem{sem}
        String appPath = request.getServletContext().getRealPath("");
        String uploadPath = appPath + File.separator + "shared" + File.separator + branch + File.separator + "sem"
                + sem;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Write file
        try {
            filePart.write(uploadPath + File.separator + fileName);
            response.sendRedirect(
                    "semesterResources.jsp?sem=" + sem + "&branch=" + branch + "&success=Upload successful");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("semesterResources.jsp?sem=" + sem + "&branch=" + branch + "&error=Upload failed");
        }
    }
}
