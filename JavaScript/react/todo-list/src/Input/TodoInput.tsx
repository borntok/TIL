import styles from "./TodoInput.module.css";
import { RiChatNewLine } from "react-icons/ri";

export default function TodoInput() {
  return (
    <section className={styles.container}>
      <form className={styles.formContainer}>
        <input className={styles.input} placeholder="해야할 Todo" />
        <button className={styles.enter}>
          <RiChatNewLine />
        </button>
      </form>
    </section>
  );
}
