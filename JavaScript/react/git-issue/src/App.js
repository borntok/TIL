import styles from "./App.module.css"

import Button from "./components/Button"
import Header from "./Header"

function App() {
  return (
    <>
      <div className={styles.nav}>Nav</div>
      <Header />
      <div className={styles.listContainer}>
        <Button
          style={{ fontSize: "14px", backgroundColor: "green", color: "white" }}
        >
          New Issue
        </Button>
      </div>
      <div className={styles.footer}>Footer</div>
    </>
  )
}

export default App
