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
			checkGameState = $.ajax({
				url: '/users/'+userId+'/edit',
				type: 'GET',
				data: userInfectedState
			})

			checkGameState.done(function(results){
				game_active = results["game_active"] || false
				game_over = results["game_over"] || false
				
				if (game_active == false){
					$('#footer').css('visibility', 'hidden')
					this.stopPolling()
					this.view.appendFeed(game_over);
				} else {
					this.handleGameLogic(results)
				}
			}.bind(this))
			checkGameState.fail(function(results){
			})
		}
	},

	handleGameLogic: function(results){
		// console.log(results)
		// debugger
		gameState  = results["game_state"]
		infectedState = results["infected_state"]
		posts = results["html_content"];
		opponentCount = results["opponents"]
		points = results["points"]
		handle = results["handle"]

		this.view.updateStatsAndHandle(posts,opponentCount,points,handle)
		
		if (infectedState == true) {
			this.view.renderZombie()
		} else if (infectedState == false && gameState == "harvest") {
			this.view.renderHumanHarvest()
		} else if (infectedState == false && gameState == "cure") {
			this.view.renderHumanCure()
		} else {// player is human and game_state is "waiting to harvest"
			this.view.renderHumanWaiting()
		}
	},


}