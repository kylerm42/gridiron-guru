class Api::TradesController < ApplicationController
  def create
    @trade = Trade.new(trade_params)
    params[:trade_receive_player_ids].each do |id|
      @trade.trade_receive_players.new(player_id: id)
    end
    params[:trade_send_player_ids].each do |id|
      @trade.trade_send_players.new(player_id: id)
    end

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
