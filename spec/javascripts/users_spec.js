describe("UserAuthenticationAjax", function () {
  describe("bindEvents", function() {
    xit("binds a click event on login", function() {

      loadFixtures('login.html');
      spyOn(UserAuthenticationAjax, 'initiateLogIn');

      $('#login').on('click', function() {
        UserAuthenticationAjax.initiateLogIn();
      }).click();
      expect(UserAuthenticationAjax.initiateLogIn).toHaveBeenCalled()
    });
  });
});
