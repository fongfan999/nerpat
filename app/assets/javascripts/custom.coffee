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
  
  # Remove badge when notificatioins size is zero
  $('.badge-with-icon').each ->
    if parseInt($(this).text()) == 0
      $(this).hide()

  hideAllDropdowns = ->
    $(registeredDropdowns).hide()
    $(registeredButtons).closest('li').removeClass('active')

  $(registeredButtons).on "ajax:beforeSend", (e) ->
    hideAllDropdowns()
    $(this).closest('li').addClass('active')
    $(this).find('.badge-with-icon').hide()

    dropdownBox = $("##{e.currentTarget.id.replace('-button', '')}")
    dropdownBox.slideDown()

    # Stop calling ajax when the box has already loaded
    return false if dropdownBox.find('ul li').length > 1

  # Hide all dropdonws when users click outside of the box
  $(document).click (e)->
    unless registeredButtons.includes($(e.target).closest('a').attr('id'))
      hideAllDropdowns()
