import DynamicMap from "./Map/DynamicMap";
import KakaoMapScriptLoader from "./Map/KakaoMapScriptLoader";
import SearchLocation from "./Map/SearchLocation";

export default function App() {
  return (
    <KakaoMapScriptLoader>
      <DynamicMap />
      <SearchLocation />
    </KakaoMapScriptLoader>
  );
}
