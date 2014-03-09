class PlayersController < ApplicationController
  def index
    @players = Player.all
    @team = current_user.teams.find_by_league_id(params[:league_id])
  end
end
