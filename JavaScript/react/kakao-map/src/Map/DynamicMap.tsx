import { useEffect, useRef } from "react";
import styled from "@emotion/styled";

export default function DynamicMap() {
  const kakaoMapRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!kakaoMapRef.current) return;

    new window.kakao.maps.Map(kakaoMapRef.current, {
      center: new kakao.maps.LatLng(37.301617392366, 127.03382807591),
      level: 3,
    });
  }, []);

  return (
    <Container>
      <Map ref={kakaoMapRef} />
    </Container>
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
