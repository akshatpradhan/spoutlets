describe "Entries", ->

  describe "clicking the 'been there' button", ->
    beforeEach ->
      well = affix("div.well")
      well.affix(".row span2 span[data-id=been-there]")
      well.affix(".row span2 button[data-action=been-there]")
      @button = $('button[data-action="been-there"]')
      @badge = $('span[data-id="been-there"]')
      @button.toggleBeenThere()

    describe "when the button is 'off'", ->
      beforeEach ->
        @badge.html("0")
        @button.click()
      it "should increase the 'been there' counter and turn the button 'on'", ->
        expect(@button.attr("class")).toBe("active")
        expect(@badge.text()).toBe("1")

    describe "when the button is 'on'", ->
      beforeEach ->
        @badge.html("1")
        @button.addClass("active")
        @button.click()
      it "should decrease the 'been there' counter and turn the button 'off'", ->
        expect(@badge.text()).toBe("0")
