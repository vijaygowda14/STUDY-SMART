<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>StudySmart - Profile</title>
        <link rel="stylesheet" href="css/styles.css">
    </head>

    <body data-page="profile">

        <!-- ===== Header ===== -->
        <header>
            <div class="container">
                <h1 class="app-title">StudySmart</h1>
                <nav>
                    <a href="index.jsp">Home</a>
                    <a href="class.jsp">Materials</a>
                    <a href="notes.jsp">Notes</a>
                    <a href="profile.jsp" class="active">Profile</a>
                </nav>
            </div>
        </header>

        <!-- ===== Main Content ===== -->
        <main class="container">

            <div class="card">
                <h2>Your Profile</h2>
                <p>Manage your photo, basic details, and academic projects.</p>
            </div>

            <!-- Profile Details -->
            <div class="card">
                <div style="display:flex; gap:30px; flex-wrap:wrap; align-items:center;">

                    <!-- Profile Picture -->
                    <div>
                        <div class="profile-pic-wrapper">
                            <img id="profile-photo" src="https://via.placeholder.com/300" alt="Profile Photo" />
                        </div>

                        <label style="display:block; margin-top:12px;">
                            <input type="file" id="photo-input" accept="image/*">
                        </label>
                    </div>

                    <!-- Profile Info -->
                    <div style="flex:1; min-width:220px;">
                        <label>Name</label>
                        <input type="text" id="profile-name" placeholder="Enter your full name">

                        <label style="margin-top:12px; display:block;">Role / Work</label>
                        <input type="text" id="profile-work" placeholder="e.g. CSE Student">
                    </div>

                </div>
            </div>

            <!-- Projects -->

            <div style="margin-top:12px;">
                <button id="save-profile-btn" style="margin-left:8px;">Save Profile</button>
            </div>
            </div>

        </main>

        <footer>
            <div class="container">
                <p>&copy; 2026 StudySmart</p>
            </div>
        </footer>


        <script src="js/script.js"></script>
    </body>

    </html>