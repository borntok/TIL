import styles from "./CreateIssue.module.css"
import cx from "clsx"

import Button from "../components/Button"

export default function CreateIssue() {
  return (
    <div className={styles.container}>
      <div className={styles.avatar}></div>
      <div className={cx(styles.inputWrapper, styles.border)}>
        <input
          className={cx(styles.input, styles.border)}
          placeholder="Title"
        ></input>
        <textarea
          className={cx(styles.input, styles.textarea, styles.border)}
          placeholder="Leave a comment"
        ></textarea>
        <div className={styles.buttonWrapper}>
          <Button
            style={{
              fontSize: "14px",
              backgroundColor: "green",
              color: "white",
            }}
          >
            Submit new issue
          </Button>
        </div>
      </div>
    </div>
  )
}
