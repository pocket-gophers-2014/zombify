function UserAuthenticationAjax(view) {
  this.view = view
}

UserAuthenticationAjax.prototype = {
  bindEvents: function() {
    $(this.view.loginButton).on("click", this.initiateLogIn.bind(this))
    $(this.view.signupButton).on("click", this.initiateSignUp.bind(this))
  },

  initiateLogIn: function() {
    getSignIn = $.ajax({
      url: '/sessions/new',
      method: 'get'
    })
    getSignIn.done(function(response){
      this.view.appendForm(response)
    }.bind(this))
  },

  initiateSignUp: function() {
    console.log(this.view)
    getSignUp = $.ajax({
      url: '/users/new',
      method: 'get'
    })
    getSignUp.done(function(results){
      this.view.appendForm(results)}.bind(this))
  },
}

$( document ).ready(function() {
  view = new View();
  userAuth = new UserAuthenticationAjax(view);
  userAuth.bindEvents();
  var polling = new pollingController(view);
  polling.startPolling();
  BattleController.bindEvents(polling);
  UserAuthenticationAjax.bindEvents();
  BattleController.bindEvents();
  CheckinController.bindEvents();
});

