var BattleController = {
  bindEvents: function() {
    $('#battle_box').on('submit', 'form#new-battle', this.launchBattle.bind(this));
  },
  launchBattle: function(){
    event.preventDefault();
    var opponent = $( '#new-battle' ).serialize();
    var battle = new Battle();
    var result = battle.determineFate();
    var user = $('#feed').data()["userId"]
    BattleController.battleAjaxRequest(opponent, result, user)
  },

  battleAjaxRequest: function(opponent, result, user){
    $.ajax({
      url: 'update',
      type: 'PUT',
      data: {opponent: opponent, result: result, id: user  }
    })
    //hit a route in the users controller
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