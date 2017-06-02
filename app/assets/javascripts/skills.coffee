class window.Skills
  constructor: ->
    @skillsInput = $("#profile-skills-input")
    @setup() if @skillsInput.length > 0
    @skills = $( @skillsInput.data("behavior") )

  setup: ->
    self = this

    $.get "/skills.json", (data) ->
      self.initializeSkillsChips( data, self.getIgnoredData() )
      self.listenChips(data)

  initializeSkillsChips: (data, ignoredData = []) ->
    self = this

    @skillsInput.material_chip
      secondaryPlaceholder: "+ Thêm kỹ năng"
      autocompleteOptions:
        data: self.getSkillsData(data, ignoredData)
        limit: 5

  listenChips: (data) ->
    self = this

    @skillsInput.on "chip.add", (e, chip) ->
      ignoredData = self.getIgnoredData()
      # Remove and return if this chip has already existed
      if ignoredData.indexOf(chip.tag) > -1
        $(this).find(".chip").remove()
        return true

      # Append the chip and input for updating
      hiddenInput = $("<input>").attr
        type: "hidden"
        name: "profile[skill_ids][]"
        value: self.getSkillId(data, chip)
      self.skills.append hiddenInput, $(this).find(".chip")

      # Append this chip to ignoredData and re-initialize autocomplete
      ignoredData.push chip.tag
      self.initializeSkillsChips(data, ignoredData)

    # Listen on chip.delete
    @skills.on "click", ".chip i.close", ->
      # Remove the chip and re-initialize autocomplete
      currentChip = $(this).closest("div")
      currentChip.prev("input").remove()
      currentChip.remove()

      self.initializeSkillsChips(data, self.getIgnoredData())

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
    # Extract as Materialize Chips format
    chipsData = {}
    $.each data, (key, val) ->
      return if ignoredData.indexOf(key) > -1
      chipsData[key] = val.img

    return chipsData

  getIgnoredData: ->
    # Remove line breaks and the last 5 characters (close)
    $.map @skills.find(".chip"), (skill) ->
      skill.textContent.replace(/\n|\s{2,}/g, '').slice(0, -5)
