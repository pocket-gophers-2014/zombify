class GamesController < ApplicationController
  def index
    @games = Games.all#where(:game_active = 'true')
    render partial: "_index", :locals => { games: @games }
  end
  def show
    @game = Game.find(params[:id])
  end
end