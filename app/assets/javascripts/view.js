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
		$('#login_signup').remove()
    $('p').remove()
    $('#center').append(response)
	},

	updateOpponentCount: function (opponents){
		$("#opponents_remaining").empty()
		$("#opponents_remaining").text(opponents)
	},
	
	updatePoints: function(points){
		$('#your_points').empty()
		$('#your_points').text(points)
	},
	updateHandle: function(handle){
		$('#handle').empty()
		$('#handle').text(handle)
	},
}