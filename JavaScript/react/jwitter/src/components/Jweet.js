import { dbService, storageService } from "fbase";
import { deleteDoc, doc, updateDoc } from "firebase/firestore";
import { deleteObject, ref } from "firebase/storage";
import React, { useState } from "react";

export default function Jweet({ jweetObj, isOwner }) {
  const [editing, setEditing] = useState(false);
  const [newJweet, setNewJweet] = useState(jweetObj.text);

  const onDeleteClick = async () => {
    const ok = window.confirm("Are you sure you want to delete this jweet?");
    if (ok) {
      await deleteDoc(doc(dbService, "jweets", jweetObj.id));
      await deleteObject(ref(storageService, jweetObj.attachmentUrl));
    }
  };

  const toggleEditing = () => setEditing((prev) => !prev);

  const onChange = (event) => {
    const {
      target: { value },
    } = event;
    setNewJweet(value);
  };

  const onSubmit = (event) => {
    event.preventDefault();
    updateDoc(doc(dbService, "jweets", jweetObj.id), { text: newJweet });
    setEditing(false);
  };

  return (
    <div>
      {editing ? (
        <>
          <form onSubmit={onSubmit}>
            <input
              type={"text"}
              placeholder="Edit your Jweet"
              value={newJweet}
              required
              onChange={onChange}
            />
            <input type={"submit"} value="Update Nweet" />
          </form>
          <button onClick={toggleEditing}>Cancel</button>
        </>
      ) : (
        <>
          <h4>{jweetObj.text}</h4>
          {jweetObj.attachmentUrl && (
            <img
              src={jweetObj.attachmentUrl}
              width="50px"
              height="50px"
              alt="img"
            />
          )}
          {isOwner && (
            <>
              <button onClick={onDeleteClick}>Delete Jweet</button>
              <button onClick={toggleEditing}>Edit Jweet</button>
            </>
          )}
        </>
      )}
    </div>
  );
}
