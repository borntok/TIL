import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Auth from "../routes/Auth";
import Home from "../routes/Home";

export default function AppRouter(props) {
  return (
    <BrowserRouter>
      <Routes>
        {props.isLoggedIn ? (
          <>
            <Route path={"/"} element={<Home />} />
          </>
        ) : (
          <Route path={"/"} element={<Auth />} />
        )}
      </Routes>
    </BrowserRouter>
  );
}
