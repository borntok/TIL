import styles from "./TextField.module.css"
import cx from "clsx"
import { forwardRef } from "react"

export default forwardRef(function TextField(
  { type = "input", name, placeholder },
  ref,
) {
  return type === "input" ? (
    <input
      name={name}
      ref={ref}
      className={cx(styles.input, styles.border)}
      placeholder={placeholder}
    ></input>
  ) : (
    <textarea
      name={name}
      ref={ref}
      className={cx(styles.input, styles.textarea, styles.border)}
      placeholder={placeholder}
    ></textarea>
  )
})
