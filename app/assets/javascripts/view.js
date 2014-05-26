function View(){
	this.dataId = $('#feed').data('user-id')
	this.dataInfectedState = $('#feed').data('user-infected')
	this.urlLocation= document.location.href
	this.loginButton = $('#log_in')
	this.signupButton = $('#sign_up')
}

View.prototype = {
	appendFeed: function(posts){
		$('#feed').empty()
		$('#feed').prepend(posts)
	},
	appendForm: function(response){
		console.log("in the append form")
		$('#login_signup').remove()
    $('p').remove()
    $('#center').append(response)
	}
}