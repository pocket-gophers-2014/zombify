var BattleController = {
  bindEvents: function() {
    $('#new-battle').on('submit', this.launchBattle.bind(this));
  },
  launchBattle: function(){
    event.preventDefault();
    var opponent = $( '#new-battle' ).serialize();
    var battle = new Battle();
    var result = battle.determineFate();
    BattleController.battleAjaxRequest(opponent, result)
  },
  battleAjaxRequest: function(opponent, result){
    $.ajax({
      url: 'update',
      type: 'PUT',
      data: {opponent: opponent, result: result}
    })

    .done(this.renderBattleResults)
  },
  renderBattleResults: function(response){
    if (response["end"] == true ) {
      location.reload()
    } else {
      $('#battle_box').empty()
      $('#battle_box').prepend(response)
      $('.confirm').on('click', BattleController.returnToFeed)
    }
  },
  returnToFeed: function() {
    location.reload()
  }
}




//enter number, check against database,  display result, send info to server, your view updates stats,