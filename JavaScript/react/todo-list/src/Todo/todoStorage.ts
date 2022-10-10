import { TodoType } from "./todoReducer";

export function saveTodos(todos: TodoType[]) {
  localStorage.setItem("todos", JSON.stringify(todos));
}

export function loadTodos() {
  const todoJson = localStorage.getItem("todos");

  if (!todoJson) {
    return [];
  }

  try {
    return JSON.parse(todoJson);
  } catch (e) {
    console.error(e);
    return [];
  }
}
