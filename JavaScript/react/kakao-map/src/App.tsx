import DynamicMap from "./Map/DynamicMap";
import KakaoMapScriptLoader from "./Map/KakaoMapScriptLoader";

export default function App() {
  return (
    <KakaoMapScriptLoader>
      <DynamicMap />
    </KakaoMapScriptLoader>
  );
}
