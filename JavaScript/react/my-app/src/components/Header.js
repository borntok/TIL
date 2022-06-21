import React from "react";
import logo from "../logo.svg";

const Header = () => {
  // const getGreetingMessage = (name) => {
  //   if (name === "riri") return `Hello, ${name}! Learn React`;
  //   return `Welcome, ${name}! Learn React `;
  // };

  const name = "riri";
  const count = 0;
  const memo = "";

  return (
    <header className="App-header">
      <img src={logo} className="App-logo" alt="logo" />
      <p>
        Edit <code>src/App.js</code> and save to reload.
      </p>
      <a
        className="App-link"
        href="https://reactjs.org"
        target="_blank"
        rel="noopener noreferrer"
      >
        {name === "riri"
          ? `Hello, ${name}! Learn React`
          : `Welcom, ${name}! Learn React`}

        <div>{name === "riri" && `Hello, ${name}! Learn React`}</div>

        <div>{!!count && <h1>Messages: {count}</h1>}</div>
      </a>
      {memo !== null && `메모: ${memo}`}
    </header>
  );
};

export default Header;
