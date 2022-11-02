import styled from "@emotion/styled";
import { useState } from "react";

export default function SearchLocation() {
  const [keyword, setKeyword] = useState("");

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
  }

  return (
    <Container>
      <Form onSubmit={handleSubmit}>
        <Input
          value={keyword}
          onChange={(e) => {
            setKeyword(e.target.value);
          }}
        />
      </Form>
      <List>
        {Array.from({ length: 15 }).map((item, index) => {
          return (
            <Item key={index}>
              <label>지역</label>
              <span>경기도 수원시 영통구 광교산로 154-42</span>
            </Item>
          );
        })}
      </List>
    </Container>
  );
}

const Container = styled.div`
  position: absolute;
  z-index: 1;
  height: 100vh;
  overflow-y: auto;
  background-color: rgba(255, 255, 255, 0.8);
`;

const Form = styled.form`
  display: flex;
  position: sticky;
  top: 0;
`;

const Input = styled.input`
  background-color: rgba(255, 255, 255, 0.1);
  width: 100%;
  min-width: 200px;
  padding: 8px;
  border: 1px solid #c0c0c0;
`;

const List = styled.ul`
  list-style: none;
  margin: 0;
  padding: 0;
`;

const Item = styled.li`
  display: flex;
  flex-direction: column;
  padding: 8px;
  border-bottom: 1px dashed #d2d2d2;
  cursor: pointer;

  &:hover {
    background-color: #d2d2d2;
    transition: background-color 0s;
  }
`;
