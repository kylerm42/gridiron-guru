class Api::AddDropsController < ApplicationController
  def create
    @team = current_user.teams.find_by_league_id(params[:league_id])
    @add_drop = AddDrop.new(team_id: @team.id)

    if params[:added_player_id]
      @add_drop.added_players.new(player_id: params[:added_player_id])
      @team.team_players.new(player_id: params[:added_player_id])
    end
    if params[:dropped_player_id]
      @add_drop.dropped_players.new(player_id: params[:dropped_player_id])
      @team.team_players.find_by_player_id(params[:dropped_player_id]).destroy
    end

    if @add_drop.save && @team.save
      render json: @add_drop
    else
      set_flash(:error, @add_drop.errors.full_messages)
      set_flash(:error, @team.errors.full_messages)
      render json: @add_drop.errors.full_messages
    end
  end

  # def create_old
  #   @team = Team.find(params[:team_id])
  #   @add_drop = AddDrop.new(team_id: @team.id)
  #   if params[:type] == "add"
  #     @add_drop.added_players.new(player_id: params[:player_id])
  #     @team.team_players.new(player_id: params[:player_id])
  #   elsif params[:type] == "drop"
  #     dropped_player = @add_drop.dropped_players.new(player_id: params[:player_id])
  #     @team.team_players.find_by_player_id(params[:player_id]).destroy
  #   end
  #
  #   unless @add_drop.save && @team.save
  #     set_flash(:error, @add_drop.errors.full_messages)
  #     set_flash(:error, @team.errors.full_messages)
  #   end
  #
  #   head :ok
  # end
end
