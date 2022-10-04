import { useEffect, useState } from "react"
import { Route, Routes } from "react-router-dom"

import axios from "axios"

import Nav from "./components/Nav"
import Header from "./Header"
import Issue from "./pages/Issue"
import Code from "./pages/Code"
import CreateIssue from "./pages/CreateIssue"
import PullRequest from "./pages/PullRequest"
import Actions from "./pages/Actions"
import Projects from "./pages/Projects"
import Security from "./pages/Security"
import { GITHUB_API } from "./api"
import { UserContext } from "./context/UserContext"

function App() {
  const [user, setUser] = useState()

  useEffect(() => {
    getUserInfo()
  }, [])

  async function getUserInfo() {
    const data = await axios.get(`${GITHUB_API}/user`, {
      headers: {
        Authorization: process.env.REACT_APP_GITHUB_TOKEN,
        "Content-Type": "application/json",
      },
    })

    setUser(data.data)
  }

  console.log(user)

  return (
    <UserContext.Provider value={{ user }}>
      <Nav />
      <Header />
      <Routes>
        <Route path="/" element={<Issue />} />
        <Route path="/code" element={<Code />} />
        <Route path="/issue" element={<Issue />} />
        <Route path="/new" element={<CreateIssue />} />
        <Route path="/pulls" element={<PullRequest />} />
        <Route path="/actions" element={<Actions />} />
        <Route path="/projects" element={<Projects />} />
        <Route path="/security" element={<Security />} />
      </Routes>
    </UserContext.Provider>
  )
}

export default App
