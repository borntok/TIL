import React, { useContext } from "react";
import { UserContext } from "../store/user";

export default function BlogPage() {
  const { dispatch } = useContext(UserContext);
  console.log(dispatch);

  return (
    <div>
      <h1>BlogPage</h1>
      <button
        onClick={() => dispatch({ type: "changeJob", text: "BE-developer" })}
      >
        change Job
      </button>
    </div>
  );
}
