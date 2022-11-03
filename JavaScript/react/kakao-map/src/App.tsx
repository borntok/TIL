import { useState } from "react";
import DynamicMap from "./Map/DynamicMap";
import KakaoMapScriptLoader from "./Map/KakaoMapScriptLoader";
import MapMarkerController from "./Map/MapMarkerController";
import { PlaceType } from "./Map/mapTypes";
import SearchLocation from "./Map/SearchLocation";

export default function App() {
  const [places, setPlaces] = useState<PlaceType[]>([]);

  return (
    <KakaoMapScriptLoader>
      <DynamicMap>
        <MapMarkerController places={places} />
        <SearchLocation onUpdatePlaces={(places) => setPlaces(places)} />
      </DynamicMap>
    </KakaoMapScriptLoader>
  );
}
