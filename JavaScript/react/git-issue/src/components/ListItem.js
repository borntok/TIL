import styles from "./ListItem.module.css"
import dayjs from "dayjs"

import ListItemLayout from "./ListItemLayout"
import Badge from "./Badge"

var relativeTime = require("dayjs/plugin/relativeTime")
dayjs.extend(relativeTime)

export default function ListItem({
  checked,
  onClickCheckBox,
  onClickTitle,
  data,
}) {
  const badges = data.labels
  const state = data.state === "open" ? "opened" : "closed"
  const date = data.state === "open" ? data.created_at : data.closed_at

  return (
    <ListItemLayout checked={checked} onClick={onClickCheckBox}>
      <div>
        <div role="button" onClick={onClickTitle} className={styles.title}>
          {data.title}
          {badges.length > 0 &&
            badges.map((props, idx) => <Badge key={`${idx}`} {...props} />)}
        </div>
        <div className={styles.description}>
          #{data.number} {state} {dayjs().to(dayjs(date))} by {data.user.login}
        </div>
      </div>
    </ListItemLayout>
  )
}
