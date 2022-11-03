import ReactDoM from "react-dom";
import { useEffect, useLayoutEffect, useMemo, useRef } from "react";
import { useMap } from "../hooks/useMap";
import { PlaceType } from "./mapTypes";
import styled from "@emotion/styled";

interface MapMarkerProps {
  place: PlaceType;
  showInfo?: boolean;
}

export default function MapMarker(props: MapMarkerProps) {
  const map = useMap();
  const container = useRef(document.createElement("div"));

  const infoWinodw = useMemo(() => {
    container.current.style.position = "absolute";
    container.current.style.bottom = "40px";

    return new kakao.maps.CustomOverlay({
      position: props.place.position,
      content: container.current,
    });
  }, []);

  const marker = useMemo(() => {
    const marker = new kakao.maps.Marker({
      position: props.place.position,
    });

    kakao.maps.event.addListener(marker, "click", function () {
      map.setCenter(props.place.position);
      map.setLevel(4, {
        animate: true,
      });
      infoWinodw.setMap(map);
    });

    return marker;
  }, []);

  useLayoutEffect(() => {
    marker.setMap(map);

    return () => {
      marker.setMap(null);
    };
  }, [map]);

  useEffect(() => {
    if (props.showInfo) {
      infoWinodw.setMap(map);
      return;
    }

    return () => {
      infoWinodw.setMap(null);
    };
  }, [props.showInfo]);

  return container.current
    ? ReactDoM.createPortal(
        <Messege>
          <Title>{props.place.title}</Title>
          <Address>{props.place.address}</Address>
        </Messege>,
        container.current
      )
    : null;
}

const Messege = styled.section`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-width: 180px;
  min-height: 50px;
  margin-left: -90px;
  border-radius: 16px;
  background-color: rgba(255, 228, 196, 0.9);
`;

const Title = styled.label`
  font-weight: bold;
  padding: 6px 8px;
`;

const Address = styled.span`
  font-size: 12px;
  padding: 0 6px 6px;
`;
