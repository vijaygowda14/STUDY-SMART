<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>StudySmart - Home</title>
        <link rel="stylesheet" href="css/styles.css">
        <style>
            /* Dashboard container matching notes-container */
            .dashboard-container {
                display: flex;
                min-height: calc(100vh - 200px);
                background-color: var(--white);
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
                overflow: hidden;
                margin-top: 20px;
            }

            /* Sidebar for quick links */
            .dashboard-sidebar {
                width: 260px;
                background-color: #f7f9fb;
                border-right: 1px solid #eef0f2;
                padding: 24px 20px;
            }

            .dashboard-sidebar h3 {
                font-size: 14px;
                font-weight: 600;
                color: #333;
                margin-bottom: 16px;
            }

            .sidebar-link {
                display: block;
                padding: 12px 16px;
                margin-bottom: 4px;
                border-radius: 6px;
                text-decoration: none;
                color: inherit;
                transition: background-color 0.2s ease;
            }

            .sidebar-link:hover {
                background-color: rgba(0, 0, 0, 0.04);
            }

            .sidebar-link h4 {
                font-size: 14px;
                font-weight: 500;
                margin-bottom: 4px;
                color: #333;
            }

            .sidebar-link p {
                font-size: 12px;
                color: #888;
                margin: 0;
            }

            /* Main content area */
            .dashboard-main {
                flex: 1;
                padding: 40px 60px;
                background-color: var(--white);
            }

            .dashboard-main h2 {
                font-size: 32px;
                font-weight: 700;
                color: #111;
                margin-bottom: 8px;
            }

            .dashboard-main>p {
                font-size: 14px;
                color: #888;
                margin-bottom: 32px;
            }

            .tasks-section h3 {
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 16px;
            }

            .task-input-row {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .task-input-row input {
                flex: 1;
                border: 1px solid #eef0f2;
                background-color: #f7f9fb;
                padding: 12px 16px;
                border-radius: 8px;
            }

            .task-input-row input:focus {
                background-color: var(--white);
                border-color: var(--soft-green);
            }

            .task-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .task-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 14px 16px;
                margin-bottom: 8px;
                border-radius: 8px;
                background-color: #f7f9fb;
                border: 1px solid #eef0f2;
            }

            .task-item.completed {
                text-decoration: line-through;
                opacity: 0.6;
                background-color: rgba(135, 154, 119, 0.08);
                border-color: var(--soft-green);
            }

            .task-actions {
                display: flex;
                gap: 8px;
            }

            .task-actions button {
                width: 32px;
                height: 32px;
                border-radius: 6px;
                border: 1px solid #eef0f2;
                background-color: var(--white);
                color: var(--charcoal);
                font-size: 14px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .task-actions button:hover {
                background-color: rgba(0, 0, 0, 0.04);
            }

            .btn-clear {
                margin-top: 16px;
                background-color: transparent;
                color: var(--soft-green);
                border: 1px solid var(--soft-green);
                font-size: 13px;
                padding: 8px 16px;
            }

            .btn-clear:hover {
                background-color: var(--soft-green);
                color: var(--white);
            }
        </style>
    </head>

    <body data-page="home">

        <header>
            <div class="container">
                <h1 class="app-title">StudySmart</h1>
                <nav>
                    <a href="index.jsp" class="active">Home</a>
                    <a href="class.jsp">Materials</a>
                    <a href="notes-api">Notes</a>
                    <a href="profile.jsp">Profile</a>
                </nav>
            </div>
        </header>

        <main class="container" style="max-width: 1400px; padding: 20px;">

            <!-- Hero Headline -->
            <div style="text-align: center; padding: 60px 20px 40px;">
                <h1 style="font-size: 2.5rem; line-height: 1.2; color: #111; letter-spacing: -0.02em;">StudySmart is a
                    simple<br>academic productivity site.</h1>
                <p style="font-size: 1rem; color: #888;">StudySmart is your academic command center. Manage study
                    materials,<br> track tasks,
                    and organize notes-all in one beautiful place.</p>
            </div>

            <!-- Dashboard Container (like notes-container) -->
            <div class="dashboard-container">

                <!-- Sidebar -->
                <aside class="dashboard-sidebar">
                    <h3>Quick Links</h3>

                    <a href="class.jsp" class="sidebar-link">
                        <h4>Study Materials</h4>
                        <p>Semester-wise PDFs</p>
                    </a>

                    <a href="notes-api" class="sidebar-link">
                        <h4>Notes</h4>
                        <p>Quick revision notes</p>
                    </a>

                    <a href="profile.jsp" class="sidebar-link">
                        <h4>Profile</h4>
                        <p>Your info and projects</p>
                    </a>
                </aside>

                <!-- Main Content -->
                <section class="dashboard-main">
                    <h2>Dashboard</h2>
                    <p>Quick access to your study tools and tasks.</p>

                    <div class="tasks-section">
                        <h3>Today's Tasks (<span id="task-count">0</span>)</h3>

                        <div class="task-input-row">
                            <input type="text" id="todo-input" placeholder="Add a new task...">
                            <button id="add-todo-btn">Add</button>
                        </div>

                        <ul id="todo-list" class="task-list"></ul>

                        <button id="clear-done-btn" class="btn-clear">Clear Completed</button>
                    </div>
                </section>

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