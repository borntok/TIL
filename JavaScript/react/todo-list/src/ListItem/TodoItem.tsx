import styles from "./TodoItem.module.css";
import { BsCheckCircle } from "react-icons/bs";
import { IoIosRemoveCircleOutline } from "react-icons/io";

interface TodoItemProps {
  text: string;
  isChecked: boolean;
}

export default function TodoItem(props: TodoItemProps) {
  return (
    <li className={styles.container}>
      <BsCheckCircle
        className={[
          styles.checkIcon,
          `${
            props.isChecked
              ? styles.checkedCircleIcon
              : styles.unCheckedCircleIcon
          }`,
        ].join(" ")}
      />
      <span>{props.text}</span>
      <IoIosRemoveCircleOutline className={styles.removeIcon} />
    </li>
  );
}
