import React, { useEffect, useState } from "react";
import AppRouter from "components/Router";
import { authService } from "fbase";
import {
  onAuthStateChanged,
  updateCurrentUser,
  updateProfile,
} from "firebase/auth";

function App() {
  const [init, setInit] = useState(false);
  const [userObj, setUserObj] = useState(null);

  useEffect(() => {
    onAuthStateChanged(authService, (user) => {
      if (user) {
        if (user.displayName === null) {
          const ind = user.email.indexOf("@");
          const end = user.email.substring(0, ind);
          updateProfile(user, {
            displayName: end,
          });
        }
        setUserObj({
          displayName: user.displayName,
          uid: user.uid,
          updateProfile: (args) => updateProfile(user, args),
        });
      } else {
        setUserObj(null);
      }
      setInit(true);
    });
  }, []);

  const refreshUser = () => {
    const user = authService.currentUser;
    setUserObj({ ...user });
  };

  return (
    <>
      {init ? (
        <AppRouter
          refreshUser={refreshUser}
          isLoggedIn={Boolean(userObj)}
          userObj={userObj}
        />
      ) : (
        "Initializing..."
      )}
      <footer>&copy; {new Date().getFullYear()} Jwitter</footer>
    </>
  );
}

export default App;
