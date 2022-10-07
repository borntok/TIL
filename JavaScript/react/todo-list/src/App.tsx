import { useState } from "react";
import "./App.css";

import Divider from "./Divider/Divider";
import TodoHeader from "./Header/TodoHeader";
import TodoInput from "./Input/TodoInput";
import TodoList from "./List/TodoList";
import TodoListArea from "./List/TodoListArea";
import TodoListTools from "./Tools/TodoListTools";

export type TodoType = {
  id: number;
  text: string;
  isChecked: boolean;
};

function App() {
  const [text, setText] = useState("");
  const [todos, setTodos] = useState<TodoType[]>([]);

  function handleTextChange(text: string) {
    setText(text);
  }

  function handleSubmit() {
    const newTodos = todos.concat({
      id: Date.now(),
      text: text,
      isChecked: false,
    });

    setTodos(newTodos);
    setText("");
  }

  function handleToggle(id: number) {
    const newTodos = todos.map((todo) => {
      if (todo.id === id) {
        return { ...todo, isChecked: !todo.isChecked };
      }

      return todo;
    });

    setTodos(newTodos);
  }

  function handleRemove(id: number) {
    const newTodos = todos.filter((todo) => {
      return todo.id !== id;
    });

    setTodos(newTodos);
  }

  function isTodoAllChecked() {
    return todos.every((todo) => todo.isChecked);
  }

  function handleToggleAllClick() {
    const isAllChecked = isTodoAllChecked();

    const newTodos = todos.map((todo) => {
      return {
        ...todo,
        isChecked: !isAllChecked,
      };
    });

    setTodos(newTodos);
  }

  function handleRemoveAllClick() {
    setTodos([]);
  }

  return (
    <main className="App">
      <TodoHeader count={todos.filter((todo) => !todo.isChecked).length} />
      <TodoInput
        text={text}
        onTextChange={handleTextChange}
        onSubmit={handleSubmit}
      />
      <TodoListArea todoCount={todos.length}>
        <TodoListTools
          isAllChecked={isTodoAllChecked()}
          onToggleAllClick={handleToggleAllClick}
          onRemoveAllClick={handleRemoveAllClick}
        />
        <Divider />
        <TodoList
          todos={todos}
          onToggleClick={handleToggle}
          onRemoveClick={handleRemove}
        />
      </TodoListArea>
    </main>
  );
}

export default App;
