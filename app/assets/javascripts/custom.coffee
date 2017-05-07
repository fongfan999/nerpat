$(document).on 'turbolinks:load', ->
  $(".button-collapse").sideNav();

  autoScrollFixedSideNav()
  initializeWavesEffect()
  initializeDropdown()
  preventOnClick()
  removeNavbarShadowOnTop()
  fixTurbolinksCache()

autoScrollFixedSideNav = ->
  scrollSpeed = 50
  $('.side-nav.fixed').on 'mousewheel', (event) ->
    return if event.originalEvent.deltaY == 0

    if event.originalEvent.deltaY < 0
      $(this).scrollTop $(this).scrollTop() - scrollSpeed
    else
      $(this).scrollTop $(this).scrollTop() + scrollSpeed

initializeWavesEffect = ->
  $('.waves-effect').addClass('waves-light')
  Waves.displayEffect()

initializeDropdown = ->
  $('.dropdown-button').dropdown
    belowOrigin: true,
    stopPropagation: true
    constrainWidth: false

preventOnClick = ->
  $('.persistent').click (e) ->
    e.preventDefault()

removeNavbarShadowOnTop = ->
  $(window).scroll ->
    if $(window).scrollTop() == 0
      $('#top-navbar').addClass('z-depth-0')
    else
      $('#top-navbar').removeClass('z-depth-0')

checkForInput = (element) ->
  label = $(element).siblings('label')
  if $(element).val().length > 0
    label.addClass 'active'
  else
    label.removeClass 'active'

window.fixTurbolinksCache = ->
  window.materializeForm.init()
  $('input, textarea').each ->
    checkForInput this
