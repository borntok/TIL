import React, { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { getUser, updateNickname } from "../mocks/api";

// api를 통해 현재 닉네임값 가져오기
// handleSubmit: 업데이트된 inputValue를 서버에 전송

export default function Edit() {
  const [inputValue, setInputValue] = useState("");
  const queryClient = useQueryClient();
  const { data, isLoading } = useQuery(["@getUser"], getUser, {
    staleTime: Infinity,
  });
  const mutation = useMutation(updateNickname, {
    onSuccess: () => {
      queryClient.invalidateQueries(["@getUser"]);
    },
  });

  const handleChange = (e) => {
    setInputValue(e.target.value);
  };
  const handleSubmit = (e) => {
    e.preventDefault();
    mutation.mutate(inputValue);
  };

  if (isLoading) return <span>Loading...</span>;

  return (
    <>
      <h1>Edit</h1>
      <h3>현재 닉네임: {data.nickName}</h3>
      <form onSubmit={handleSubmit}>
        <label>
          변경할 닉네임:
          <input type="text" value={inputValue} onChange={handleChange} />
        </label>
      </form>
    </>
  );
}
