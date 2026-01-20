<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.*" %>
        <%@ page import="com.studysmart.model.Note" %>
            <% List<Note> notes = (List<Note>) request.getAttribute("notes");
                    Note selectedNote = (Note) request.getAttribute("selectedNote");

                    if (notes == null) notes = new ArrayList<>();
                        String currentId = (selectedNote != null) ? selectedNote.getId() : "";
                        String currentTitle = (selectedNote != null) ? selectedNote.getTitle() : "";
                        String currentContent = (selectedNote != null) ? selectedNote.getContent() : "";
                        String currentDate = (selectedNote != null) ? selectedNote.getCreatedAt() : new
                        java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(new Date());
                        String currentImage = (selectedNote != null) ? selectedNote.getImagePath() : "";
                        %>
                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">
                            <title>StudySmart - Notes</title>
                            <link rel="stylesheet" href="css/styles.css">
                            <style>
                                .notes-list-item {
                                    text-decoration: none;
                                    display: block;
                                    padding: 12px 16px;
                                    margin-bottom: 4px;
                                    border-radius: 6px;
                                    color: inherit;
                                }

                                .notes-list-item:hover {
                                    background-color: rgba(0, 0, 0, 0.04);
                                }

                                .notes-list-item.active {
                                    background-color: rgba(0, 0, 0, 0.06);
                                    font-weight: 500;
                                }

                                .image-preview {
                                    max-width: 100%;
                                    max-height: 300px;
                                    border-radius: 8px;
                                    margin-bottom: 20px;
                                    display: block;
                                    object-fit: cover;
                                }
                            </style>
                        </head>

                        <body data-page="notes-ssr">

                            <header>
                                <div class="container">
                                    <h1 class="app-title">StudySmart</h1>
                                    <nav>
                                        <a href="index.jsp">Home</a>
                                        <a href="class.jsp">Materials</a>
                                        <a href="notes-api" class="active">Notes</a>
                                        <a href="profile.jsp">Profile</a>
                                    </nav>
                                </div>
                            </header>

                            <main class="container" style="max-width: 1400px; padding: 20px;">
                                <div class="notes-container">

                                    <aside class="notes-sidebar">
                                        <div class="sidebar-header">
                                            <h3>My Notes</h3>
                                            <a href="notes-api" class="add-note-btn" title="New Note"
                                                style="text-decoration:none;">+</a>
                                        </div>

                                        <div class="notes-list">
                                            <% if (notes.isEmpty()) { %>
                                                <div
                                                    style="padding:20px; color:#888; font-size:13px; text-align:center;">
                                                    No notes yet. Click + to add one.</div>
                                                <% } else { for (Note n : notes) { String
                                                    activeClass=n.getId().equals(currentId) ? "active" : "" ; %>
                                                    <a href="notes-api?id=<%= n.getId() %>"
                                                        class="notes-list-item <%= activeClass %>">
                                                        <div class="note-title-preview">
                                                            <%= n.getTitle() %>
                                                        </div>
                                                        <div class="note-date">
                                                            <%= n.getCreatedAt() %>
                                                        </div>
                                                    </a>
                                                    <% } } %>
                                        </div>
                                    </aside>

                                    <section class="notes-editor">
                                        <form action="notes-api" method="post" enctype="multipart/form-data"
                                            class="editor-form"
                                            style="height:100%; display:flex; flex-direction:column;">
                                            <input type="hidden" name="action" value="save">
                                            <input type="hidden" name="id" value="<%= currentId %>">
                                            <input type="hidden" name="existingImage"
                                                value="<%= (currentImage != null ? currentImage : "") %>">

                                            <div class="editor-header">
                                                <span class="last-edited">
                                                    <%= currentDate %>
                                                </span>
                                                <div class="editor-actions">
                                                    <% if (selectedNote !=null) { %>
                                                        <button type="submit"
                                                            formaction="notes-api?action=delete&id=<%= currentId %>"
                                                            formmethod="post" formnovalidate class="btn-text"
                                                            style="color:#d9534f; cursor:pointer; background:none; border:none;">Delete</button>
                                                        <% } %>
                                                            <button type="submit" class="save-btn"
                                                                style="cursor:pointer;">Save Note</button>
                                                </div>
                                            </div>

                                            <div class="editor-body">
                                                <input type="text" name="title" class="editor-title-input"
                                                    placeholder="Untitled" value="<%= currentTitle %>">

                                                <div class="image-section" style="margin-bottom: 20px;">
                                                    <% if (currentImage !=null && !currentImage.isEmpty()) { %>
                                                        <img src="<%= currentImage %>" alt="Note Image"
                                                            class="image-preview">
                                                        <% } %>
                                                            <label for="img-upload" class="image-upload-label"
                                                                style="cursor:pointer; color:#888; font-size:13px; display:inline-flex; align-items:center; gap:6px;">
                                                                <span>📷 <%= (currentImage !=null &&
                                                                        !currentImage.isEmpty()) ? "Change Image"
                                                                        : "Add Cover Image" %></span>
                                                                <input type="file" name="image" id="img-upload"
                                                                    accept="image/*" style="display:none;">
                                                            </label>
                                                </div>

                                                <textarea name="content" class="editor-content-textarea"
                                                    placeholder="Start writing..."><%= currentContent %></textarea>
                                            </div>
                                        </form>
                                    </section>

                                </div>
                            </main>

                        </body>

                        </html>