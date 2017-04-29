class Skills
  constructor: ->
    @skills = $("#profile-skills")
    @skillsInput = $("#profile-skills-input")
    @setup() if @skills.length > 0

  setup: ->
    _this = this

    $.getJSON "/available_skills.json", (data) ->
      _this.listenChips(data)
      _this.initializeChips(data)

  listenChips: (data) ->
    _this = this

    @skillsInput.on "chip.add", (e, chip) ->
      hiddenInput = $("<input>").attr
        type: "hidden"
        name: "profile[skill_ids][]"
        value: data[chip.tag].id

      _this.skills.append hiddenInput, $(this).find('.chip')

    # Remove hidden input
    @skills.on "click", ".chip i.close", ->
      $(this).closest('div').prev('input').remove()


  initializeChips: (data) ->
    _this = this

    @skillsInput.material_chip
      autocompleteOptions:
        data: _this.getChipsData(data)

  getChipsData: (data) ->
    chipsData = {}
    for skill in Object.keys(data)
      chipsData[skill] = null

    return chipsData

$(document).on "turbolinks:load", ->
  new Skills()

