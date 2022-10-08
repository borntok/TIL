import styles from "./TodoItem.module.css";
import { BsCheckCircle } from "react-icons/bs";
import { IoIosRemoveCircleOutline } from "react-icons/io";
import { useTodoDispatch } from "../Todo/TodoProvider";

interface TodoItemProps {
  id: number;
  text: string;
  isChecked: boolean;
}

export default function TodoItem(props: TodoItemProps) {
  const todoDispatch = useTodoDispatch();

  function handleToggleClick() {
    todoDispatch({
      type: "checked",
      payload: {
        id: props.id,
      },
    });
  }

  function handleRemoveClick() {
    todoDispatch({
      type: "remove",
      payload: {
        id: props.id,
      },
    });
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
