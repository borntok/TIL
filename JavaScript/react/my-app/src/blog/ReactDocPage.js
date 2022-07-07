import React from "react";
import { useParams, useNavigate } from "react-router-dom";

export default function ReactDocPage() {
  // docID : 1, 2, 3, ...
  const params = useParams();
  const navigate = useNavigate();

  return (
    <>
      <h5 onClick={() => navigate("/")}>logo</h5>
      <div>ReactDocPage ##{params.docId}</div>
    </>
  );
}
