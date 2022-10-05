import "./App.css";
import Divider from "./Divider/Divider";
import TodoHeader from "./Header/TodoHeader";
import TodoInput from "./Input/TodoInput";
import TodoList from "./List/TodoList";
import TodoListTools from "./Tools/TodoListTools";

function App() {
  return (
    <main className="App">
      <TodoHeader />
      <TodoInput />
      <TodoListTools />
      <Divider />
      <TodoList />
    </main>
  );
}

export default App;
