import styles from "./ListItemLayout.module.css";
import cx from "clsx";

interface ListItemLayoutProps {
  className: string;
  checked: boolean;
  onClick: (e: React.ChangeEvent<HTMLInputElement>) => void;
  children: React.ReactNode;
}

export default function ListItemLayout({
  className,
  checked,
  onClick,
  children,
}: ListItemLayoutProps) {
  return (
    <div className={cx(styles.wrapper, className)}>
      <input
        type="checkbox"
        className={styles.checkbox}
        checked={checked}
        onChange={onClick}
      />
      {children}
    </div>
  );
}
