function pollingController(){
	this.timer = 1000
	this.pollingTimerId = 0
}

pollingController.prototype = {
	startPolling: function() {
		console.log('creating timer')
		this.pollingTimerId = setInterval(this.pollAjax.bind(this), this.timer);
	},

	pollAjax: function() {
		if (false) {
			clearInterval(this.pollingTimerId)
		} else {
			console.log('about to run ajax')
			updateFeedAndStats = $.ajax({
				url: '/users/'+$('#feed').data('user-id')+'/edit',
				type: 'GET',
				data: $('#feed').data('user-infected')
			})

			updateFeedAndStats.done(function(results){
				posts = results["html_content"]
				$('#feed').empty()
				$('#feed').prepend(posts)

			}.bind(this))

			updateFeedAndStats.fail(function(results){

			})
		}
	},

	appendFeed: function(posts){
		$('#feed').empty()
		for (var i = 0; i < posts.length; i++) {
			$('#feed').prepend(posts[i])
		}
	},
}