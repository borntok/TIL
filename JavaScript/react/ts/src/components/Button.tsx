import styles from "./Button.module.css";

interface Props {
  style: React.CSSProperties;
  children: React.ReactNode;
  type?: "button" | "submit";
  disabled?: boolean;
}

export default function Button({
  style,
  children,
  type = "button",
  disabled,
}: Props) {
  return (
    <button
      className={styles.button}
      style={style}
      type={type}
      disabled={disabled}
    >
      {children}
    </button>
  );
}
