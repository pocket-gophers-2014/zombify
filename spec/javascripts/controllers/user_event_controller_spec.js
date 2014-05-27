returnTypeOf = function(object){
  return Object.prototype.toString.apply(object)
}

describe("Checkin Controller Namespace", function() {
  it("is defined", function(){
    expect(CheckinController).toBeDefined()
  });

})


