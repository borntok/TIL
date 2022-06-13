;(function () {
  'use strict'

  const get = (target) => document.querySelector(target)
  const getAll = (target) => document.querySelectorAll(target)

  const $search = get('#search')
  const $list = getAll('.contents.list figure')
  const $searchButton = get('.btn_search')

  const $player = get('.view video')
  const $btnPlay = get('.js-play')
  const $btnReplay = get('.js-replay')
  const $btnStop = get('.js-stop')
  const $btnMute = get('.js-mute')
  const $progress = get('.js-progress')
  const $volume = get('.js-volume')
  const $fullscreen = get('.js-fullScreen')

  const init = () => {
    $search.addEventListener('keyup', search)
    $searchButton.addEventListener('click', search)

    for (let i = 0; i < $list.length; i++) {
      const $target = $list[i].querySelector('picture')
      $target.addEventListener('mouseover', onMouseOver)
      $target.addEventListener('mouseout', onMouseOut)
    }

    for (let i = 0; i < $list.length; i++) {
      $list[i].addEventListener('click', hashChange)
    }

    window.addEventListener('hashchange', () => {
      const isView = -1 < window.location.hash.indexOf('view')
      if (isView) {
        getViewPage()
      } else {
        getListPage()
      }
    })

    viewPageEvent()
  }

  const search = () => {
    let searchText =  $search.value.toLowerCase()

    for (let i = 0; i < $list.length; i++) {
      const $target = $list[i].querySelector('strong')
      const text = $target.textContent.toLowerCase()
      if (-1 < text.indexOf(searchText)) {
        $list[i].style.display = 'flex'
      } else {
        $list[i].style.display = 'none'
      }
    }
  }

  const onMouseOver = (e) => {
    const webpPlay = e.target.parentNode.querySelector('source')
    webpPlay.setAttribute('srcset', './assets/sample.webp')
  }

  const onMouseOut = (e) => {
    const webpPlay = e.target.parentNode.querySelector('source')
    webpPlay.setAttribute('srcset', './assets/sample.jpg')
  }

  const hashChange = (e) => {
    e.preventDefault()
    const parentNode = e.target.closest('figure')
    const viewTitle = parentNode.querySelector('strong').textContent
    window.location.hash = `view&${viewTitle}`
  }

  const getViewPage = () => {
    const viewTitle = get('.view strong')
    const urlTitle = decodeURI(window.location.hash.split('&')[1])
    viewTitle.innerText = urlTitle

    get('.list').style.display = 'none'
    get('.view').style.display = 'flex'
  }

  const getListPage = () => {
    get('.list').style.display = 'flex'
    get('.view').style.display = 'none'
  }

  const buttonChange = (btn, value) => {
    btn.innerHTML = value
  }

  const viewPageEvent = () => {
    $volume.addEventListener('change', (e) => {
      $player.volume = e.target.value
    })

    $player.addEventListener('timeupdate', setProgress)
    $player.addEventListener('play', buttonChange($btnPlay, 'Pause'))
    $player.addEventListener('pause', buttonChange($btnPlay, 'Play'))
    $player.addEventListener('volumeChange', () => {
      $player.muted
        ? buttonChange($btnMute, 'unmute')
        : buttonChange($btnMute, 'mute')
    })
    $player.addEventListener('ended', $player.pause())
    $progress.addEventListener('click', getCurrent)
    $btnPlay.addEventListener('click', playVideo)
    $btnStop.addEventListener('click', stopVideo)
    $btnReplay.addEventListener('click', replayVideo)
    $btnMute.addEventListener('click', mute)
    $fullscreen.addEventListener('click', fullScreen)
  }

  const getCurrent = (e) => {
    let percent = e.offsetX / $progress.offsetWidth
    $player.currentTime = percent * $player.duration
    e.target.value = Math.floor(percent / 100)
  }

  const setProgress = () => {
    let percentage = Math.floor(100 / $player.duration) * $player.currentTime
    $progress.value = percentage
  }

  const playVideo = () => {
    if ($player.paused || $player.ended) {
      buttonChange($btnPlay, 'Pause')
      $player.play()
    } else {
      buttonChange($btnPlay, 'Play')
      $player.pause()
    }
  }

  const stopVideo = () => {
    $player.pause()
    $player.currentTime = 0
    buttonChange($btnPlay, 'Play')
  }

  const resetPlayer = () => {
    $progress.value = 0
    $player.currentTime = 0
  }

  const replayVideo = () => {
    resetPlayer()
    $player.play()
    buttonChange($btnPlay, 'Pause')
  }
 
  const mute = () => {
    if ($player.muted) {
      buttonChange($btnMute, 'Mute')
      $player.muted = false
    } else {
      buttonChange($btnMute, 'Unmute')
      $player.muted = true
    }
  }

  const fullScreen = () => {
    if ($player.requestFullscreen) {
      if (document.fullscreenElement) {
        document.cancelFullScreen()
      } else {
        $player.requestFullscreen()
      }
    } else if ($player.msRequestFullscreen) {
      if (document.msRequestFullscreen) {
        document.msExitFullscreen()
      } else {
        $player.msRequestFullscreen()
      }
    } else {
      alert('Not Supported')
    }
  }

  init()
})()
