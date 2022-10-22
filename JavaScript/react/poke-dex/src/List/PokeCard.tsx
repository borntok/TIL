import styled from "@emotion/styled";
import { useNavigate } from "react-router-dom";
import PokeMarkChip from "../Common/PokeMarkChip";
import PokeNameChip from "../Common/PokeNameChip";

const TempImgUrl =
  "https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjJfMTg3/MDAxNDg3NzI4NTQ2NjYz.PXKT8WOvIrVgUamJQqSIGdwjeUHlO6GKKQBJrcHejLsg.EgM4jWM1lZh3NGoC2BUgXQ2aFzqQnSCh8ivhMmT7wWUg.PNG.ioea65ztem/02.%EA%B5%AC%EA%B8%80.png?type=w800";

interface PokeCardProps {
  name: string;
}

export default function PokeCard(props: PokeCardProps) {
  const navigate = useNavigate();

  function handleClick() {
    navigate(`/pokemon/${props.name}`);
  }

  return (
    <Item onClick={handleClick}>
      <Header>
        <PokeNameChip name={props.name} />
      </Header>
      <Body>
        <Image src={TempImgUrl} alt="이상해씨" />
      </Body>
      <Footer>
        <PokeMarkChip />
      </Footer>
    </Item>
  );
}

const Item = styled.li`
  display: flex;
  flex-direction: column;
  padding: 8px;
  width: 250px;
  height: 300px;
  border: 1px solid #c0c0c0;
  box-shadow: 1px 1px 3px 1px #c0c0c0;

  cursor: pointer;
  transition: transform 0.3s ease-in-out;

  &:hover {
    transform: scale(1.1);
  }

  &:active {
    background-color: #caffc1;
    opacity: 0.8;
    transition: background-color 0s;
  }
`;

const Header = styled.section`
  display: flex;
  margin: 8px 0;
`;

const Body = styled.section`
  display: flex;
  flex: 1;
  justify-content: center;
  align-items: center;
  margin: 8px 0;
`;

const Image = styled.img`
  width: 180px;
  height: 180px;
`;

const Footer = styled.section`
  display: flex;
  margin: 8px 0;
`;
