import styles from "./App.module.css"
import axios from "axios"

import Header from "./Header"
import ListContainer from "./ListContainer"
import Footer from "./Footer"

function App() {
  async function getData() {
    const data = await axios.get(
      `https://api.github.com/repos/facebook/react/issues`,
    )
    console.log({ data })
  }

  getData()

  return (
    <>
      <div className={styles.nav}>Nav</div>
      <Header />
      <ListContainer />
      <Footer />
    </>
  )
}

export default App
