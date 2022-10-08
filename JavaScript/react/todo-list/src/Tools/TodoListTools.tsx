import styles from "./TodoListTools.module.css";
import { IoCheckmarkDoneCircleOutline } from "react-icons/io5";
import { MdDelete } from "react-icons/md";
import { CgRadioCheck } from "react-icons/cg";
import { useTodoDispatch, useTodoState } from "../Todo/TodoProvider";

export default function TodoListTools() {
  const todoState = useTodoState();
  const todoDispatch = useTodoDispatch();

  function isTodoAllChecked() {
    return todoState.todos.every((todo) => todo.isChecked);
  }

  function handleToggleAllClick() {
    todoDispatch({
      type: "allChecked",
      payload: !isTodoAllChecked(),
    });
  }

  function handleRemoveAllClick() {
    todoDispatch({
      type: "allRemove",
    });
  }

  return (
    <section className={styles.container}>
      <button className={styles.button} onClick={handleToggleAllClick}>
        {isTodoAllChecked() ? (
          <>
            <CgRadioCheck className={styles.icon} />
            전체해제
          </>
        ) : (
          <>
            <IoCheckmarkDoneCircleOutline className={styles.icon} />
            전체완료
          </>
        )}
      </button>
      <button className={styles.button} onClick={handleRemoveAllClick}>
        <MdDelete className={styles.icon} />
        전체삭제
      </button>
    </section>
  );
}
