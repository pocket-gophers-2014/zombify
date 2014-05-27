class CheckinsController < ApplicationController
  def new
    @constants = {:meters_within_ingredient => 1000, :pts_gained_find_ingredient => 200, 
      :num_needed_to_harvest => 10}
    @current_ingredient = Ingredient.where(discovered: true, harvested: false).first
    @user = User.find(session[:id])
    ingredient_in_range? ? user_success_logic : show_failure_message

    render :text => @response 
  end

  ## ONLY HELPER METHODS BELOW
  ## ===================================

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

  def user_success_logic
    user_gains_points
    increment_ingredient_counter
    create_message_showing_personal_harvest
    complete_group_harvest_if_possible
  end


  def ingredient_in_range?
    distance([@current_ingredient.latitude.to_f, @current_ingredient.longitude.to_f], [params[:userLat].to_f, params[:userLong].to_f]) < @constants[:meters_within_ingredient]
  end

  def user_gains_points
    @user.update_attributes(points: @user.points += @constants[:pts_gained_find_ingredient])
  end

  def increment_ingredient_counter
    @current_ingredient.update_attribute(:counter, @current_ingredient.counter += 1)
  end

  def create_message_showing_personal_harvest
    @response = "You have harvested #{@current_ingredient.name}"
      Post.create(body:"#{@user.name} has harvested valuable #{@current_ingredient.name}", title:"#{@current_ingredient.name} harvested", audience:"human")
  end

  def complete_group_harvest_if_possible
    if @current_ingredient.counter == @constants[:num_needed_to_harvest]
      @current_ingredient.update_attributes(harvested: true)

      @zombie_message = Message.where(title: "#{@current_ingredient.name} gathered", audience: "zombie")[0]
      @human_message = Message.where(title: "#{@current_ingredient.name} gathered", audience: "human")[0] 

      Post.create(body: @zombie_message.description, title: @zombie_message.title, audience: "zombie")
      Post.create(body: @human_message.description, title: @human_message.title, audience: "human")

      @zombie_message.update_attributes(has_been_called: "true")
      @human_message.update_attributes(has_been_called: "true")
      #TODO: make next annoucement message dependent on this harvest
    end
  end

  def show_failure_message
    Post.create(body:"#{@user.name} has failed to harvest any #{@current_ingredient.name}", title:"#{@current_ingredient.name} not found", audience:"human")
      @response = "Fire and desolation have affected this area. You cannot find the necessary type of #{@current_ingredient.name}."
  end



end