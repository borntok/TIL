import styles from "./App.module.css"
import React from "react"

function App() {
  return (
    <>
      <div className={styles.nav}>Nav</div>
      <div className={styles.header}>Header</div>
      <div className={styles.listContainer}>ListContainer</div>
      <div className={styles.footer}>Footer</div>
    </>
  )
}

export default App
