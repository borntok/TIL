type todoInputStateType = {
  text: string;
};

type todoInputActionType =
  | {
      type: "change";
      payload: string;
    }
  | {
      type: "clear";
    };

export function todoInputReducer(
  state: todoInputStateType,
  action: todoInputActionType
) {
  switch (action.type) {
    case "change":
      return { text: action.payload };
    case "clear":
      return { text: "" };
  }
}
