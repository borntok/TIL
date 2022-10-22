import styled from "@emotion/styled";
import PokeMarkChip from "../Common/PokeMarkChip";

const TempImgUrl =
  "https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjJfMTg3/MDAxNDg3NzI4NTQ2NjYz.PXKT8WOvIrVgUamJQqSIGdwjeUHlO6GKKQBJrcHejLsg.EgM4jWM1lZh3NGoC2BUgXQ2aFzqQnSCh8ivhMmT7wWUg.PNG.ioea65ztem/02.%EA%B5%AC%EA%B8%80.png?type=w800";

export default function PokemonDetail() {
  return (
    <Container>
      <ImageContainer>
        <Image src={TempImgUrl} alt="이상해씨" />
      </ImageContainer>
      <Divider />
      <Body>
        <h2>기본 정보</h2>
        <Table>
          <tbody>
            <TableRow>
              <TableHeader>번호</TableHeader>
              <td>1</td>
            </TableRow>
            <TableRow>
              <TableHeader>이름</TableHeader>
              <td>이상해씨 (bulbasaur)</td>
            </TableRow>
            <TableRow>
              <TableHeader>타입</TableHeader>
              <td>grass, poison</td>
            </TableRow>
            <TableRow>
              <TableHeader>키</TableHeader>
              <td>0.7 m</td>
            </TableRow>
            <TableRow>
              <TableHeader>몸무게</TableHeader>
              <td>6.9 kg</td>
            </TableRow>
          </tbody>
        </Table>
        <h2>능력치</h2>
        <Table>
          <tbody>
            <TableRow>
              <TableHeader>hp</TableHeader>
              <td>45</td>
            </TableRow>
            <TableRow>
              <TableHeader>attack</TableHeader>
              <td>49</td>
            </TableRow>
            <TableRow>
              <TableHeader>defence</TableHeader>
              <td>49</td>
            </TableRow>
            <TableRow>
              <TableHeader>special-attack</TableHeader>
              <td>65</td>
            </TableRow>
            <TableRow>
              <TableHeader>special-defense</TableHeader>
              <td>65</td>
            </TableRow>
            <TableRow>
              <TableHeader>speed</TableHeader>
              <td>45</td>
            </TableRow>
          </tbody>
        </Table>
      </Body>
      <Footer>
        <PokeMarkChip />
      </Footer>
    </Container>
  );
}

const Container = styled.section`
  border: 1px solid #c0c0c0;
  margin: 16px 32px;
  border-radius: 16px;
  box-shadow: 1px 1px 3px 1px #c0c0c0;
`;

const ImageContainer = styled.section`
  display: flex;
  flex: 1 1 auto;
  justify-content: center;
  align-items: center;
  margin: 8px 0;
`;

const Image = styled.img`
  widtableheader: 350px;
  height: 350px;
`;

const Divider = styled.hr`
  margin: 32px;
  border-style: none;
  border-top: 1px dashed #d3d3d3;
`;

const Body = styled.section`
  margin: 0 32px;
`;

const Table = styled.table`
  width: 100%;
  border-collapse: collapse;
  border-spacing: 0;
  margin: 0 auto 16px;

  TableHeader,
  td {
    padding: 6px 12px;
  }
`;

const TableRow = styled.tr`
  border-width: 1px 0;
  border-style: solid;
  border-color: #f0f0f0;
`;

const TableHeader = styled.th`
  width: 1px;
  white-space: nowrap;
  text-align: left;
  font-weight: normal;
  color: #a0a0a0;
`;

const Footer = styled.section`
  display: flex;
  margin: 32px 16px;
`;
