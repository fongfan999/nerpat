class Skills
  constructor: ->
    @skills = $("#profile-skills")
    @setup() if @skills.length > 0
    @skillsInput = $("#profile-skills-input")

  setup: ->
    _this = this

    $.get "/skills.json", (data) ->
      _this.initializeSkillsChips( data, _this.getIgnoredData() )
      _this.listenChips(data)

  initializeSkillsChips: (data, ignoredData = []) ->
    _this = this

    @skillsInput.material_chip
      autocompleteOptions:
        data: _this.getSkillsData(data, ignoredData)
        limit: 5

  listenChips: (data) ->
    _this = this

    @skillsInput.on "chip.add", (e, chip) ->
      ignoredData = _this.getIgnoredData()
      # Remove and return if this chip has already existed
      if ignoredData.indexOf(chip.tag) > -1
        $(this).find(".chip").remove()
        return true

      # Append the chip and input for updating
      hiddenInput = $("<input>").attr
        type: "hidden"
        name: "profile[skill_ids][]"
        value: _this.getSkillId(data, chip)
      _this.skills.append hiddenInput, $(this).find(".chip")

      # Append this chip to ignoredData and re-initialize autocomplete
      ignoredData.push chip.tag
      _this.initializeSkillsChips(data, ignoredData)

    # Listen on chip.delete
    @skills.on "click", ".chip i.close", ->
      # Remove the chip and re-initialize autocomplete
      currentChip = $(this).closest("div")
      currentChip.prev("input").remove()
      currentChip.remove()

      _this.initializeSkillsChips(data, _this.getIgnoredData())

  getSkillId: (data, chip) ->
    chipId = null

    if data[chip.tag]
      chipId = data[chip.tag].id
    else
      # Create one if not exist
      $.ajax
        async: false
        method: "POST"
        url: "/skills"
        data: { name: chip.tag }
        success: (chip) ->
          chipId = chip.id

    return chipId

  getSkillsData: (data, ignoredData) ->
    console.log ignoredData
    # Extract as Materialize Chips format
    chipsData = {}
    $.each data, (key, val) ->
      console.log ignoredData.indexOf(key)
      return if ignoredData.indexOf(key) > -1
      chipsData[key] = val.img

    console.log chipsData 
    return chipsData

  getIgnoredData: ->
    # Remove line breaks and the last 5 characters (close)
    $.map @skills.find(".chip"), (skill) ->
      skill.textContent.replace(/\n|\s{2,}/g, '').slice(0, -5)

$(document).on "turbolinks:load", ->
  new Skills()
