import React, { useEffect, useState } from "react";
import { collection, addDoc, getDocs } from "firebase/firestore";
import { dbService } from "fbase";

export default function Home() {
  const [jweet, setJweet] = useState("");
  const [jweets, setJweets] = useState([]);

  const getJweets = async () => {
    const dbNweets = await getDocs(collection(dbService, "jweets"));
    dbNweets.forEach((document) => {
      const jweetObject = {
        ...document.data(),
        id: document.id,
      };
      setJweets((prev) => [jweetObject, ...prev]);
    });
  };

  useEffect(() => {
    getJweets();
  }, []);

  const onSubmit = async (event) => {
    event.preventDefault();
    await addDoc(collection(dbService, "jweets"), {
      createAt: Date.now(),
      jweet,
    });
    setJweet("");
  };

  const onChange = (event) => {
    const {
      target: { value },
    } = event;
    setJweet(value);
  };

  console.log(jweets);

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
      <div>
        {jweets.map((jweet) => (
          <div key={jweet.id}>
            <h4>{jweet.jweet}</h4>
          </div>
        ))}
      </div>
    </div>
  );
}
