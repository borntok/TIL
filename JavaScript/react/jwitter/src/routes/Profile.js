import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { authService, dbService } from "fbase";
import { collection, getDocs, orderBy, query, where } from "firebase/firestore";
import { updateProfile } from "firebase/auth";

export default function Profile(props) {
  const navigate = useNavigate();
  const [newDisplayName, setNewDisplayName] = useState(
    props.userObj.displayName
  );

  const onLogOutClick = () => {
    authService.signOut();
    navigate("/", { replace: true });
  };

  const getMyJweets = async () => {
    const jweets = await getDocs(
      query(
        collection(dbService, "jweets"),
        where("creatorId", "==", props.userObj.uid),
        orderBy("createAt", "desc")
      )
    );
    console.log(jweets.docs.map((doc) => doc.data()));
  };

  useEffect(() => {
    getMyJweets();
  });

  const onChange = (event) => {
    const {
      target: { value },
    } = event;
    setNewDisplayName(value);
  };

  const onSubmit = async (event) => {
    event.preventDefault();
    if (props.userObj.displayName !== newDisplayName) {
      await updateProfile(authService.currentUser, {
        displayName: newDisplayName,
      });
    }
    props.refreshUser();
  };

  return (
    <>
      <form onSubmit={onSubmit}>
        <input
          onChange={onChange}
          type="text"
          placeholder="Display Name"
          value={newDisplayName}
        />
        <input type="submit" value="Update Profile" />
      </form>
      <button onClick={onLogOutClick}>Log Out</button>
    </>
  );
}
