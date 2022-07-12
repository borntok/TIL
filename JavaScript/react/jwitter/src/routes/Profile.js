import React from "react";
import { useNavigate } from "react-router-dom";
import { authService } from "fbase";

export default function Profile() {
  const navigate = useNavigate();
  const onLogOutClick = () => {
    authService.signOut();
    navigate("/");
  };
  return (
    <>
      <button onClick={onLogOutClick}>Log Out</button>
    </>
  );
}
