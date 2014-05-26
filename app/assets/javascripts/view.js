function View(){
	this.dataId = $('#feed').data('user-id')
	this.dataInfectedState = $('#feed').data('user-infected')
	this.urlLocation= document.location.href
}

View.prototype = {
	appendFeed: function(posts){
		$('#feed').empty()
		$('#feed').prepend(posts)
	},
}