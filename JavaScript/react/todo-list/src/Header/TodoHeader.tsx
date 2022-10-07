import styles from "./TodoHeader.module.css";

interface TodoHeaderProps {
  count: number;
}

export default function TodoHeader(props: TodoHeaderProps) {
  return (
    <header>
      <h1 className={styles.headerTitle}>
        <mark className={styles.todoCount}>{props.count}</mark>
        개의 할 일
      </h1>
    </header>
  );
}
