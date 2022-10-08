import { ChangeEvent, FormEvent } from "react";
import styles from "./TodoInput.module.css";
import { RiChatNewLine } from "react-icons/ri";
import {
  useInputTodoDispatch,
  useInputTodoState,
  useTodoDispatch,
} from "../Todo/TodoProvider";

export default function TodoInput() {
  const inputState = useInputTodoState();
  const inputDispatch = useInputTodoDispatch();
  const todoDispatch = useTodoDispatch();

  function handleInputChange(event: ChangeEvent<HTMLInputElement>) {
    inputDispatch({
      type: "change",
      payload: event.target.value,
    });
  }

  function handleSubmit(event: FormEvent) {
    event.preventDefault();

    if (!inputState.text) {
      return;
    }

    todoDispatch({
      type: "add",
      payload: {
        text: inputState.text,
      },
    });

    inputDispatch({
      type: "clear",
    });
  }

  return (
    <section className={styles.container}>
      <form className={styles.formContainer} onSubmit={handleSubmit}>
        <input
          className={styles.input}
          placeholder="해야할 Todo"
          value={inputState.text || ""}
          onChange={handleInputChange}
        />
        <button className={styles.enter} type="submit">
          <RiChatNewLine />
        </button>
      </form>
    </section>
  );
}
