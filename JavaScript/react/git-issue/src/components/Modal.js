import styles from "./Modal.module.css"
import cx from "clsx"
import { useEffect, useState } from "react"

export default function Modal({
  opened,
  title,
  onClose,
  placeholder,
  searchDataList,
  onClickCell,
}) {
  const [searchValue, setSearchValue] = useState("")
  const [filteredData, setFilteredData] = useState(searchDataList)

  useEffect(() => {
    setFilteredData(searchDataList)
  }, [searchDataList])

  // useEffect(() => {
  //   setFilteredData(searchDataList.filter((item) => item === searchValue))
  // }, [searchDataList, searchValue])

  return (
    <div className={cx(styles.modal, { [styles.opened]: opened })}>
      <div className={styles.header}>
        <span>Filter by {title}</span>
        <button onClick={onClose}>⨉</button>
      </div>
      <div className={styles.input}>
        <input
          placeholder={placeholder}
          value={searchValue}
          onChange={(e) => setSearchValue(e.target.value)}
        />
      </div>
      {filteredData.map((data) => (
        <div
          key={data.name}
          onClick={() => onClickCell(data)}
          role="button"
          className={styles.item}
        >
          {data.name}
        </div>
      ))}
    </div>
  )
}
