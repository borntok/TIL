import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Auth from "routes/Auth";
import Home from "routes/Home";
import Profile from "routes/Profile";
import Navigation from "components/Navigation";

export default function AppRouter(props) {
  return (
    <BrowserRouter>
      {props.isLoggedIn && <Navigation userObj={props.userObj} />}
      <Routes>
        {props.isLoggedIn ? (
          <>
            <Route path={"/"} element={<Home userObj={props.userObj} />} />
            <Route
              path={"/profile"}
              element={
                <Profile
                  userObj={props.userObj}
                  refreshUser={props.refreshUser}
                />
              }
            />
          </>
        ) : (
          <>
            <Route path={"/"} element={<Auth />} />
          </>
        )}
      </Routes>
    </BrowserRouter>
  );
}
