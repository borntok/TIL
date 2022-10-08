import TodoItem from "../ListItem/TodoItem";
import styles from "./TodoList.module.css";
import { useTodoState } from "../Todo/TodoProvider";

export default function TodoList() {
  const todoState = useTodoState();

  return (
    <section>
      <ol className={styles.olContainer}>
        {todoState.todos.map((todo) => {
          return (
            <TodoItem
              key={todo.id}
              id={todo.id}
              text={todo.text}
              isChecked={todo.isChecked}
            />
          );
        })}
      </ol>
    </section>
  );
}
