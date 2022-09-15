import styles from "./ListItemLayout.module.css"
import cx from "clsx"

export default function ListItemLayout({ children, className }) {
  return (
    <div className={cx(styles.wrapper, className)}>
      <input
        type="checkbox"
        className={styles.checkbox}
        // value={checked}
        // onChange={onChangeCheckBox}
      />
      {children}
    </div>
  )
}
