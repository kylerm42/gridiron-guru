class WatchedPlayersController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    @watched_player = @team.watched_player_joins.new(player_id: params[:player_id])
    p @watched_player

    unless @team.save
      set_flash(:error, @team.errors.full_messages)
    end

    head :ok
  end

  def index
    @team = Team.find(params[:team_id])
    @watched_players = @team.watched_players
    @watched_player_joins = @team.watched_player_joins
    render :index
  end

  def destroy
    @watched_player = WatchedPlayer.find(params[:id])
    @watched_player.destroy!

    head :ok
  end
end
