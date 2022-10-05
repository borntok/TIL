import "./App.css";
import TodoHeader from "./Header/TodoHeader";
import TodoInput from "./Input/TodoInput";
import TodoListTools from "./Tools/TodoListTools";

function App() {
  return (
    <main className="App">
      <TodoHeader />
      <TodoInput />
      <TodoListTools />
    </main>
  );
}

export default App;
