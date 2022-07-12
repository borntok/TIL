import React from "react";
import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import Auth from "routes/Auth";
import Home from "routes/Home";
import Profile from "routes/Profile";
import Navigation from "components/Navigation";

export default function AppRouter(props) {
  return (
    <BrowserRouter>
      {props.isLoggedIn && <Navigation />}
      <Routes>
        {props.isLoggedIn ? (
          <>
            <Route path={"/"} element={<Home />} />
            <Route path={"/profile"} element={<Profile />} />
          </>
        ) : (
          <>
            <Route path={"/"} element={<Auth />} />
            <Route path={"*"} element={<Navigate to="/" />} />
          </>
        )}
      </Routes>
    </BrowserRouter>
  );
}
