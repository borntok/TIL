import "./App.css";
import Header from "./components/Header";
import Welcome from "./components/Welcom";

function App() {
  const info = {
    firstName: "riri ",
    lastName: "bad gyal",
    withImg: true,
  };

  return (
    <div className="App">
      <Header title={"Learn React"} />
      <Welcome {...info} />
    </div>
  );
}

export default App;
