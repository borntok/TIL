import styles from "./App.module.css"

import Header from "./Header"
import ListContainer from "./ListContainer"

function App() {
  return (
    <>
      <div className={styles.nav}>Nav</div>
      <Header />
      <ListContainer />
      <div className={styles.footer}>Footer</div>
    </>
  )
}

export default App
