$(document).on 'turbolinks:load', ->
  $('.remove-nerpat-btn').on 'ajax:success', ->
    $(this).closest('.user').fadeOut('slow')

