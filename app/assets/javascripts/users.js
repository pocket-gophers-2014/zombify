// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).ready(function() {
  $('#login').on('click', initiateLogIn);
  $('#signup').on('click', initiateSignUp);
});



function initiateLogIn() {
  $.ajax({
    url: ,
    method: 'get'
  })
  .done(appendLogInForm)
}

function initiateLogIn() {
  $.ajax({
    url: ,
    method: 'get'
  })
  .done(appendForm)
}

function appendForm(response) {

}