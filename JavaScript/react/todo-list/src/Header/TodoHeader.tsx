import styles from "./TodoHeader.module.css";

export default function TodoHeader() {
  return (
    <header>
      <h1 className={styles.headerTitle}>
        <mark className={styles.todoCount}>5</mark>
        개의 할 일
      </h1>
    </header>
  );
}
