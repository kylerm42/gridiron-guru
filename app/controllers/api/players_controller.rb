class Api::PlayersController < ApplicationController
  def index
    @players = Player.all.sample(50)
    render json: @players
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end
end
