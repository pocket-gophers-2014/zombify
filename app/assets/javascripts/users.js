// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var UserAuthenticationAjax = {
  bindEvents: function() {
    $('#login').on('click', UserAuthenticationAjax.initiateLogIn);
    $('#signup').on('click', UserAuthenticationAjax.initiateSignUp);
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
  }
}

$( document ).ready(function() {
  UserAuthenticationAjax.bindEvents();
});

