import styles from "./Badge.module.css"
import cx from "clsx"

export default function Badge({ title, color }) {
  return <span className={cx(styles.badge, styles[color])}>{title}</span>
}
