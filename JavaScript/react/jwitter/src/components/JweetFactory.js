import React from "react";
import { v4 as uuidv4 } from "uuid";
import { collection, addDoc } from "firebase/firestore";
import { storageService, dbService } from "fbase";
import { useState } from "react";
import { ref, uploadString, getDownloadURL } from "firebase/storage";

export default function JweetFactory(props) {
  const [jweet, setJweet] = useState("");
  const [attachment, setAttachment] = useState("");

  const onSubmit = async (event) => {
    event.preventDefault();
    let attachmentUrl = "";
    if (attachment !== "") {
      const attachmentRef = ref(
        storageService,
        `${props.userObj.uid}/${uuidv4()}`
      );
      const response = await uploadString(
        attachmentRef,
        attachment,
        "data_url"
      );
      attachmentUrl = await getDownloadURL(response.ref);
    }
    const jweetObj = {
      text: jweet,
      createAt: Date.now(),
      creatorId: props.userObj.uid,
      attachmentUrl,
    };
    await addDoc(collection(dbService, "jweets"), jweetObj);
    setJweet("");
    setAttachment("");
  };

  const onChange = (event) => {
    const {
      target: { value },
    } = event;
    setJweet(value);
  };

  const onFileChange = (event) => {
    const {
      target: { files },
    } = event;
    const theFile = files[0];
    const reader = new FileReader();
    reader.onloadend = (finishedEvent) => {
      const {
        currentTarget: { result },
      } = finishedEvent;
      setAttachment(result);
    };
    reader.readAsDataURL(theFile);
  };

  const onClearAttachment = () => setAttachment(null);

  return (
    <form onSubmit={onSubmit}>
      <input
        value={jweet}
        onChange={onChange}
        type="text"
        placeholder="What's on your mind?"
        maxLength={120}
      />
      <input type={"file"} accept="image/*" onChange={onFileChange} />
      <input type="submit" value="Jweet" />
      {attachment && (
        <div>
          <img src={attachment} width="50px" height="50px" alt="preview" />
          <button onClick={onClearAttachment}>Clear</button>
        </div>
      )}
    </form>
  );
}
