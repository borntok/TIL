import "./styles.css";
import React, { useState } from "react";

export default function Parent() {
  const [number, setNumber] = useState(1);
  const age = 1;

  return (
    <div className="App">
      <button
        onClick={() => {
          setNumber(number + 1);
        }}
      >
        Click
      </button>
      <Child age={age} />
    </div>
  );
}

const Child = React.memo((props) => {
  console.log("Child component");
  console.log(props.age);
  return <div>Child</div>;
});
