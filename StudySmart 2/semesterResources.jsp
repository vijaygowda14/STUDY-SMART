<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.util.*" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>StudySmart - Semester Resources</title>
                <link rel="stylesheet" href="css/styles.css">
                <style>
                    .resource-container {
                        display: grid;
                        grid-template-columns: 350px 1fr;
                        gap: 20px;
                        margin-top: 20px;
                        height: 80vh;
                    }

                    .sidebar {
                        background: #f8f9fa;
                        padding: 20px;
                        border-radius: 8px;
                        overflow-y: auto;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                        height: 100%;
                    }

                    .viewer {
                        background: #fff;
                        border-radius: 8px;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                        overflow: hidden;
                        height: 100%;
                    }

                    iframe {
                        width: 100%;
                        height: 100%;
                        border: none;
                    }

                    .file-card {
                        background: white;
                        border: 1px solid #ddd;
                        border-radius: 4px;
                        margin-bottom: 15px;
                        padding: 10px;
                        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
                    }

                    .file-link {
                        display: block;
                        text-decoration: none;
                        color: #007bff;
                        font-weight: bold;
                        margin-bottom: 5px;
                        word-break: break-all;
                    }

                    .file-link:hover,
                    .file-link.active {
                        text-decoration: underline;
                        color: #0056b3;
                    }

                    .comments-section {
                        border-top: 1px solid #eee;
                        padding-top: 8px;
                        margin-top: 8px;
                    }

                    .comments-list {
                        margin-bottom: 8px;
                        max-height: 120px;
                        overflow-y: auto;
                        background: #fdfdfd;
                        border: 1px solid #f0f0f0;
                        padding: 5px;
                        border-radius: 3px;
                    }

                    .comment-item {
                        margin-bottom: 6px;
                        padding-bottom: 6px;
                        border-bottom: 1px dashed #eee;
                        font-size: 0.8em;
                        color: #555;
                    }

                    .comment-item:last-child {
                        border-bottom: none;
                        margin-bottom: 0;
                        padding-bottom: 0;
                    }

                    .comment-header {
                        font-size: 0.9em;
                        color: #888;
                        margin-bottom: 2px;
                    }

                    .comment-user {
                        color: #333;
                        font-weight: bold;
                    }

                    .comment-text {
                        color: #444;
                        white-space: pre-wrap;
                    }

                    .comment-form {
                        display: flex;
                        flex-direction: column;
                        gap: 5px;
                    }

                    .form-input {
                        width: 100%;
                        padding: 5px;
                        border: 1px solid #ccc;
                        border-radius: 3px;
                        font-size: 0.8em;
                        box-sizing: border-box;
                    }

                    .btn-submit {
                        padding: 4px 8px;
                        background: #007bff;
                        color: white;
                        border: none;
                        border-radius: 3px;
                        cursor: pointer;
                        font-size: 0.8em;
                        align-self: flex-end;
                    }

                    .btn-submit:hover {
                        background: #0056b3;
                    }

                    .upload-form {
                        margin-bottom: 20px;
                        padding-bottom: 20px;
                        border-bottom: 1px solid #dee2e6;
                    }

                    .upload-btn {
                        background-color: #28a745;
                        color: white;
                        padding: 8px 16px;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        width: 100%;
                    }

                    .back-link {
                        display: inline-block;
                        margin-bottom: 15px;
                        color: #666;
                        text-decoration: none;
                    }
                </style>
            </head>

            <body>
                <header>
                    <div class="container">
                        <h1 class="app-title">StudySmart</h1>
                        <nav>
                            <a href="index.jsp">Home</a>
                            <a href="class.jsp" class="active">Materials</a>
                            <a href="notes.jsp">Notes</a>
                            <a href="profile.jsp">Profile</a>
                        </nav>
                    </div>
                </header>

                <main class="container" style="max-width: 1400px; padding: 20px;">
                    <% /* Initialize parameters */ String sem=request.getParameter("sem"); String
                        branch=request.getParameter("branch"); String selectedFile=request.getParameter("file"); if
                        (sem==null || sem.isEmpty()) sem="1" ; if (branch==null) branch="" ; String
                        branchDisplay="Unknown Branch" ; if ("cse".equals(branch)) branchDisplay="Computer Science" ;
                        else if ("ise".equals(branch)) branchDisplay="Information Science" ; else if
                        ("aiml".equals(branch)) branchDisplay="AI & ML" ; else if ("mech".equals(branch))
                        branchDisplay="Mechanical" ; else if ("eee".equals(branch)) branchDisplay="Electrical" ; %>

                        <a href="class.jsp" class="back-link">&larr; Back to Class Selection</a>

                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <h1>Semester <%= sem %> Resources - <%= branchDisplay %>
                            </h1>
                        </div>

                        <div class="resource-container">
                            <div class="sidebar">
                                <div class="upload-form">
                                    <h3>Upload New Resource</h3>
                                    <form action="semesterUpload" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="sem" value="<%= sem %>">
                                        <input type="hidden" name="branch" value="<%= branch %>">
                                        <input type="file" name="file" accept=".pdf" required
                                            style="width: 100%; margin-bottom: 10px;">
                                        <button type="submit" class="upload-btn">Upload PDF</button>
                                    </form>
                                </div>

                                <h3>Available Files</h3>
                                <div class="file-list">
                                    <% if (branch !=null && !branch.isEmpty()) { String
                                        appPath=application.getRealPath(""); String relativePath="shared" +
                                        File.separator + branch + File.separator + "sem" + sem; String dirPath=appPath +
                                        File.separator + relativePath; File dir=new File(dirPath); if (!dir.exists())
                                        dir.mkdirs(); if (dir.exists() && dir.isDirectory()) { File[]
                                        files=dir.listFiles(new FileFilter() { @Override public boolean accept(File
                                        pathname) { return pathname.getName().toLowerCase().endsWith(".pdf"); } }); if
                                        (files !=null && files.length> 0) {
                                        for (File f : files) {
                                        String fileName = f.getName();
                                        String activeClass = (fileName.equals(selectedFile)) ? "active" : "";
                                        /*
                                        Link targets: reload page with ?file param to update iframe
                                        */
                                        String linkUrl = "semesterResources.jsp?sem=" + sem + "&branch=" + branch +
                                        "&file=" + fileName;

                                        /* Read Comments for this file */
                                        List<String[]> comments = new ArrayList<>();
                                                File commentFile = new File(dir, fileName + ".comments.txt");
                                                if (commentFile.exists()) {
                                                try (BufferedReader br = new BufferedReader(new
                                                FileReader(commentFile))) {
                                                String line;
                                                while ((line = br.readLine()) != null) {
                                                /* Parse: [time] user: msg */
                                                String date = "";
                                                String user = "User";
                                                String msg = line;

                                                int bStart = line.indexOf('[');
                                                int bEnd = line.indexOf(']');
                                                if (bStart != -1 && bEnd != -1) {
                                                date = line.substring(bStart + 1, bEnd);
                                                msg = line.substring(bEnd + 1).trim();
                                                }
                                                int colon = msg.indexOf(':');
                                                if (colon != -1) {
                                                user = msg.substring(0, colon).trim();
                                                msg = msg.substring(colon + 1).trim();
                                                }
                                                comments.add(new String[]{date, user, msg});
                                                }
                                                } catch(Exception e) { /* Ignore read errors */ }
                                                }
                                                %>
                                                <div class="file-card">
                                                    <a href="<%= linkUrl %>" class="file-link <%= activeClass %>">
                                                        📄 <%= fileName %>
                                                    </a>

                                                    <div class="comments-section">
                                                        <div class="comments-list">
                                                            <% if (comments.isEmpty()) { %>
                                                                <div class="comment-item"
                                                                    style="color: #999; font-style: italic;">No
                                                                    comments.</div>
                                                                <% } else { for(String[] c : comments) { %>
                                                                    <div class="comment-item">
                                                                        <div class="comment-header">
                                                                            [<%= c[0] %>] <span class="comment-user">
                                                                                    <%= c[1] %>
                                                                                </span>
                                                                        </div>
                                                                        <div class="comment-text">
                                                                            <%= c[2] %>
                                                                        </div>
                                                                    </div>
                                                                    <% } } %>
                                                        </div>

                                                        <form action="addComment" method="post" class="comment-form">
                                                            <input type="hidden" name="branch" value="<%= branch %>">
                                                            <input type="hidden" name="sem" value="<%= sem %>">
                                                            <input type="hidden" name="file" value="<%= fileName %>">

                                                            <input type="text" name="username" class="form-input"
                                                                placeholder="Name" required>
                                                            <textarea name="comment" class="form-input" rows="1"
                                                                placeholder="Comment..." required></textarea>
                                                            <button type="submit" class="btn-submit">Post</button>
                                                        </form>
                                                    </div>
                                                </div>
                                                <% } } else { %>
                                                    <p style="color: #666; font-style: italic;">No files uploaded yet.
                                                    </p>
                                                    <% } } } %>
                                </div>
                            </div>

                            <div class="viewer">
                                <% if (selectedFile !=null && !selectedFile.isEmpty()) { String viewerSrc="shared/" +
                                    branch + "/sem" + sem + "/" + selectedFile; %>
                                    <iframe src="<%= viewerSrc %>"></iframe>
                                    <% } else { %>
                                        <div
                                            style="display: flex; align-items: center; justify-content: center; height: 100%; color: #666;">
                                            <p>Select a file to view.</p>
                                        </div>
                                        <% } %>
                            </div>
                        </div>
                </main>
                <footer>
                    <div class="container">
                        <p>&copy; 2026 StudySmart</p>
                    </div>
                </footer>
            </body>

            </html>