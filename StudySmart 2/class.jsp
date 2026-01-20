<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>StudySmart - Class</title>
  <link rel="stylesheet" href="css/styles.css">
  <style>
    /* Class page container - matching notes-container */
    .class-container {
      background-color: var(--white);
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
      padding: 40px 60px;
      margin-top: 20px;
    }

    .class-container h2 {
      font-size: 1.5rem;
      margin-bottom: 8px;
    }

    .class-container>p {
      font-size: 14px;
      color: var(--charcoal);
      margin-bottom: 24px;
    }

    .section-title {
      font-size: 1.7rem;
      font-weight: 600;
      margin-top: 32px;
      margin-bottom: 16px;
    }

    .hint-text {
      font-size: 13px;
      color: #888;
      margin-top: 12px;
    }

    .divider {
      border: none;
      border-top: 1px solid #eef0f2;
      margin: 32px 0;
    }
  </style>
</head>

<body data-page="class">
  <header>
    <div class="container">
      <h1 class="app-title">StudySmart</h1>
      <nav>
        <a href="index.jsp">Home</a>
        <a href="class.jsp" class="active">Materials</a>
        <a href="notes-api">Notes</a>
        <a href="profile.jsp">Profile</a>
      </nav>
    </div>
  </header>

  <main class="container" style="max-width: 1200px; padding: 20px;">

    <!-- Hero Headline -->
    <div style="text-align: center; padding: 60px 20px 40px;">
      <h1 style="font-size: 2.5rem; line-height: 1.2; color: #111; letter-spacing: -0.02em;">Select Your Branch &
        Semester</h1>
      <p style="font-size: 1rem; color: #888;">Choose a branch and semester to open the study materials.</p>
    </div>

    <!-- Class Container (like notes-container) -->
    <div class="class-container">

      <!-- Branch Select -->
      <div class="branch-select-wrapper">
        <label for="branch-select">Select Branch</label>
        <select id="branch-select" class="branch-select">
          <option value="">Select Branch</option>
          <option value="cse">Computer Science Engineering</option>
          <option value="ise">Information Science & Engineering</option>
          <option value="aiml">AI & ML</option>
          <option value="mech">Mechanical Engineering</option>
          <option value="eee">Electrical Engineering</option>
        </select>
      </div>

      <h3 class="section-title">Semesters wise syllabus:</h3>
      <div class="sem-grid">
        <button class="sem-btn" data-sem="1">Semester 1</button>
        <button class="sem-btn" data-sem="2">Semester 2</button>
        <button class="sem-btn" data-sem="3">Semester 3</button>
        <button class="sem-btn" data-sem="4">Semester 4</button>
        <button class="sem-btn" data-sem="5">Semester 5</button>
        <button class="sem-btn" data-sem="6">Semester 6</button>
        <button class="sem-btn" data-sem="7">Semester 7</button>
        <button class="sem-btn" data-sem="8">Semester 8</button>
      </div>

      <p class="hint-text">Select your semester</p>

      <hr class="divider">

      <h3 class="section-title">Notes sharing with your batchmates</h3>
      <p style="font-size: 14px; color: var(--charcoal); margin-bottom: 16px;">Upload and view shared PDFs for your
        semester.</p>

      <div class="sem-grid">
        <button onclick="openSharedResources(1)">Sem 1 Resources</button>
        <button onclick="openSharedResources(2)">Sem 2 Resources</button>
        <button onclick="openSharedResources(3)">Sem 3 Resources</button>
        <button onclick="openSharedResources(4)">Sem 4 Resources</button>
        <button onclick="openSharedResources(5)">Sem 5 Resources</button>
        <button onclick="openSharedResources(6)">Sem 6 Resources</button>
        <button onclick="openSharedResources(7)">Sem 7 Resources</button>
        <button onclick="openSharedResources(8)">Sem 8 Resources</button>
      </div>

      <script>
        function openBoard(sem) {
          window.location.href = "semesterBoard.jsp?sem=" + sem;
        }

        function openSharedResources(sem) {
          const branchSelect = document.getElementById('branch-select');
          const branch = branchSelect.value;

          if (!branch || branch === "") {
            alert("Please select your branch first.");
            branchSelect.focus();
            return;
          }

          window.location.href = "semesterResources.jsp?sem=" + sem + "&branch=" + branch;
        }
      </script>

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