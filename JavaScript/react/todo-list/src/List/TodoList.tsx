import TodoItem from "../ListItem/TodoItem";
import styles from "./TodoList.module.css";

export default function TodoList() {
  const todoList = ["React", "Typescript", "Javascript", "CSS", "HTML"];

  return (
    <section>
      <ol className={styles.olContainer}>
        {todoList.map((item, idx) => {
          return <TodoItem key={`${item}_${idx}`} todo={item} />;
        })}
      </ol>
    </section>
  );
}
