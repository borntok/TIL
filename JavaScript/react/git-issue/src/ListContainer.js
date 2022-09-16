import styles from "./ListContainer.module.css"
import cx from "clsx"

import { useState } from "react"

import Button from "./components/Button"
import OpenClosedFilters from "./components/OpenClosedFilters"
import ListItemLayout from "./components/ListItemLayout"
import ListFilter from "./components/ListFilter"
import ListItem from "./components/ListItem"
import Pagination from "./components/Pagination"

export default function ListContainer() {
  const [inputValue, setInputValue] = useState("is:pr is:open")
  const [list, setList] = useState([])
  const [page, setPage] = useState(1)

  return (
    <>
      <div className={styles.listContainer}>
        <div className={styles.topSection}>
          <input
            className={styles.input}
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
          />
          <Button
            style={{
              fontSize: "14px",
              backgroundColor: "green",
              color: "white",
            }}
          >
            New Issue
          </Button>
        </div>
        <OpenClosedFilters />
        <ListItemLayout className={styles.listFilter}>
          <ListFilter
            onChangeFilter={(filteredData) => {
              // 필터링된 요소에 맞게 데이터 불러오기
            }}
          />
        </ListItemLayout>
        <div className={styles.container}>
          {list.map((listItem, idx) => (
            <ListItem
              key={idx}
              badges={[
                {
                  color: "red",
                  title: "Bug",
                },
              ]}
            />
          ))}
        </div>
      </div>
      <div className={styles.paginationContainer}>
        <Pagination
          maxPage={10}
          currentPage={page}
          onClickPageButton={(number) => setPage(number)}
        />
      </div>
    </>
  )
}
