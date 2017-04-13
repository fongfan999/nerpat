$(document).on 'turbolinks:load', ->
  fixTurbolinksCache()
  nerpatRequestsDropdown()

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

nerpatRequestsDropdown = ->
  $("#nerpat-requests-button").click (e) ->
    e.preventDefault()
    $(this).closest('li').addClass('active')
    $('#notifications').slideToggle()

  $(document).click (e)->
    if !e.target.className.includes('hide-on-outside')
      $("#notifications").hide()
      $("#nerpat-requests-button").closest('li').removeClass('active')
