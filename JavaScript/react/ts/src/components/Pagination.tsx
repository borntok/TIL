import styles from "./Pagination.module.css";
import cx from "clsx";

interface OnClickProps {
  onClick: (page: number) => void;
}

interface PaginationProps extends OnClickProps {
  currentPage: number;
  maxPage: number;
}

export default function Pagination({
  currentPage,
  maxPage,
  onClick,
}: PaginationProps) {
  return (
    <div>
      <button
        className={cx(styles.button, styles.blueButton)}
        disabled={currentPage === 1}
      >
        {"< Previous"}
      </button>
      {new Array(maxPage).fill(null).map((_, i) => (
        <PageButton
          key={i + 1}
          number={i + 1}
          onClick={onClick}
          selected={i + 1 === currentPage}
        />
      ))}
      <button
        className={cx(styles.button, styles.blueButton)}
        disabled={currentPage === maxPage}
      >
        {"Next >"}
      </button>
    </div>
  );
}

interface PageButtonProps extends OnClickProps {
  number: number;
  selected: boolean;
}

function PageButton({ number, onClick, selected }: PageButtonProps) {
  return (
    <button
      className={cx(styles.button, { [styles.selected]: selected })}
      onClick={() => onClick(number)}
    >
      {number}
    </button>
  );
}
