import { BrowserRouter, Routes, Route } from "react-router-dom";
import MainPage from "./blog/MainPage";
import TechPage from "./blog/TechPage";
import BlogPage from "./blog/BlogPage";
import JavascriptPage from "./blog/JavascriptPage";
import ReactPage from "./blog/ReactPage";
import ReactDocPage from "./blog/ReactDocPage";

function App() {
  // root url : main page component
  // tech url : tech page component
  // blog url : blog page component

  return (
    <BrowserRouter>
      <Routes>
        <Route path={"/"} element={<MainPage />} />
        <Route path={"tech"} element={<TechPage />}>
          <Route path={"javascript"} element={<JavascriptPage />} />
          <Route path={"react"} element={<ReactPage />} />
          <Route path={"react/:docId"} element={<ReactDocPage />} />
        </Route>
        <Route path={"blog"} element={<BlogPage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
