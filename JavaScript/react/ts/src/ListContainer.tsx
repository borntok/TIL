import styles from "./ListContainer.module.css";
import axios from "axios";
import cx from "clsx";

import { useState, useEffect } from "react";
import { Link, useSearchParams } from "react-router-dom";

import Button from "./components/Button";
import ListItemLayout from "./components/ListItemLayout";
import Pagination from "./components/Pagination";
import OpenClosedFilters from "./components/OpenClosedFilters";
import ListFilter from "./components/ListFilter";
import ListItem from "./components/ListItem";

import { GITHUB_API } from "./api";
import { ListItems } from "./model/issues";

export default function ListContainer() {
  const [inputValue, setInputValue] = useState("is:pr is:open");
  const [list, setList] = useState<ListItems[]>([]);
  const [checked, setChecked] = useState(false);
  const maxPage = 10;

  const [searchParams, setSearchParams] = useSearchParams();
  const page = parseInt(searchParams.get("page") ?? "1", 10);
  const state = searchParams.get("state");

  async function getData(params: URLSearchParams) {
    const { data } = await axios.get(
      `${GITHUB_API}/repos/facebook/react/issues`,
      { params }
    );
    setList(data);
  }

  useEffect(() => {
    getData(searchParams);
  }, [searchParams]);

  return (
    <>
      <div className={styles.listContainer}>
        <div className={styles.topSection}>
          <input
            className={styles.input}
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
          />
          <Link to="/new" className={styles.link}>
            <Button
              style={{
                fontSize: "14px",
                backgroundColor: "green",
                color: "white",
              }}
            >
              New Issue
            </Button>
          </Link>
        </div>
        <OpenClosedFilters
          isOpenMode={state !== "closed"}
          onClickMode={(state) => setSearchParams({ state })}
        />
        <ListItemLayout className={styles.listFilter}>
          <ListFilter
            onChangeFilter={(params) => {
              setSearchParams(params);
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
          onClick={(pageNumber) =>
            setSearchParams({ page: pageNumber.toString() })
          }
          maxPage={maxPage}
        />
      </div>
    </>
  );
}
