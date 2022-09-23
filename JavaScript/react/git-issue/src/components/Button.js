import styles from "./Button.module.css"

export default function Button({ style, children, type = "button" }) {
  return (
    <button className={styles.button} style={style} type={type}>
      {children}
    </button>
  )
}
