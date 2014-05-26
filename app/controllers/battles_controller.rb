class BattlesController < ApplicationController
  def new
    @user = User.find(session[:id])
    render partial: "battles/new", :locals => { user: @user }
  end
  def show
  end


end