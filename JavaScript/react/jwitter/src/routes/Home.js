import React, { useState } from "react";
import { collection, addDoc } from "firebase/firestore";
import { dbService } from "fbase";

export default function Home() {
  const [jweet, setJweet] = useState("");

  const onSubmit = async (event) => {
    event.preventDefault();
    await addDoc(collection(dbService, "jweets"), {
      jweet,
      createAt: Date.now(),
    });
    setJweet("");
  };

  const onChange = (event) => {
    const {
      target: { value },
    } = event;
    setJweet(value);
  };

  return (
    <div>
      <form onSubmit={onSubmit}>
        <input
          value={jweet}
          onChange={onChange}
          type="text"
          placeholder="What's on your mind?"
          maxLength={120}
        />
        <input type="submit" value="Jweet" />
      </form>
    </div>
  );
}
