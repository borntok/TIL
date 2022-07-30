import React, { useState, useCallback } from "react";
import Info from "./components/Info";
import "./styles.css";

const App = () => {
  const [color, setColor] = useState("");
  const [movie, setMovie] = useState("");

  const onChangeHandler = useCallback((e) => {
    if (e.target.id === "color") setColor(e.target.value);
    else setMovie(e.target.value);
  }, []);

  return (
    <div className="App">
      <div>
        <label>
          <div>What is your favorite color of rainbow ?</div>
          <input id="color" value={color} onChange={onChangeHandler} />
        </label>
      </div>
      <div>
        <div>What is your favorite movie among these ?</div>
        <label>
          <input
            type="radio"
            name="movie"
            value="Marriage Story"
            onChange={onChangeHandler}
          />
          Marriage Story
        </label>
        <label>
          <input
            type="radio"
            name="movie"
            value="The Fast And The Furious"
            onChange={onChangeHandler}
          />
          The Fast And The Furious
        </label>
        <label>
          <input
            type="radio"
            name="movie"
            value="Avengers"
            onChange={onChangeHandler}
          />
          Avengers
        </label>
      </div>
      <Info color={color} movie={movie} />
    </div>
  );
};

export default App;
