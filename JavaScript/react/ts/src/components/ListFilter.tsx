import styles from "./ListFilter.module.css";
import axios from "axios";
import Modal from "./Modal";

import { useEffect, useState } from "react";
import { GITHUB_API } from "../api";
import { Data, List } from "../model/issues";

export default function ListFilter({
  onChangeFilter,
}: {
  onChangeFilter: (value: Record<string, string>) => void;
}) {
  const [showModal, setShowModal] = useState<string>();
  const [list, setList] = useState<List[]>([]);
  const filterList = ["Label", "Milestone", "Assignee"];

  async function getData(apiPath: string) {
    const data: Data = await axios.get(
      `${GITHUB_API}/repos/facebook/react/${apiPath}`
    );

    let result = [];
    switch (apiPath) {
      case "assignees":
        result = data.data.map((d) => ({
          name: d.login,
        }));
        break;
      case "milestones":
        result = data.data.map((d) => ({
          name: d.title,
        }));
        break;
      case "labels":
      default:
        result = data.data.map((d) => ({
          ...d,
          name: "",
        }));
    }

    setList(result);
  }

  useEffect(() => {
    if (showModal) {
      const apiPath = `${showModal.toLowerCase()}s`;
      getData(apiPath);
    }
  }, [showModal]);

  return (
    <>
      <div className={styles.filterLists}>
        {filterList.map((filter) => (
          <ListFilterItem
            key={filter}
            searchDataList={list}
            onClick={() => setShowModal(filter)}
            onClose={() => setShowModal(undefined)}
            showModal={showModal === filter}
            onChangeFilter={onChangeFilter}
          >
            {filter}
          </ListFilterItem>
        ))}
      </div>
    </>
  );
}

interface ListFilterItemProps {
  children: string;
  placeholder?: string;
  searchDataList: List[];
  showModal: boolean;
  onClick: () => void;
  onClose: () => void;
  onChangeFilter: (value: Record<string, string>) => void;
}

function ListFilterItem({
  children,
  placeholder,
  searchDataList,
  showModal,
  onClick,
  onClose,
  onChangeFilter,
}: ListFilterItemProps) {
  const [list, setList] = useState(searchDataList);

  useEffect(() => {
    setList(searchDataList);
  }, [searchDataList]);

  return (
    <div className={styles.filterItem}>
      <span role="button" onClick={onClick}>
        {children} ▾
      </span>
      <div className={styles.modalContainer}>
        <Modal
          title={children}
          opened={showModal}
          onClose={onClose}
          placeholder={placeholder}
          searchDataList={list}
          onClickCell={(params) => {
            onChangeFilter(params);
          }}
        />
      </div>
    </div>
  );
}
