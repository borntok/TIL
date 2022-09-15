import styles from "./ListItem.module.css"
import ListItemLayout from "./ListItemLayout"

export default function ListItem({ checked, onChangeCheckBox, onClickTitle }) {
  return (
    <ListItemLayout>
      <div>
        <div role="button" onClick={onClickTitle} className={styles.title}>
          Issue Example
        </div>
        <div className={styles.description}># Description</div>
      </div>
    </ListItemLayout>
  )
}
