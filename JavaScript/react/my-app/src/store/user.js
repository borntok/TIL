import React, { createContext, useState } from "react";

export const UserContext = createContext();

export default function UserStore(props) {
  const [job, setJob] = useState("FE-developer");

  const user = {
    name: "riri",
    job,
    changeJob: (updateJob) => setJob(updateJob),
  };

  return (
    <UserContext.Provider value={user}>{props.children}</UserContext.Provider>
  );
}
