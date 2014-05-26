var BattleController = {
  bindEvents: function(polling) {
    polling.stopPolling();
    $('#confront').on('ajax:success', this.renderBattleForm.bind(this));
    $('#feed').on('submit', 'form#new-battle', this.launchBattle.bind(this));
  },
  launchBattle: function(){
    event.preventDefault();
    var opponent = $( '#new-battle' ).serialize();
    var battle = new Battle();
    var result = battle.determineFate();
    this.battleAjaxRequest(opponent, result)
  },
  renderBattleForm: function(event, response) {
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
    console.log(response)
    $('#feed').empty()
    $('#feed').prepend(response)

  }
}




//enter number, check against database,  display result, send info to server, your view updates stats,