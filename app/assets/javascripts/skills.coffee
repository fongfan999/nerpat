class Skills
  constructor: ->
    @skills = $("#profile-skills")
    @setup() if @skills.length > 0
    @skillsInput = $("#profile-skills-input")

  setup: ->
    _this = this

    $.get "/skills.json", (data) ->
      _this.listenChips(data)
      _this.initializeChips(data)

  listenChips: (data) ->
    _this = this

    @skillsInput.on "chip.add", (e, chip) ->
      # Append the chip and input for updating
      hiddenInput = $("<input>").attr
        type: "hidden"
        name: "profile[skill_ids][]"
        value: _this.getChipId(data, chip)

      _this.skills.append hiddenInput, $(this).find('.chip')

    # Listen on chip.delete
    @skills.on "click", ".chip i.close", ->
      # Remove the chip and re-initialize autocomplete
      $(this).closest('div').prev('input').remove()
      _this.initializeChips(data)

  initializeChips: (data) ->
    _this = this

    @skillsInput.material_chip
      autocompleteOptions:
        data: _this.getChipsData(data)
        limit: Infinity

  getChipId: (data, chip) ->
    chipId = null

    if data[chip.tag]
      chipId = data[chip.tag].id
    else
      # Create one if it not exist
      $.ajax
        async: false
        method: "POST"
        url: "/skills"
        data: { name: chip.tag }
        success: (chip) ->
          chipId = chip.id

    return chipId

  getChipsData: (data) ->
    # Extract as Materialize Chips format
    chipsData = {}
    for skill in Object.keys(data)
      chipsData[skill] = null

    return chipsData

$(document).on "turbolinks:load", ->
  new Skills()
