import { useEffect, useRef, useState } from "react";
import styled from "@emotion/styled";
import { KakaoMapContext } from "../hooks/useMap";

interface DynamicMapProps {
  children: React.ReactNode;
}

export default function DynamicMap(props: DynamicMapProps) {
  const [map, setMap] = useState<kakao.maps.Map>();
  const kakaoMapRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!kakaoMapRef.current) return;

    const targetPoint = new kakao.maps.LatLng(37.301617392366, 127.03382807591);
    const options = {
      center: targetPoint,
      level: 3,
    };

    setMap(new window.kakao.maps.Map(kakaoMapRef.current, options));
  }, []);

  return (
    <>
      <Container>
        <Map ref={kakaoMapRef} />
      </Container>
      {map ? (
        <KakaoMapContext.Provider value={map}>
          {props.children}
        </KakaoMapContext.Provider>
      ) : (
        "지도 정보를 가져오는 데 실패하였습니다"
      )}
    </>
  );
}

const Container = styled.div`
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  bottom: 0;
`;

const Map = styled.div`
  position: static;
  width: 100%;
  height: 100%;
`;
