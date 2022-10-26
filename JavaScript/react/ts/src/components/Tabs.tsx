import { useLocation, Link } from "react-router-dom";

import styles from "./Tabs.module.css";
import cx from "clsx";

const tabList = [
  { name: "Code", pathname: "/code" },
  { name: "Issues", pathname: "/issue" },
  { name: "Pull requests", pathname: "/pulls" },
  { name: "Actions", pathname: "/actions" },
  { name: "Projects", pathname: "/projects" },
  { name: "Security", pathname: "/security" },
];

interface TabsProps {
  title?: string;
  number?: number;
}

export default function Tabs({ title, number }: TabsProps) {
  const { pathname } = useLocation();

  return (
    <ul className={styles.tabList}>
      {tabList.map((tab, idx) => (
        <Tab
          key={`${idx}`}
          item={tab}
          selected={(pathname === "/" ? "/issue" : pathname) === tab.pathname}
        />
      ))}
    </ul>
  );
}

interface TabProps {
  item: { name: string; pathname: string };
  selected: boolean;
  number?: number;
}

function Tab({ item, selected, number }: TabProps) {
  return (
    <li>
      <Link to={item.pathname} className={styles.link}>
        <button className={cx(styles.tab, { [styles.selected]: selected })}>
          <span>{item.name}</span>
          {number && <div className={styles.circle}>{number}</div>}
        </button>
      </Link>
    </li>
  );
}
