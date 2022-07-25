import React, { useEffect, useState } from "react";
import { Link, Outlet } from "react-router-dom";

export default function ReactPage() {
  // api call -> react에 해당하는 글의 목록을 응답 받음.
  const [docs, setDocs] = useState([]);

  // const docs = [
  //   {
  //     id: 1,
  //     title: "JSX",
  //     date: "07/04/2022",
  //   },
  //   {
  //     id: 2,
  //     title: "components",
  //     date: "07/05/2022",
  //   },
  //   {
  //     id: 3,
  //     title: "state",
  //     date: "07/06/2022",
  //   },
  //   {
  //     id: 4,
  //     title: "hook",
  //     date: "07/06/2022",
  //   },
  //   {
  //     id: 5,
  //     title: "styled component",
  //     date: "07/07/2022",
  //   },
  // ];

  useEffect(() => {
    async function fetchData() {
      const response = await fetch(
        "https://jsonplaceholder.typicode.com/posts"
      );
      const result = await response.json();
      // setDocs(result);
      return result;
    }

    fetchData().then((res) => {
      setDocs(res);
    });
  }, []);

  return (
    <div>
      {docs.map((doc) => (
        <Link
          to={`${doc.id}`}
          key={doc.id}
          style={{ display: "block", margin: "1rem 0" }}
        >
          {doc.title}
        </Link>
      ))}
      {/* <Outlet /> */}
    </div>
  );
}
