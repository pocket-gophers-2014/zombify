var CheckinController = {

  bindEvents: function(){
    $("#checkin").click(this.initiate_geolocation);
  },
  initiate_geolocation: function() {
    navigator.geolocation.getCurrentPosition(CheckinController.handle_geolocation_query, CheckinController.handle_errors);
  },
  handle_geolocation_query: function(e){
    console.log(e)
    var userLat = e.coords.latitude
    var userLong = e.coords.longitude
    CheckinController.compareLocation(userLat, userLong)


  }, 
  handle_errors: function(error){
  switch(error.code)
    {
      case error.PERMISSION_DENIED: alert("user did not share geolocation data");
      break;

      case error.POSITION_UNAVAILABLE: alert("could not detect current position");
      break;

      case error.TIMEOUT: alert("retrieving position timed out");
      break;

      default: alert("unknown error");
      break;
    }
  }, 

  compareLocation: function(lat, long){
    $.ajax({
      url: '/checkins/new', 
      type: 'GET', 
      data: {userLat: lat, userLong: long}
    })
  }
}