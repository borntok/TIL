import { type } from "@testing-library/user-event/dist/type";
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

  return (
    <main className="App">
      <TodoHeader />
      <TodoInput
        text={text}
        onTextChange={handleTextChange}
        onSubmit={handleSubmit}
      />
      <TodoListArea todoCount={todos.length}>
        <TodoListTools />
        <Divider />
        <TodoList todos={todos} />
      </TodoListArea>
    </main>
  );
}

export default App;
