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
				game_active = results["game_active"] || false
				game_over = results["game_over"] || false

				if (game_active == false){
					$('#footer').css('visibility', 'hidden')
					this.stopPolling()
					this.view.appendFeed(game_over);
				} else {
					this.view.appendFeed(posts);
					this.view.updateOpponentCount(opponentCount);
					this.view.updatePoints(points);
					this.view.updateHandle(handle);
				}
			}.bind(this))
			updateFeedAndStats.fail(function(results){
			})
		}
	},
}