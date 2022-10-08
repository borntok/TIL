import { useReducer } from "react";
import "./App.css";

import Divider from "./Divider/Divider";
import TodoHeader from "./Header/TodoHeader";
import TodoInput from "./Input/TodoInput";
import TodoList from "./List/TodoList";
import TodoListArea from "./List/TodoListArea";
import { todoInputReducer } from "./Todo/todoInputReducer";
import { todoReducer } from "./Todo/todoReducer";
import TodoListTools from "./Tools/TodoListTools";

function App() {
  const [inputState, inputDispatch] = useReducer(todoInputReducer, {
    text: "",
  });
  const [todoState, todoDispatch] = useReducer(todoReducer, { todos: [] });

  function handleTextChange(text: string) {
    inputDispatch({
      type: "change",
      payload: text,
    });
  }

  function handleSubmit() {
    if (!inputState.text) return;

    todoDispatch({
      type: "add",
      payload: {
        text: inputState.text,
      },
    });

    inputDispatch({
      type: "clear",
    });
  }

  function handleToggle(id: number) {
    todoDispatch({
      type: "checked",
      payload: {
        id: id,
      },
    });
  }

  function handleRemove(id: number) {
    todoDispatch({
      type: "remove",
      payload: {
        id: id,
      },
    });
  }

  function isTodoAllChecked() {
    return todoState.todos.every((todo) => todo.isChecked);
  }

  function handleToggleAllClick() {
    const isAllChecked = isTodoAllChecked();

    todoDispatch({
      type: "allChecked",
      payload: !isAllChecked,
    });
  }

  function handleRemoveAllClick() {
    todoDispatch({
      type: "allRemove",
    });
  }

  return (
    <main className="App">
      <TodoHeader
        count={todoState.todos.filter((todo) => !todo.isChecked).length}
      />
      <TodoInput
        text={inputState.text}
        onTextChange={handleTextChange}
        onSubmit={handleSubmit}
      />
      <TodoListArea todoCount={todoState.todos.length}>
        <TodoListTools
          isAllChecked={isTodoAllChecked()}
          onToggleAllClick={handleToggleAllClick}
          onRemoveAllClick={handleRemoveAllClick}
        />
        <Divider />
        <TodoList
          todos={todoState.todos}
          onToggleClick={handleToggle}
          onRemoveClick={handleRemove}
        />
      </TodoListArea>
    </main>
  );
}

export default App;
