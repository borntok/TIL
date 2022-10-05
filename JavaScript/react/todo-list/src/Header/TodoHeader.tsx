import "./TodoHeader.css";

export default function TodoHeader() {
  return (
    <header>
      <h1 className="headerTitle">
        <mark className="todoCount">5</mark>
        개의 할 일
      </h1>
    </header>
  );
}
