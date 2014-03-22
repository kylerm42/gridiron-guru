class Api::TradesController < ApplicationController
  def create
    @trade = Trade.new(trade_params)
    params[:trade_get_player_ids].each do |id|
      @trade.trade_players.new(trade_team_id: @trade.receiver_id, player_id: id)
    end
    params[:trade_send_player_ids].each do |id|
      @trade.trade_players.new(trade_team_id: @trade.sender_id, player_id: id)
    end

    p @trade.trade_players

    if @trade.save
      render json: @trade
    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  private

    def trade_params
      params.require(:trade).permit(:sender_id, :receiver_id)
    end
end
