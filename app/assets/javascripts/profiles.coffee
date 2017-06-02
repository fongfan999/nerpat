$(document).on "turbolinks:load", ->
  $("#edit-profile-btn").on "ajax:success", ->
    editProfileModal = $('#edit-profile-modal')
    editProfileModal.modal()
    editProfileModal.modal('open')

    window.fixTurbolinksCache()
    editProfileModal.find('form').enableClientSideValidations()
    new window.Skills()
