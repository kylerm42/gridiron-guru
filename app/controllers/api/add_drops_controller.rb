class Api::AddDropsController < ApplicationController
  def create
    if params[:team_id]
      @team = Team.find(params[:team_id])
    elsif params[:league_id]
      @team = current_user.teams
                          .includes(:roster_spots)
                          .find_by_league_id(params[:league_id])
    end

    @add_drop = AddDrop.new(team_id: @team.id)

    if params[:added_player_id]
      @add_drop.added_players.new(player_id: params[:added_player_id])
      @team.roster_spots.new(player_id: params[:added_player_id])
    end
    if params[:dropped_player_id]
      @add_drop.dropped_players.new(player_id: params[:dropped_player_id])
      @dropped = @team.roster_spots.find_by_player_id(params[:dropped_player_id])
      @dropped.destroy
    end

    if @add_drop.save && @team.save
      render json: @dropped
    else
      set_flash(:error, @add_drop.errors.full_messages)
      set_flash(:error, @team.errors.full_messages)
      render json: flash[:error]
    end
  end
end
