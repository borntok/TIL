import { ChangeEvent, FormEvent } from "react";
import styles from "./TodoInput.module.css";
import { RiChatNewLine } from "react-icons/ri";

interface TodoInputProps {
  text: string;
  onTextChange: (text: string) => void;
  onSubmit: () => void;
}

export default function TodoInput(props: TodoInputProps) {
  function handleInputChange(event: ChangeEvent<HTMLInputElement>) {
    props.onTextChange(event.target.value);
  }

  function handleSubmit(event: FormEvent) {
    event.preventDefault();
    props.onSubmit();
  }

  return (
    <section className={styles.container}>
      <form className={styles.formContainer} onSubmit={handleSubmit}>
        <input
          className={styles.input}
          placeholder="해야할 Todo"
          value={props.text || ""}
          onChange={handleInputChange}
        />
        <button className={styles.enter} type="submit">
          <RiChatNewLine />
        </button>
      </form>
    </section>
  );
}
