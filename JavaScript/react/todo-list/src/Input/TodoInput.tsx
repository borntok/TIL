import "./TodoInput.css";
import { RiChatNewLine } from "react-icons/ri";

export default function TodoInput() {
  return (
    <section className="container">
      <form className="formContainer">
        <input className="input" />
        <button className="enter">
          <RiChatNewLine />
        </button>
      </form>
    </section>
  );
}
