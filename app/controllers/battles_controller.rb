class BattlesController < ApplicationController
  def new
    @user = User.find(session[:id])
   #@opponent = User.find()
    render partial: "battles/new", :locals => { user: @user }
  end
  def show
    #@game = Game.find(params[:id])
  end


end