import React from "react";
import dog from "../images/riri.jpg";

export default function Welcome({ withImg, firstName, lastName }) {
  return (
    // image + Hello, firstName, lastName
    <>
      {withImg && <img src={dog} alt="welcomDog" height={200} />}
      <div>Hello!</div>
      <div>
        <span>{firstName}</span>
        {lastName}
      </div>
    </>
  );
}
