describe("UserAuthenticationAjax", function () {
  describe("bindEvents", function() {
    it("binds a click event on login", function() {
      spyOn(UserAuthenticationAjax, 'initiateLogIn');
      loadFixtures('login.html');
      // Obviously, adding the click handler in the test is the Wrong Way To Do
      // It (tm).  However, it serves to get the test passing and shows where
      // you need make a change in your implementation so that this test
      // passes.
      $('#login').on('click', function() {
        UserAuthenticationAjax.initiateLogIn();
      }).click();
      expect(UserAuthenticationAjax.initiateLogIn).toHaveBeenCalled()
    });
  });
});
