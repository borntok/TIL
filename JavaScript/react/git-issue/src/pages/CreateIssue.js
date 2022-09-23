import styles from "./CreateIssue.module.css"
import cx from "clsx"

import { useRef } from "react"
import Button from "../components/Button"

export default function CreateIssue() {
  const ref = useRef()

  function handleSubmit(e) {
    e.preventDefault()
    if (e.target.elements.title.value === "") {
      alert("타이틀을 입력해주세요")
      ref.current.focus()
    }
  }
  return (
    <div className={styles.container}>
      <div className={styles.avatar}></div>
      <div className={cx(styles.inputWrapper, styles.border)}>
        <form onSubmit={handleSubmit}>
          <input
            name="title"
            ref={ref}
            className={cx(styles.input, styles.border)}
            placeholder="Title"
          ></input>
          <textarea
            name="body"
            className={cx(styles.input, styles.textarea, styles.border)}
            placeholder="Leave a comment"
          ></textarea>
          <div className={styles.buttonWrapper}>
            <Button
              type="submit"
              style={{
                fontSize: "14px",
                backgroundColor: "green",
                color: "white",
              }}
            >
              Submit new issue
            </Button>
          </div>
        </form>
      </div>
    </div>
  )
}
