$(document).on 'turbolinks:load', ->
  initializeWavesEffect()
  initializeDropdown()
  preventOnClick()
  removeNavbarShadowOnTop()
  fixTurbolinksCache()
  navbarDropdown()

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

navbarDropdown = ->
  registeredButtons = "#nerpat-requests-button, #notifications-button"
  registeredDropdowns = "#nerpat-requests, #notifications"

  hideAllDropdowns = ->
    $(registeredDropdowns).hide()
    $(registeredButtons).closest('li').removeClass('active')

  $(registeredButtons).click (e) ->
    e.preventDefault()
    hideAllDropdowns()

    $(this).closest('li').addClass('active')
    $("##{e.currentTarget.id.replace('-button', '')}").slideDown()

  # Click outside of the box
  $(document).click (e)->
    unless registeredButtons.includes($(e.target).closest('a').attr('id'))
      hideAllDropdowns()
