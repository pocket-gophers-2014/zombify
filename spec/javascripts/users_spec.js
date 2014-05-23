describe("UserAuthenticationAjax", function () {
  describe("bindEvents", function() {


    xit("binds aclick event on login", function() {
      spyOn(UserAuthenticationAjax, 'initiateLogIn');
      loadFixtures('login.html');
      $('#login').click()
      expect(UserAuthenticationAjax.initiateLogIn).toHaveBeenCalled()
    });
  });


  // beforeEach( function() {
  //   var spyEvent = spyOnEvent($('#login'), 'click');
  // });

  // it("clicks the #login", function() {
  //   $("#login").click();
  //   expect('click').toHaveBeenTriggeredOn($('#login'));
  // });


  // describe("initiateLogIn", function() {
  //     var configuration = { url: "/sessions/new",
  //                           method: "get"
  //                         };
  // });

  // it("should make an Ajax request to the correct URL", function() {
  //   spyOn($, "ajax");
  //   sendRequest(undefined, configuration);
  //   expect($.ajax.mostRecentCall.args[0]["url"]).toEqual(configuration.url);
  // });
});


