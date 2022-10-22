import { Link } from "react-router-dom";
import styled from "@emotion/styled";

export default function PageHeader() {
  return (
    <Header>
      <Title>
        <Link to="/">Pokémon</Link>
      </Title>
      <Select>
        <option value="Official">Official</option>
        <option value="A">A</option>
        <option value="B">B</option>
      </Select>
    </Header>
  );
}

const Header = styled.nav`
  display: flex;
  padding: 16px 32px;
  margin-bottom: 16px;
  border-bottom: 1px solid #c0c0c0;
`;

const Title = styled.h1`
  margin: 0;
  font-size: 32px;
  color: #ffca09;
  text-shadow: -1px 0 blue, 0 2px blue, 1px 0 blue, 0 -1px blue;
`;

const Select = styled.select`
  display: flex;
  margin-left: auto;
  padding: 8px 12px;
  border-radius: 8px;
`;
