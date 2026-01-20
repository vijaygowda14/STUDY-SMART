const bodyPage = document.body.dataset.page;

/* ================= CLASS PAGE ================= */
if (bodyPage === "class") {

  const branchSelect = document.getElementById("branch-select");

  if (branchSelect) {
    branchSelect.addEventListener("change", () => {
      if (branchSelect.value) {
        branchSelect.classList.add("active");
      } else {
        branchSelect.classList.remove("active");
      }
    });
  }

  const semButtons = document.querySelectorAll(".sem-btn");

  const materialLinks = {
    cse: {
      1: "getMaterial?branch=cse&sem=sem1&file=cse1styear.pdf",
      2: "getMaterial?branch=cse&sem=sem2&file=cse1styear.pdf",
      3: "getMaterial?branch=cse&sem=sem3&file=cse2ndyear.pdf",
      4: "getMaterial?branch=cse&sem=sem4&file=cse2ndyear.pdf",
      5: "getMaterial?branch=cse&sem=sem5&file=cse3rdyear.pdf",
      6: "getMaterial?branch=cse&sem=sem6&file=cse3rdyear.pdf",
      7: "getMaterial?branch=cse&sem=sem7&file=",
      8: "getMaterial?branch=cse&sem=sem8&file="
    }
  };

  semButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const branch = branchSelect.value;
      const sem = btn.dataset.sem;

      if (!branch) {
        alert("Please select your branch first.");
        return;
      }

      const url = materialLinks[branch]?.[sem];

      if (url) window.open(url, "_blank");
      else alert("No material uploaded for this semester.");
    });
  });
}


/* ================= PROFILE PAGE ================= */
if (bodyPage === "profile") {

  const photoInput = document.getElementById("photo-input");
  const photoImg = document.getElementById("profile-photo");
  const nameInput = document.getElementById("profile-name");
  const workInput = document.getElementById("profile-work");
  const addProjectBtn = document.getElementById("add-project-btn");
  const saveBtn = document.getElementById("save-profile-btn");
  const projectList = document.getElementById("project-list");

  const savedProfile = JSON.parse(localStorage.getItem("profile")) || {};

  if (savedProfile.photo && photoImg) photoImg.src = savedProfile.photo;
  if (savedProfile.name && nameInput) nameInput.value = savedProfile.name;
  if (savedProfile.work && workInput) workInput.value = savedProfile.work;

  if (savedProfile.projects && projectList) {
    projectList.innerHTML = "";
    savedProfile.projects.forEach(p => {
      const li = document.createElement("li");
      li.textContent = p;
      projectList.appendChild(li);
    });
  }

  if (photoInput && photoImg) {
    photoInput.addEventListener("change", () => {
      const file = photoInput.files[0];
      if (!file) return;

      const reader = new FileReader();
      reader.onload = e => photoImg.src = e.target.result;
      reader.readAsDataURL(file);
    });
  }

  if (addProjectBtn && projectList) {
    addProjectBtn.addEventListener("click", () => {
      const title = prompt("Enter project title:");
      if (!title) return;

      const li = document.createElement("li");
      li.textContent = title;
      projectList.appendChild(li);
    });
  }

  if (saveBtn) {
    saveBtn.addEventListener("click", () => {
      const projects = [];
      projectList.querySelectorAll("li").forEach(li => projects.push(li.textContent));

      const profile = {
        name: nameInput.value,
        work: workInput.value,
        photo: photoImg.src,
        projects
      };

      localStorage.setItem("profile", JSON.stringify(profile));
      alert("Profile saved successfully");
    });
  }
}


/* ================= HOME PAGE TASKS ================= */
if (bodyPage === "home") {

  const todoInput = document.getElementById("todo-input");
  const addTodoBtn = document.getElementById("add-todo-btn");
  const todoList = document.getElementById("todo-list");
  const countSpan = document.getElementById("task-count");
  const clearBtn = document.getElementById("clear-done-btn");

  let todos = JSON.parse(localStorage.getItem("todos")) || [];

  function renderTodos() {
    todoList.innerHTML = "";
    let remaining = 0;

    todos.forEach((task, index) => {
      if (!task.done) remaining++;

      const li = document.createElement("li");
      li.className = "task-item";
      if (task.done) li.classList.add("completed");

      li.innerHTML = `
        <span>${task.text}</span>
        <div class="task-actions">
          <button onclick="toggleTodo(${index})">✓</button>
          <button onclick="deleteTodo(${index})">✕</button>
        </div>
      `;
      todoList.appendChild(li);
    });

    countSpan.textContent = remaining;
  }

  window.toggleTodo = index => {
    todos[index].done = !todos[index].done;
    localStorage.setItem("todos", JSON.stringify(todos));
    renderTodos();
  };

  window.deleteTodo = index => {
    todos.splice(index, 1);
    localStorage.setItem("todos", JSON.stringify(todos));
    renderTodos();
  };

  addTodoBtn.addEventListener("click", () => {
    const text = todoInput.value.trim();
    if (!text) return;

    todos.push({ text, done: false });
    localStorage.setItem("todos", JSON.stringify(todos));
    todoInput.value = "";
    renderTodos();
  });

  clearBtn.addEventListener("click", () => {
    todos = todos.filter(t => !t.done);
    localStorage.setItem("todos", JSON.stringify(todos));
    renderTodos();
  });

  renderTodos();
}


/* ================= NOTES PAGE ================= */
if (bodyPage === "notes") {

  const titleInput = document.querySelector(".editor-title-input");
  const contentInput = document.querySelector(".editor-content-textarea");
  const saveBtn = document.getElementById("save-note-btn");
  const notesListUl = document.getElementById("notes-list-ul");
  const addNoteBtn = document.querySelector(".add-note-btn");
  const lastEditedSpan = document.querySelector(".last-edited");
  const dateCreatedSpan = document.querySelector(".meta-value");

  let currentNoteId = null;

  // Load Notes from Backend
  function loadNotes() {
    fetch('notes-api')
      .then(res => res.json())
      .then(data => {
        renderNotesList(data);
        if (data.length > 0 && !currentNoteId) {
          // Auto-select first note if none selected
          loadNoteContent(data[0]);
        }
      })
      .catch(err => console.error("Error loading notes:", err));
  }

  function renderNotesList(notes) {
    notesListUl.innerHTML = "";
    notes.forEach(note => {
      const li = document.createElement("li");
      li.className = `note-item ${note.id === currentNoteId ? 'active' : ''}`;
      li.innerHTML = `
        <span class="note-title-preview">${note.title || 'Untitled'}</span>
        <span class="note-date">${note.date}</span>
      `;
      li.onclick = () => loadNoteContent(note);
      notesListUl.appendChild(li);
    });
  }

  function loadNoteContent(note) {
    currentNoteId = note.id;
    titleInput.value = note.title;
    contentInput.value = note.content;
    dateCreatedSpan.textContent = note.date;
    lastEditedSpan.textContent = "Last saved: " + note.date; // Simplified for now

    // Refresh list highlight
    document.querySelectorAll(".note-item").forEach(item => item.classList.remove("active"));
    // Re-fetch list to update active state correctly or manually update DOM (simpler to just re-render or toggle class if we had ref)
    // For now, let's just re-fetch to be safe and simple
    loadNotes();
  }

  // New Note
  addNoteBtn.addEventListener("click", () => {
    currentNoteId = null;
    titleInput.value = "";
    contentInput.value = "";
    dateCreatedSpan.textContent = new Date().toLocaleDateString();
    lastEditedSpan.textContent = "New Note";
    titleInput.focus();
  });

  // Save Note
  saveBtn.addEventListener("click", () => {
    const title = titleInput.value.trim() || "Untitled";
    const content = contentInput.value;

    const formData = new URLSearchParams();
    if (currentNoteId) formData.append("id", currentNoteId);
    formData.append("title", title);
    formData.append("content", content);

    fetch('notes-api', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
      body: formData
    })
      .then(res => res.json())
      .then(data => {
        if (data.status === "success") {
          currentNoteId = data.id;
          lastEditedSpan.textContent = "Saved just now";
          dateCreatedSpan.textContent = data.date;
          loadNotes(); // Refresh list to show new title/date
        }
      })
      .catch(err => console.error("Error saving note:", err));
  });

  // Initial Load
  loadNotes();
}


/* ================= NOTE VIEW PAGE ================= */
if (bodyPage === "noteView") {

  const params = new URLSearchParams(window.location.search);
  const id = params.get("id");

  let notes = JSON.parse(localStorage.getItem("notes")) || [];

  const dateEl = document.getElementById("note-date");
  const contentEl = document.getElementById("note-content");
  const deleteBtn = document.getElementById("delete-note-btn");

  if (notes[id]) {
    dateEl.textContent = notes[id].date;
    contentEl.textContent = notes[id].text;
  }

  deleteBtn.addEventListener("click", () => {
    notes.splice(id, 1);
    localStorage.setItem("notes", JSON.stringify(notes));
    window.location.href = "notes.jsp";
  });
}
