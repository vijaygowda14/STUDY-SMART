package com.studysmart.servlet;

import com.studysmart.dao.NoteDAO;
import com.studysmart.model.Note;

import java.io.*;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class NotesServlet extends HttpServlet {

    // IMAGE_DIR relative to webapp root
    private static final String IMAGE_DIR = "notes_images";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String appPath = request.getServletContext().getRealPath("");
        NoteDAO dao = new NoteDAO(appPath);

        // Always load all notes for the sidebar
        List<Note> allNotes = dao.getAllNotes();
        request.setAttribute("notes", allNotes);

        // Check if a specific note is requested
        String id = request.getParameter("id");
        if (id != null && !id.isEmpty()) {
            Note selectedNote = dao.getNoteById(id);
            request.setAttribute("selectedNote", selectedNote);
        }

        // Forward to the JSP (View)
        RequestDispatcher dispatcher = request.getRequestDispatcher("notes.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String appPath = request.getServletContext().getRealPath("");
        NoteDAO dao = new NoteDAO(appPath);

        if ("delete".equals(action)) {
            String id = request.getParameter("id");
            if (id != null)
                dao.deleteNote(id);
            response.sendRedirect("notes-api"); // Redirect to list (API mapped to /notes-api)
            return;
        }

        // SAVE ACTION
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (title == null || title.trim().isEmpty())
            title = "Untitled";
        if (content == null)
            content = "";

        // Generate ID / Date
        boolean isNew = (id == null || id.trim().isEmpty());
        if (isNew) {
            id = UUID.randomUUID().toString();
        }

        SimpleDateFormat sdf = new SimpleDateFormat("MMM dd, yyyy HH:mm");
        String date = sdf.format(new Date());

        // Helper to get existing image path if not updating
        String imagePath = request.getParameter("existingImage");

        // Handle File Upload
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            // clean filename
            fileName = fileName.replaceAll("\\s+", "_");
            String uniqueName = System.currentTimeMillis() + "_" + fileName;

            // Save directory
            File imgDir = new File(appPath + File.separator + IMAGE_DIR);
            if (!imgDir.exists())
                imgDir.mkdirs();

            filePart.write(imgDir.getAbsolutePath() + File.separator + uniqueName);
            imagePath = IMAGE_DIR + "/" + uniqueName;
        }

        Note note = new Note(id, title, content, date, imagePath);
        dao.saveNote(note);

        // Redirect back to the view of this note
        response.sendRedirect("notes-api?id=" + id);
    }
}
