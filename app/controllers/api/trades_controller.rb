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

  def update
    @trade = Trade.includes(sender: [{sent_trades: :trade_send_players},
                                     {received_trades: :trade_receive_players}],
                            receiver: [{sent_trades: :trade_send_players},
                                       {received_trades: :trade_receive_players}])
                  .find(params[:id])

    @trade.transaction do
      if @trade.update_attributes(trade_params)
        if @trade.status == 'accepted'
          @trade.trade_send_players.each do |player|
            @trade.sender.team_players.find_by_player_id(player.player_id).destroy
            @trade.receiver.team_players.create(player_id: player.player_id)

            @trade.receiver.received_trades.select do |trade|
              trade.trade_receive_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.sender.received_trades.select do |trade|
              trade.trade_send_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.receiver.sent_trades.select do |trade|
              trade.trade_receive_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.sender.sent_trades.select do |trade|
              trade.trade_send_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
          end
          @trade.trade_receive_players.each do |player|
            @trade.receiver.team_players.find_by_player_id(player.player_id).destroy
            @trade.sender.team_players.create(player_id: player.player_id)

            @trade.receiver.received_trades.select do |trade|
              trade.trade_receive_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.sender.received_trades.select do |trade|
              trade.trade_send_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.receiver.sent_trades.select do |trade|
              trade.trade_receive_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
            @trade.sender.sent_trades.select do |trade|
              trade.trade_send_players
                   .where(player_id: player.player_id).length > 0 &&
              trade != @trade
            end.each { |trade| trade.destroy }
          end
        end

        render json: @trade
      else
        render json: @trade.errors
      end
    end
  end

  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy
    render json: @trade
  end

  private

    def trade_params
      params.require(:trade).permit(:sender_id, :receiver_id, :status)
    end
end