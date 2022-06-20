;(function () {
  'use strict'
  const get = (target) => {
    return document.querySelector(target)
  }

  const $button = get('.modal_open_button')
  const $modal = get('.modal')
  const $body = get('body')
  const $modalCancelButton = get('.modal_button.cancel')
  const $modalConfirmButton = get('.modal_button.confirm')

  const toggleModal = () => {
    $modal.classList.toggle('show')
    $body.classList.toggle('scroll_lock')
  }

  $button.addEventListener('click', toggleModal)
  $modalCancelButton.addEventListener('click', toggleModal)
  $modalConfirmButton.addEventListener('click', () => {
    toggleModal()
    console.log('confirm')})

  window.addEventListener('click', (e) => {
    if (e.target === $modal) {
      toggleModal()
    }
  })
})()
