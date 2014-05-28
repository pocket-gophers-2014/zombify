function pollingController(view){
	this.timer = 1000
	this.pollingTimerId = 0
	this.view = view
}

pollingController.prototype = {
	startPolling: function() {
			this.pollingTimerId = setInterval(this.pollAjax.bind(this), this.timer);
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
				posts = results["html_content"];
				opponentCount = results["opponents"]
				points = results["points"]
				handle = results["handle"]

				console.log(opponentCount)

				this.view.appendFeed(posts);
				this.view.updateOpponentCount(opponentCount);
				this.view.updatePoints(points);
				this.view.updateHandle(handle);
			}.bind(this))

			updateFeedAndStats.fail(function(results){
			})
		}
	},
}