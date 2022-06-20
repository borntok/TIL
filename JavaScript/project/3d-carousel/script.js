;(function () {
  'use strict'

  const get = (target) => {
    return document.querySelector(target)
  }

  const cellCount = 6
  let selectIndex = 0

  const $prevButton = get('.prev_button')
  const $nextButton = get('.next_button')
  const $carousel = get('.carousel')

  const rotateCarousel = () => {
    const angle = (selectIndex / cellCount) * -360
    $carousel.style.transform = `translateZ(-346px) rotateY(${angle}deg)`
  }

  $prevButton.addEventListener('click', () => {
    selectIndex--
    rotateCarousel()
  })
  $nextButton.addEventListener('click', () => {
    selectIndex++
    rotateCarousel()
  })
})()
