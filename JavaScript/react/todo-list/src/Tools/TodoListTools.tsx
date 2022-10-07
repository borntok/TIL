import styles from "./TodoListTools.module.css";
import { IoCheckmarkDoneCircleOutline } from "react-icons/io5";
import { MdDelete } from "react-icons/md";
import { CgRadioCheck } from "react-icons/cg";

interface TodoListToolsProps {
  isAllChecked: boolean;
  onToggleAllClick: () => void;
  onRemoveAllClick: () => void;
}

export default function TodoListTools(props: TodoListToolsProps) {
  function handleToggleAllClick() {
    props.onToggleAllClick();
  }

  function handleRemoveAllClick() {
    props.onRemoveAllClick();
  }

  return (
    <section className={styles.container}>
      <button className={styles.button} onClick={handleToggleAllClick}>
        {props.isAllChecked ? (
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
