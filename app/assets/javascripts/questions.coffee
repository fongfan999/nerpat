$(document).on "turbolinks:load", ->
  addAnswerForm()

addAnswerForm = ->
  answerPlaceholder = $('.add-answer-placeholder')
  inlineHeader = answerPlaceholder.find('div')
  answerFormWrapper = $('.answer-form-wrapper')

  answerPlaceholder.click ->
    inlineHeader.addClass('active-form')
    answerFormWrapper.slideDown('fast')

  answerPlaceholder.on 'ajax:success', ->
    answerForm = answerFormWrapper.find('form')
    answerForm.enableClientSideValidations()
    answerForm.find('textarea').focus()

    $('.cancel-answer').click ->
      answerFormWrapper.slideUp('fast')
      # answerForm.resetClientSideValidations()
      inlineHeader.removeClass('active-form')
