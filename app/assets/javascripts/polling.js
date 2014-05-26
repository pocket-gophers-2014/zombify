function pollingController(){
	this.timer = 1000
	this.pollingTimerId = 0
}

pollingController.prototype = {
	startPolling: function() {
		console.log('creating timer')
		if (document.location.href.indexOf("users") !== -1) {
			console.log
		this.pollingTimerId = setInterval(this.pollAjax.bind(this), this.timer);
		}
	},

	stopPolling: function() {
		clearInterval(this.pollingTimerId)
	},

	pollAjax: function() {
		if (false) {
			this.stopPolling()
		} else {
			console.log('about to run ajax')
			updateFeedAndStats = $.ajax({
				url: '/users/'+$('#feed').data('user-id')+'/edit',
				type: 'GET',
				data: $('#feed').data('user-infected')
			})

			updateFeedAndStats.done(function(results){
				posts = results["html_content"]
				this.appendFeed(posts)
			}.bind(this))

			updateFeedAndStats.fail(function(results){
			})
		}
	},

	appendFeed: function(posts){
		$('#feed').empty()
		$('#feed').prepend(posts)
	},
}