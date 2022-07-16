import React from "react";
import { Link } from "react-router-dom";

export default function Navigation(props) {
  return (
    <nav>
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/profile">{props.userObj.displayName}'s profile</Link>
        </li>
      </ul>
    </nav>
  );
}
