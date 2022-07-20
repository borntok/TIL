import React, { useEffect, useState } from "react";
import { collection, onSnapshot } from "firebase/firestore";
import { dbService } from "fbase";
import Jweet from "components/Jweet";
import JweetFactory from "components/JweetFactory";

export default function Home(props) {
  const [jweets, setJweets] = useState([]);

  useEffect(() => {
    onSnapshot(collection(dbService, "jweets"), (snapshot) => {
      const jweetArray = snapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }));
      setJweets(jweetArray);
    });
  }, []);

  return (
    <div>
      <JweetFactory userObj={props.userObj} />
      <div>
        {jweets.map((jweet) => (
          <Jweet
            key={jweet.id}
            jweetObj={jweet}
            isOwner={jweet.creatorId === props.userObj.uid}
          />
        ))}
      </div>
    </div>
  );
}
