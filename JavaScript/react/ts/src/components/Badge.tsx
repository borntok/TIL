import styles from "./Badge.module.css";

export interface BadgeProps {
  color: string;
  name: string;
}

export default function Badge({ color, name }: BadgeProps) {
  return (
    <span className={styles.badge} style={{ background: `#${color}` }}>
      {name}
    </span>
  );
}
