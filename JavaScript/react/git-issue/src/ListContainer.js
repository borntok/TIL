import styles from "./ListContainer.module.css"
import axios from "axios"
import cx from "clsx"

import { useState, useEffect } from "react"

import Button from "./components/Button"
import OpenClosedFilters from "./components/OpenClosedFilters"
import ListItemLayout from "./components/ListItemLayout"
import ListFilter from "./components/ListFilter"
import ListItem from "./components/ListItem"
import Pagination from "./components/Pagination"

import { GITHUB_API } from "./api"

export default function ListContainer() {
  const [inputValue, setInputValue] = useState("is:pr is:open")
  const [list, setList] = useState([])
  const [page, setPage] = useState(1)
  const [checked, setChecked] = useState(false)
  const [isOpenMode, setIsOpenMode] = useState(true)

  const maxPage = 10

  async function getData(params) {
    const { data } = await axios.get(
      `${GITHUB_API}/repos/facebook/react/issues`,
      { params },
    )
    setList(data)
  }

  useEffect(() => {
    getData({ page, state: isOpenMode ? "open" : "closed" })
  }, [page, isOpenMode])
  // console.log(data)

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
        <OpenClosedFilters
          isOpenMode={isOpenMode}
          onClickMode={setIsOpenMode}
        />
        <ListItemLayout className={styles.listFilter}>
          <ListFilter
            onChangeFilter={(filteredData) => {
              // 필터링된 요소에 맞게 데이터 불러오기
            }}
          />
        </ListItemLayout>
        <div className={styles.container}>
          {list.map((item) => (
            <ListItem
              key={item.id}
              data={item}
              checked={checked}
              onClickCheckBox={() => setChecked((checked) => !checked)}
            />
          ))}
        </div>
      </div>
      <div className={styles.paginationContainer}>
        <Pagination
          currentPage={page}
          onClickPageButton={(number) => setPage(number)}
          maxPage={maxPage}
        />
      </div>
    </>
  )
}
