import { useEffect } from "react";
import { useMap } from "../hooks/useMap";
import MapMarker from "./MapMarker";
import { PlaceType } from "./mapTypes";

interface MapMarkerControllerProps {
  places: PlaceType[];
  selectedPlaceId?: string;
}

export default function MapMarkerController(props: MapMarkerControllerProps) {
  const map = useMap();

  useEffect(() => {
    if (props.places.length < 1) return;

    const bounds = new window.kakao.maps.LatLngBounds();
    props.places.forEach((place) => {
      bounds.extend(place.position);
    });

    map.setBounds(bounds);
  }, [props.places]);

  return (
    <>
      {props.places.map((place) => {
        return (
          <MapMarker
            key={place.id}
            place={place}
            showInfo={props.selectedPlaceId === place.id}
          />
        );
      })}
    </>
  );
}
