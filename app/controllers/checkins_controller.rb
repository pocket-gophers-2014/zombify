class CheckinsController < ApplicationController
  def create
    current_ingredient = Ingredient.where(discovered: true, harvested: false).first
    if distance([current_ingredient.latitude.to_f, current_ingredient.longitude.to_f],[params[:userLat].to_f, params[:userLong].to_f]) < 100

      @user = User.find(session[:id])
      @user.update_attributes(points: @user.points += 200)
      current_ingredient.update_attributes(counter: current_ingredient.counter += 1)
      @response = "You have harvested #{current_ingredient.name}"
      # //create a post for humans to see
      # //display response to human: "location verified. You have harvested the ingredient" or "something went wrong."
    else
      @response = "Fire and desolation have affected this area. You cannot find the necessary type of #{current_ingredient.name}."
    end
      render json: @response #, :locals => { response: @response }
  end
  def distance(a, b)
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlon_rad = (b[1]-a[1]) * rad_per_deg  # Delta, converted to rad
    dlat_rad = (b[0]-a[0]) * rad_per_deg

    lat1_rad, lon1_rad = a.map! {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = b.map! {|i| i * rad_per_deg }

    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math.asin(Math.sqrt(a))

    rm * c # Delta in meters

  end

  

end