import styled from "@emotion/styled";
import { useEffect, useRef, useState } from "react";
import { useMap } from "../hooks/useMap";
import { PlaceType } from "./mapTypes";

interface SearchLocationProps {
  onUpdatePlaces: (place: PlaceType[]) => void;
}

export default function SearchLocation(props: SearchLocationProps) {
  const map = useMap();
  const [keyword, setKeyword] = useState("");
  const [places, setPlaces] = useState<PlaceType[]>([]);

  const placeService = useRef<kakao.maps.services.Places | null>(null);

  useEffect(() => {
    if (placeService.current) return;

    placeService.current = new kakao.maps.services.Places();
  }, []);

  function searchPlaces(keyword: string) {
    if (!keyword.replace(/^\s+|\s+$/g, "")) {
      alert("키워드를 입력해주세요!");
      return;
    }

    if (!placeService.current) {
      // TODO: placeService error handling
      alert("placeService error");
      return;
    }

    placeService.current.keywordSearch(keyword, (data, status) => {
      if (status === kakao.maps.services.Status.OK) {
        const placeInfos = data.map((placeSearchResultItem) => {
          return {
            id: placeSearchResultItem.id,
            position: new kakao.maps.LatLng(
              Number(placeSearchResultItem.y),
              Number(placeSearchResultItem.x)
            ),
            title: placeSearchResultItem.place_name,
            address: placeSearchResultItem.address_name,
          };
        });

        props.onUpdatePlaces(placeInfos);
        setPlaces(placeInfos);
      } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert("검색 결과가 존재하지 않습니다.");
        return;
      } else if (status === kakao.maps.services.Status.ERROR) {
        alert("검색 결과 중 오류가 발생했습니다.");
        return;
      }
    });
  }

  function handleSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    searchPlaces(keyword);
  }

  function handleItemClick(place: PlaceType) {
    map.setCenter(place.position);
    map.setLevel(4);
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
        {places.map((item, index) => {
          return (
            <Item key={item.id} onClick={() => handleItemClick(item)}>
              <label>{`${index + 1}. ${item.title}`}</label>
              <span>{item.address}</span>
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
  background-color: rgba(255, 255, 255, 1);
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
