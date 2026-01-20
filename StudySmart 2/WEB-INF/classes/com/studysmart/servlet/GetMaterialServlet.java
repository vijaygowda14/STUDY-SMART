package com.studysmart.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class GetMaterialServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String branch = req.getParameter("branch");
        String sem = req.getParameter("sem");
        String file = req.getParameter("file");

        if (branch == null || sem == null || file == null) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        String appPath = getServletContext().getRealPath("/");
        File materialFile = new File(appPath,
                "materials" + File.separator + branch + File.separator + sem + File.separator + file);

        if (!materialFile.exists()) {
            res.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found at: " + materialFile.getAbsolutePath());
            return;
        }

        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "inline; filename=\"" + file + "\"");

        try (FileInputStream fis = new FileInputStream(materialFile);
                OutputStream os = res.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}
