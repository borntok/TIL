import React, { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { authService, dbService } from "fbase";
import { collection, getDocs, orderBy, query, where } from "firebase/firestore";

export default function Profile(props) {
  const navigate = useNavigate();
  const onLogOutClick = () => {
    authService.signOut();
    navigate("/", { replace: true });
  };

  const getMyJweets = async () => {
    const jweets = await getDocs(
      query(
        collection(dbService, "jweets"),
        where("creatorId", "==", props.userObj.uid),
        orderBy("createAt")
      )
    );
    console.log(jweets.docs.map((doc) => doc.data()));
  };

  useEffect(() => {
    getMyJweets();
  });

  return (
    <>
      <button onClick={onLogOutClick}>Log Out</button>
    </>
  );
}
