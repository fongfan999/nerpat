class Skills
  constructor: ->
    @skillsInput = $("#profile-skills-input")
    @setup() if @skillsInput.length > 0
    @skills = $( @skillsInput.data("behavior") )

  setup: ->
    _this = this

    $.get "/skills.json", (data) ->
      _this.initializeSkillsChips( data, _this.getIgnoredData() )
      _this.listenChips(data)

  initializeSkillsChips: (data, ignoredData = []) ->
    _this = this

    @skillsInput.material_chip
      secondaryPlaceholder: "+ Thêm kỹ năng"
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

$(document).on "turbolinks:load", ->
  $("#edit-profile-btn").on "ajax:success", ->
    editProfileModal = $('#edit-profile-modal')
    editProfileModal.modal()
    editProfileModal.modal('open')

    window.fixTurbolinksCache()
    editProfileModal.find('form').enableClientSideValidations()
    new Skills()
