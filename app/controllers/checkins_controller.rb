class CheckinsController < ApplicationController
  def create
    params[:userLat]
    params[:userLong]
    current_ingredient = Ingredient.where(discovered: true && harvested: false).last

    # //check user location against cure location
    # //if a match, give user points and increase counter on cure ingredient
    # //create a post for humans to see
    # //display response to human: "location verified. You have harvested the ingredient" or "something went wrong."

    redirect_to root_path
  end
end