import styles from "./Header.module.css"

import Button from "./components/Button"
import Space from "./components/Space"

export default function Header() {
  return (
    <div className={styles.header}>
      <Button
        style={{
          fontSize: "14px",
          backgroundColor: "transparent",
          color: "black",
        }}
      >
        Watch <div className={styles.circle}>5</div>
      </Button>
      <Space />
      <Button
        style={{
          fontSize: "14px",
          backgroundColor: "transparent",
          color: "black",
        }}
      >
        Fork
      </Button>
      <Space />
      <Button
        style={{
          fontSize: "14px",
          backgroundColor: "transparent",
          color: "black",
        }}
      >
        Star
      </Button>
    </div>
  )
}
