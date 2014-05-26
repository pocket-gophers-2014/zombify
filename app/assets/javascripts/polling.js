function pollingController(view){
	this.timer = 1000
	this.pollingTimerId = 0
	this.view = view
}

pollingController.prototype = {
	startPolling: function() {
		console.log('creating timer')
		url = this.view.urlLocation
		if (url.indexOf("users") !== -1) {
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
			userId = this.view.dataId
			userInfectedState = this.view.dataInfected
			updateFeedAndStats = $.ajax({
				url: '/users/'+userId+'/edit',
				type: 'GET',
				data: userInfectedState
			})

			updateFeedAndStats.done(function(results){
				posts = results["html_content"]
				this.view.appendFeed(posts)
			}.bind(this))

			updateFeedAndStats.fail(function(results){
			})
		}
	},
}