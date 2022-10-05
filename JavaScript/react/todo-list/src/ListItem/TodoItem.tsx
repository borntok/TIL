import styles from "./TodoItem.module.css";
import { BsCheckCircle } from "react-icons/bs";
import { IoIosRemoveCircleOutline } from "react-icons/io";

interface TodoItemProps {
  todo: string;
}

export default function TodoItem(props: TodoItemProps) {
  const isCheck = false;

  return (
    <li className={styles.container}>
      <BsCheckCircle
        className={[
          styles.checkIcon,
          `${isCheck ? styles.checkedCircleIcon : styles.unCheckedCircleIcon}`,
        ].join(" ")}
      />
      <span>{props.todo}</span>
      <IoIosRemoveCircleOutline className={styles.removeIcon} />
    </li>
  );
}
