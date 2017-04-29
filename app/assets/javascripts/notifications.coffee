$(document).on 'turbolinks:load', ->
  navbarDropdown()

navbarDropdown = ->
  registeredButtons = "#nerpat-requests-button, #notifications-button"
  registeredDropdowns = "#nerpat-requests, #notifications"
  
  # Remove badge when notificatioins size is zero
  $('.badge-with-icon').each ->
    if parseInt($(this).text()) == 0
      $(this).hide()

  $(registeredButtons).on "ajax:beforeSend", (e) ->
    dropdownBox = $("##{e.currentTarget.id.replace('-button', '')}")
    dropdownBox .find('.preloader-wrapper').show()
    dropdownBox.slideDown()

    $(this).closest('li').addClass('active')
    $(this).find('.badge-with-icon').hide()

    # Stop calling ajax when the box has already loaded
    return false if dropdownBox.find('ul li').length > 1

  # Hide all dropdonws when users click outside of the box
  $('html, #user-dropdown-button, .button-collapse').click ->
    $(registeredDropdowns).hide()
    $(registeredButtons).closest('li').removeClass('active')
