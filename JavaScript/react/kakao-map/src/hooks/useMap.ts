import { createContext, useContext } from "react";

export const KakaoMapContext = createContext<kakao.maps.Map | null>(null);

export function useMap() {
  const kakaoMap = useContext(KakaoMapContext);

  if (!kakaoMap) {
    throw new Error("kakaoMap not found");
  }

  return kakaoMap;
}
