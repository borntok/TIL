import styles from "./OpenClosedFilters.module.css";
import cx from "clsx";

interface OpenClosedFiltersProps {
  isOpenMode: boolean;
  onClickMode: (v: string) => void;
}

export default function OpenClosedFilters({
  isOpenMode,
  onClickMode,
}: OpenClosedFiltersProps) {
  return (
    <>
      <OpenClosedFilter
        state="Open"
        selected={isOpenMode}
        onClick={() => onClickMode("open")}
      />
      <OpenClosedFilter
        state="Closed"
        selected={!isOpenMode}
        onClick={() => onClickMode("closed")}
      />
    </>
  );
}

interface OpenClosedFilterProps {
  state: string;
  onClick: (e: React.MouseEvent<HTMLSpanElement>) => void;
  selected: boolean;
}

function OpenClosedFilter({ state, onClick, selected }: OpenClosedFilterProps) {
  return (
    <span
      role="button"
      className={cx(styles.textFilter, { [styles.selected]: selected })}
      onClick={onClick}
    >
      {size} {state}
    </span>
  );
}
