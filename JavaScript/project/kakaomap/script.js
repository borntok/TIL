;(function () {
  'use strict'

  const shops = [
    {
      id: 212795302,
      name: '투썸플레이스 북수원정자타운점',
      lat: 37.295246069772745,
      lng: 126.99454979122709,
    },
    {
      id: 1326350452,
      name: '카인드짐 정자동중심상가점',
      lat: 37.296142626192655,
      lng: 126.99510518638334,
    },
    {
      id: 419175336,
      name: '수촌마을 수원정자동본점',
      lat: 37.29640840092865,
      lng: 126.99440026840857,
    },
  ]

  const defaultPos = {
    lat: 37.295901574444954,
    lng: 126.99454974393495,
  }

  const get = (target) => {
    return document.querySelector(target)
  }

  const $mapContainer = get('#map')
  const $geoLocationButton = get('.geolocation_button')

  const map = new kakao.maps.Map($mapContainer, {
    center: new kakao.maps.LatLng(defaultPos.lat, defaultPos.lng),
    level: 2,
  })

  const createMarkerImage = () => {
    const markerImageSrc = 'assets/marker.png'
    const imageSize = new kakao.maps.Size(30, 46)
    return new kakao.maps.MarkerImage(markerImageSrc, imageSize)
  }

  const createMarker = (lat, lng) => {
    const marker = new kakao.maps.Marker({
      map: map,
      position: new kakao.maps.LatLng(lat, lng),
      image: createMarkerImage(),
    })
    return marker
  }

  const createShopElement = () => {
    shops.map(shop => {
      const {lat, lng} = shop
      const marker = createMarker(lat, lng)
      const infowindow = new kakao.maps.InfoWindow({
        content: `<div style="width:150px;text-align:center;padding:6px 2px;">
                  <a href="https://place.map.kakao.com/${shop.id}" target="_blank">${shop.name}</a>
                </div>`,
      })
      infowindow.open(map, marker)
    })
  }

  const successGeolocation = (position) => {
    const { latitude, longitude } = position.coords
    map.setCenter(new kakao.maps.LatLng(latitude, longitude))
    const marker = createMarker(latitude, longitude)
    marker.setMap(map)
  }
  
  const errorGeolocation = (error) => {
    if (error.code === 1) {
      alert('위치 정보를 허용해주세요')
    } else if (error.code === 2) {
      alert('사용할 수 없는 위치입니다')
    } else if (error.code === 3) {
      alert('타임아웃이 발생했습니다')
    } else {
      alert('오류가 발생했습니다')
    }
  }

  const getLocation = () => {
    if ('geolocation' in navigator) {
      navigator.geolocation.getCurrentPosition(
        successGeolocation,
        errorGeolocation
      )
    } else {
      alert('지도 api 사용 불가')
    }
  }

  const init = () => {
    createShopElement()

    $geoLocationButton.addEventListener('click', () => {
      getLocation()
    })
  }

  init()
})()
