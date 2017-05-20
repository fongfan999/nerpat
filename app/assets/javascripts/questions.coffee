$(document).on "turbolinks:load", ->
  addAnswerForm()
  cancelAnswer()

addAnswerForm = ->
  $('.add-answer-placeholder').click ->
    $(this).find('div').addClass('active-editor')
    $('.answer-form').slideDown('fast')
    $('.answer-form textarea').focus()

cancelAnswer = ->
  $('.cancel-answer').click ->
    $('.answer-form').slideUp('fast')
    $('.add-answer-placeholder div').removeClass('active-editor')