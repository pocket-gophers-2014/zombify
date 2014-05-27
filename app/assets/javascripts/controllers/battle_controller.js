var BattleController = {
  bindEvents: function(polling) {
    $('#confront').on('ajax:success', this.renderBattleForm.bind(polling));
    $('#feed').on('submit', 'form#new-battle', this.launchBattle.bind(this));
  },
  launchBattle: function(){
    event.preventDefault();
    var opponent = $( '#new-battle' ).serialize();
    var battle = new Battle();
    var result = battle.determineFate();
    BattleController.battleAjaxRequest(opponent, result)
  },
  renderBattleForm: function(event, response) {
    this.stopPolling()
    console.log("Sha Sha")
    $('#feed').empty()
    $('#feed').prepend(response)
  },
  battleAjaxRequest: function(opponent, result){
    console.log("inferno")
    $.ajax({
      url: 'update',
      type: 'PUT',
      data: {opponent: opponent, result: result}
    })

    .done(this.renderBattleResults)
  },
  renderBattleResults: function(response){
    console.log("!!!!!!!!!!!!!!!!!!!!!!!!!")
    console.log(response)
    $('#feed').empty()
    $('#feed').prepend(response)
    $('.confirm').on('click', BattleController.returnToFeed)
  },
  returnToFeed: function() {
    location.reload()
  }
}




//enter number, check against database,  display result, send info to server, your view updates stats,