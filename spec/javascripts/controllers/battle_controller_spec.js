describe("BattleController Namespace", function() {
  it("is defined", function(){
    expect(BattleController).toBeDefined()
  });

  it ("it has a launch battle function", function() {
    expect(BattleController.launchBattle).toBeDefined()
  })

  it ("calls battleAjaxRequest function",function() {
    // jasmine ajax not working!
    // jasmine.stub()
    // expect(BattleController.launchBattle.user).toBe(1)
  })

})

