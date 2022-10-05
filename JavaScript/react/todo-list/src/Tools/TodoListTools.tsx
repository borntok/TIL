import styles from "./TodoListTools.module.css";
import { IoCheckmarkDoneCircleOutline } from "react-icons/io5";
import { MdDelete } from "react-icons/md";

export default function TodoListTools() {
  return (
    <section className={styles.container}>
      <button className={styles.button}>
        <IoCheckmarkDoneCircleOutline className={styles.icon} />
        전체완료
      </button>
      <button className={styles.button}>
        <MdDelete className={styles.icon} />
        전체삭제
      </button>
    </section>
  );
}
