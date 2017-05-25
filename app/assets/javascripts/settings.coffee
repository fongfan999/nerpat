$(document).on 'turbolinks:load', ->
  updateFileNameOnChange()

updateFileNameOnChange = ->
  $("#user_avatar").on "change", ->
    $(".settings-account small").text $(this).val().split("\\").pop()
