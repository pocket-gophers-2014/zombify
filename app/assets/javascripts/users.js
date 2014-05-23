// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).ready(function() {
  $('#login').on('click', initiateLogIn);
  $('#signup').on('click', initiateSignUp);
});



function initiateLogIn() {
  $.ajax({
    url: '/sessions/new',
    method: 'get'
  })
  .done(appendForm)
}

function initiateSignUp() {
  $.ajax({
    url: '/users/new',
    method: 'get'
  })
  .done(appendForm)
}

function appendForm(response) {
  console.log("yay")
  $('#login_signup').remove()
  $('.header').append(response)
}