import { TodoType } from "../App";
import TodoItem from "../ListItem/TodoItem";
import styles from "./TodoList.module.css";

interface TodoListProps {
  todos: TodoType[];
}

export default function TodoList(props: TodoListProps) {
  return (
    <section>
      <ol className={styles.olContainer}>
        {props.todos.map((todo) => {
          return (
            <TodoItem
              key={todo.id}
              text={todo.text}
              isChecked={todo.isChecked}
            />
          );
        })}
      </ol>
    </section>
  );
}
