class CheckinsController < ApplicationController
  ACCEPTABLE_RANGE_TO_INGREDIENT = 1000


  def new
    @user = User.find(session[:id])
    ingredient = Ingredient.where(discovered: true, harvested: false).first

    if ingredient
      render :text => ingredient_in_range?(ingredient) ?  log_success(ingredient) : log_failure(ingredient)
    else 
      render :text => "Scientists have not determined any cure ingredients to harvest at this time."
    end

  end

    private

    def ingredient_in_range?(ingredient)
      distance = DistanceCalculator.new(ingredient.latlong, user_latlong).distance
      distance < ACCEPTABLE_RANGE_TO_INGREDIENT
    end

    def user_latlong
      [params[:userLat].to_f, params[:userLong].to_f]
    end

    def log_success(ingredient)
      Checkin.log_individual_checkin(@user, ingredient)
      "You have harvested #{ingredient.name}"
    end

    def log_failure(ingredient)
      Post.create(body:"#{@user.name} has failed to harvest any #{ingredient.name}", title:"#{ingredient.name} not found", audience:"human")
        "Fire and desolation have affected this area. You cannot find the necessary type of #{ingredient.name}."
    end

end
