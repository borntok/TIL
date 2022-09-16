import styles from "./Badge.module.css"

export default function Badge({ color, name }) {
  return (
    <span className={styles.badge} style={{ background: `#${color}` }}>
      {name}
    </span>
  )
}
