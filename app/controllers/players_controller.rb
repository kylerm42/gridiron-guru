class PlayersController < ApplicationController
  def index
    @players = Player.all.sample(50)
    @team = current_user.teams.find_by_league_id(params[:league_id])
  end
end
