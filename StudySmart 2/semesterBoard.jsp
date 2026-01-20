<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>StudySmart - Semester Board</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>

    <body data-page="semesterBoard">

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

        <main class="container">
            <div class="card">
                <h2>Semester Shared Notes</h2>
                <p>Share updates or quick info with your batchmates.</p>

                <form action="sharedNotes" method="post" style="margin-top: 20px;">
                    <input type="hidden" name="sem" id="semInput">

                    <textarea name="message" rows="4" placeholder="Post your note here..." required></textarea>

                    <div style="margin-top: 10px; text-align: right;">
                        <button type="submit">Post Note</button>
                    </div>
                </form>

                <hr style="margin: 30px 0; border: 0; border-top: 1px solid var(--gray);">

                <div id="notes">
                    <!-- Notes will be loaded here by backend or JS if implemented -->
                    <p style="text-align:center; color: var(--charcoal); font-style:italic;">No recent notes shared.</p>
                </div>
            </div>
        </main>

        <footer>
            <div class="container">
                <p>&copy; 2026 StudySmart</p>
            </div>
        </footer>

        <script src="js/script.js"></script>
        <script>
            const params = new URLSearchParams(window.location.search);
            const sem = params.get("sem");
            if (sem) {
                document.getElementById("semInput").value = sem;
            }
        </script>
    </body>

    </html>