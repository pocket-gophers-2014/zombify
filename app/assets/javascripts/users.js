// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var UserAuthenticationAjax = {
  bindEvents: function() {
    $('#log_in').on('click', UserAuthenticationAjax.initiateLogIn);
    $('#sign_up').on('click', UserAuthenticationAjax.initiateSignUp);
  },
  initiateLogIn: function() {
    $.ajax({
      url: '/sessions/new',
      method: 'get'
    })
    .done(UserAuthenticationAjax.appendForm)
  },

  initiateSignUp: function() {
    $.ajax({
      url: '/users/new',
      method: 'get'
    })
    .done(UserAuthenticationAjax.appendForm)
  },

  appendForm: function(response) {
    $('#login_signup').remove()
    $('p').remove()
    $('#center').append(response)
  },
}

$( document ).ready(function() {
  UserAuthenticationAjax.bindEvents();
  BattleController.bindEvents();
  CheckinController.bindEvents();
  var polling = new pollingController();
  polling.startPolling() 
});

