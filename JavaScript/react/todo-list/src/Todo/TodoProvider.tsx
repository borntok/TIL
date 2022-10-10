import {
  ReactNode,
  useReducer,
  createContext,
  Dispatch,
  useContext,
} from "react";
import {
  TodoInputActionType,
  todoInputReducer,
  TodoInputStateType,
} from "../Todo/todoInputReducer";
import {
  TodoActionType,
  todoReducer,
  TodoStateType,
} from "../Todo/todoReducer";
import { loadTodos } from "./todoStorage";

interface TodoProviderprops {
  children: ReactNode;
}

const TodoStateContext = createContext<TodoStateType | null>(null);
const TodoDispatchContext = createContext<Dispatch<TodoActionType> | null>(
  null
);
const InputTodoContext = createContext<TodoInputStateType | null>(null);
const InputTodoDispatchContext =
  createContext<Dispatch<TodoInputActionType> | null>(null);

export default function TodoProvider(props: TodoProviderprops) {
  const [todoState, todoDispatch] = useReducer(todoReducer, {
    todos: loadTodos(),
  });
  const [inputState, inputDispatch] = useReducer(todoInputReducer, {
    text: "",
  });

  return (
    <>
      <TodoStateContext.Provider value={todoState}>
        <TodoDispatchContext.Provider value={todoDispatch}>
          <InputTodoContext.Provider value={inputState}>
            <InputTodoDispatchContext.Provider value={inputDispatch}>
              {props.children}
            </InputTodoDispatchContext.Provider>
          </InputTodoContext.Provider>
        </TodoDispatchContext.Provider>
      </TodoStateContext.Provider>
    </>
  );
}

export function useTodoState() {
  const value = useContext(TodoStateContext);

  if (!value) {
    throw new Error("Cannot find todoState");
  }

  return value;
}

export function useTodoDispatch() {
  const value = useContext(TodoDispatchContext);

  if (!value) {
    throw new Error("Cannot find todoDispatch");
  }

  return value;
}

export function useInputTodoState() {
  const value = useContext(InputTodoContext);

  if (!value) {
    throw new Error("Cannot find inputTodo");
  }

  return value;
}

export function useInputTodoDispatch() {
  const value = useContext(InputTodoDispatchContext);

  if (!value) {
    throw new Error("Cannot find inputTodoDispatch");
  }

  return value;
}
