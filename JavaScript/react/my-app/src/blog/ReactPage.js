import React, { useEffect, useState } from "react";
import { Link, Outlet } from "react-router-dom";
import axios from "axios";
import useSWR from "swr";

export default function ReactPage() {
  // api call -> react에 해당하는 글의 목록을 응답 받음.
  const [number, setNumber] = useState(0);

  async function fetcher(url) {
    const result = await axios.get(url);

    console.log(result.data);
    return result.data;
  }

  const { data: docs, error } = useSWR("posts", () =>
    fetcher("https://jsonplaceholder.typicode.com/posts")
  );

  if (error) return <div>failed to load</div>;
  if (!docs) return <div>loading...</div>;

  return (
    <div>
      <button onClick={() => setNumber(number + 1)}>{number}</button>
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
