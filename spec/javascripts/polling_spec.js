describe("pollingController", function() {
  beforeEach(function() {
    var polling = new pollingController
  })

  it("is defined", function() {
    expect(pollingController).toBeDefined()
  })

  it("has a startPolling method", function() {
    expect(polling.startPolling).toBeDefined()
  })

  it("updates pollingTimerId on startPolling", function() {
    polling.startPolling()
    expect(polling.pollingTimerId).toBeGreaterThan(0)
  })


})




