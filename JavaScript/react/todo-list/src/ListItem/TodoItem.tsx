import styles from "./TodoItem.module.css";
import { BsCheckCircle } from "react-icons/bs";
import { IoIosRemoveCircleOutline } from "react-icons/io";

interface TodoItemProps {
  id: number;
  text: string;
  isChecked: boolean;
  onToggleClick: (id: number) => void;
  onRemoveClick: (id: number) => void;
}

export default function TodoItem(props: TodoItemProps) {
  function handleToggleClick() {
    props.onToggleClick(props.id);
  }

  function handleRemoveClick() {
    props.onRemoveClick(props.id);
  }

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
        onClick={handleToggleClick}
      />
      <span className={props.isChecked ? styles.lineThrow : ""}>
        {props.text}
      </span>
      <IoIosRemoveCircleOutline
        className={styles.removeIcon}
        onClick={handleRemoveClick}
      />
    </li>
  );
}
