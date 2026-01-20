package com.studysmart.dao;

import com.studysmart.model.Note;
import java.io.*;
import java.util.*;

public class NoteDAO {
    private String dataDirectory;

    public NoteDAO(String appPath) {
        // Store data in a folder named 'notes_db' inside the webapp root
        this.dataDirectory = appPath + File.separator + "notes_db";
        File dir = new File(this.dataDirectory);
        if (!dir.exists()) {
            dir.mkdirs();
        }
    }

    public List<Note> getAllNotes() {
        List<Note> notes = new ArrayList<>();
        File folder = new File(dataDirectory);
        File[] files = folder.listFiles((dir, name) -> name.endsWith(".txt"));

        if (files != null) {
            // Sort by last modified (newest first)
            Arrays.sort(files, (f1, f2) -> Long.compare(f2.lastModified(), f1.lastModified()));

            for (File file : files) {
                Note note = readNoteFromFile(file);
                if (note != null) {
                    notes.add(note);
                }
            }
        }
        return notes;
    }

    public Note getNoteById(String id) {
        File file = new File(dataDirectory + File.separator + id + ".txt");
        if (file.exists()) {
            return readNoteFromFile(file);
        }
        return null;
    }

    public void saveNote(Note note) {
        File file = new File(dataDirectory + File.separator + note.getId() + ".txt");
        try (PrintWriter writer = new PrintWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"))) {
            // Simple custom format:
            // Line 1: ID
            // Line 2: CreatedAt
            // Line 3: Title
            // Line 4: ImagePath
            // Line 5+: Content
            writer.println(note.getId());
            writer.println(note.getCreatedAt());
            writer.println(note.getTitle());
            writer.println(note.getImagePath() == null ? "" : note.getImagePath());
            writer.print(note.getContent());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void deleteNote(String id) {
        File file = new File(dataDirectory + File.separator + id + ".txt");
        if (file.exists()) {
            file.delete();
        }
    }

    private Note readNoteFromFile(File file) {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"))) {
            String id = br.readLine();
            String date = br.readLine();
            String title = br.readLine();
            String imgPath = br.readLine();

            StringBuilder content = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                content.append(line).append("\n");
            }

            return new Note(id, title, content.toString().trim(), date, imgPath);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
