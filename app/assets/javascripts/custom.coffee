$(document).on 'turbolinks:load', ->
  initializeWavesEffect()
  initializeDropdown()
  preventOnClick()
  removeNavbarShadowOnTop()
  fixTurbolinksCache()

initializeWavesEffect = ->
  $('.waves-effect').addClass('waves-light')
  Waves.displayEffect()

initializeDropdown = ->
  $('.dropdown-button').dropdown
    belowOrigin: true,
    stopPropagation: true

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

fixTurbolinksCache = ->
  window.materializeForm.init()
  $('input, textarea').each ->
    checkForInput this
