import { Route, Routes } from "react-router-dom"

import Nav from "./components/Nav"
import Header from "./Header"
import Issue from "./pages/Issue"
import Code from "./pages/Code"
import CreateIssue from "./pages/CreateIssue"
import PullRequest from "./pages/PullRequest"
import Actions from "./pages/Actions"
import Projects from "./pages/Projects"
import Security from "./pages/Security"

function App() {
  return (
    <>
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
    </>
  )
}

export default App
