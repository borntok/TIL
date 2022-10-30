import styles from "./ListItem.module.css";
import dayjs from "dayjs";

import ListItemLayout from "./ListItemLayout";
import Badge from "./Badge";
import { ListItems } from "../model/issues";

var relativeTime = require("dayjs/plugin/relativeTime");
dayjs.extend(relativeTime);

interface ListItemProps {
  checked: boolean;
  onClickTitle?: (e: React.MouseEvent<HTMLDivElement, MouseEvent>) => void;
  data: ListItems;
  onClickCheckBox: (e: React.ChangeEvent<HTMLInputElement>) => void;
}

export default function ListItem({
  checked,
  onClickCheckBox,
  onClickTitle,
  data,
}: ListItemProps) {
  const badges = data.labels;
  const state = data.state === "open" ? "opened" : "closed";
  const date = data.state === "open" ? data.created_at : data.closed_at;

  return (
    <ListItemLayout checked={checked} onClick={onClickCheckBox}>
      <div>
        <div role="button" onClick={onClickTitle} className={styles.title}>
          {data.title}
          {badges.length > 0 &&
            badges.map((props) => <Badge key={`${props.name}`} {...props} />)}
        </div>
        <div className={styles.description}>
          #{data.number} {state} {dayjs().to(dayjs(date))} by {data.user.login}
        </div>
      </div>
    </ListItemLayout>
  );
}
