$(document).on 'turbolinks:load', ->
  updateFileNameOnChange()

updateFileNameOnChange = ->
  $("#profile_avatar").on "change", ->
    $(".settings-account small").text $(this).val().split("\\").pop()
