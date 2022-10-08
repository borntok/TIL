import { TodoType } from "../Todo/todoReducer";
import TodoItem from "../ListItem/TodoItem";
import styles from "./TodoList.module.css";

interface TodoListProps {
  todos: TodoType[];
  onToggleClick: (id: number) => void;
  onRemoveClick: (id: number) => void;
}

export default function TodoList(props: TodoListProps) {
  return (
    <section>
      <ol className={styles.olContainer}>
        {props.todos.map((todo) => {
          return (
            <TodoItem
              key={todo.id}
              id={todo.id}
              text={todo.text}
              isChecked={todo.isChecked}
              onToggleClick={props.onToggleClick}
              onRemoveClick={props.onRemoveClick}
            />
          );
        })}
      </ol>
    </section>
  );
}
