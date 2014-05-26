describe("Battle", function () {
  describe("mixItUp", function() {
    it("returns a randomly generate number between 0 and 1", function() {
      var battle = new Battle
      var randomNumber = battle.mixItUp()
      expect(randomNumber).toBeLessThan(1)
    })
  })

  describe("determineFate", function() {
    it("returns true when mixItUp returns less than 0.5", function() {
      var battle = new Battle
      spyOn(battle, "mixItUp").and.returnValue(0.2)
      expect(battle.determineFate()).toBe(true)
    })

    it("returns false when mixItUp returns greater than 0.5", function() {
      var battle = new Battle
      spyOn(battle, "mixItUp").and.returnValue(0.6)
      expect(battle.determineFate()).toBe(false)
    })
  })
})

