const inputBox = document.getElementById("input-box");
const listContainer = document.getElementById("list-container");

async function addTask() {
  if (inputBox.value === "") {
    alert("You must write some tasks!");
  } else {
    let todo = {
      text: inputBox.value,
      completed: false,
    };
    let response = await fetch("/api/todos", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(todo),
    });
    let savedTodo = await response.json();
    appendTodoToList(savedTodo);
  }
  inputBox.value = "";
}

function appendTodoToList(todo) {
  let li = document.createElement("li");
  li.innerHTML = todo.text;
  li.dataset.id = todo.id;
  if (todo.completed) {
    li.classList.add("checked");
  }
  listContainer.append(li);
  let span = document.createElement("span");
  span.innerHTML = "\u00d7";
  li.appendChild(span);
}

listContainer.addEventListener(
  "click",
  function (e) {
    if (e.target.tagName === "LI") {
      e.target.classList.toggle("checked");
      updateTodoStatus(
        e.target.dataset.id,
        e.target.classList.contains("checked")
      );
    } else if (e.target.tagName === "SPAN") {
      let id = e.target.parentElement.dataset.id;
      deleteTask(id);
      e.target.parentElement.remove();
    }
  },
  false
);

async function updateTodoStatus(id, completed) {
  await fetch(`/api/todos/${id}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ completed: completed }),
  });
}

async function deleteTask(id) {
  await fetch(`/api/todos/${id}`, {
    method: "DELETE",
  });
}

async function loadTodos() {
  let response = await fetch("/api/todos");
  let todos = await response.json();
  todos.forEach(appendTodoToList);
}

loadTodos();
