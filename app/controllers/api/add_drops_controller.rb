class Api::AddDropsController < ApplicationController
  def create
    if params[:team_id]
      @team = Team.includes(:roster_spots,
                            received_trades: :receive_players,
                            sent_trades: :send_players)
                  .find(params[:team_id])
    elsif params[:league_id]
      @team = current_user.teams
                          .includes(:roster_spots, :received_trades, :sent_trades)
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
      @sent_trades = Trade.where(sender_id: @team.id)
      p @sent_trades
      @sent_trades.select do |trade|
        p "sent_trades"
        p trade
        p trade.send_players
        p params[:dropped_player_id]
        trade.send_players.any? do |player|
          player.id == params[:dropped_player_id]
        end
      end.each { |trade| trade.destroy }
      @received_trades = Trade.where(receiver_id: @team.id)
      p @received_trades
      @received_trades.select do |trade|
        p "received_trades"
        p trade
        p trade.receive_players
        trade.receive_players.any? do |player|
          player.id == params[:dropped_player_id]
        end
      end.each { |trade| trade.destroy }

      @dropped.destroy
    end

    if @add_drop.save && @team.save
      render json: @dropped
    else
      render json: flash[:error]
    end
  end
end
