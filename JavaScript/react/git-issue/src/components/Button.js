import styles from "./Button.module.css"

export default function Button({ style, children, type = "button", disabled }) {
  return (
    <button
      className={styles.button}
      style={style}
      type={type}
      disabled={disabled}
    >
      {children}
    </button>
  )
}
