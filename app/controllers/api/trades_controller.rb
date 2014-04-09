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
    @trade = Trade.includes(:trade_send_players, :trade_receive_players,
                            sender:
                             [{sent_trades: [:trade_send_players, :trade_receive_players]},
                             {received_trades: [:trade_send_players, :trade_receive_players]},
                             {roster_spots: :player}],
                            receiver:
                             [{sent_trades: [:trade_send_players, :trade_receive_players]},
                             {received_trades: [:trade_send_players, :trade_receive_players]},
                             {roster_spots: :player}])
                  .find(params[:id])

    @sender = @trade.sender
    @receiver = @trade.receiver

    @trade.transaction do
      if @trade.update_attributes(trade_params)
        if @trade.status == 'accepted'
          @trade.trade_send_players.each do |player|
            @sender.roster_spots.find { |rs| rs.player_id == player.player.id }.destroy
            @receiver.roster_spots.create(player_id: player.player_id)

            @receiver.received_trades.select do |trade|
              trade.trade_receive_players
                   .select { |received| received.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @sender.received_trades.select do |trade|
              trade.trade_send_players
                   .select { |sent| sent.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @receiver.sent_trades.select do |trade|
              trade.trade_receive_players
                   .select { |received| received.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @sender.sent_trades.select do |trade|
              trade.trade_send_players
                   .select { |sent| sent.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
          end
          @trade.trade_receive_players.each do |player|
            @receiver.roster_spots.find do |rs|
              p rs.player_id
              p player.player_id
              rs.player_id == player.player_id
            end.destroy
            @sender.roster_spots.create(player_id: player.player_id)

            @receiver.received_trades.select do |trade|
              trade.trade_receive_players
                   .select { |received| received.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @sender.received_trades.select do |trade|
              trade.trade_send_players
                   .select { |sent| sent.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @receiver.sent_trades.select do |trade|
              trade.trade_receive_players
                   .select { |received| received.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
            @sender.sent_trades.select do |trade|
              trade.trade_send_players
                   .select { |sent| sent.player_id == player.player_id }.length > 0 &&
              trade.id != @trade.id
            end.each { |trade| trade.destroy }
          end
        end

        p @sender.roster_spots.count
        p @receiver.roster_spots.count
        @sender.fill_roster_spots.save
        @receiver.fill_roster_spots.save
      else
        render json: @trade.errors, status: :unprocessable_entity
        return
      end
    end
    p 'rendering NOW'
    p @sender.roster_spots.count
    p @receiver.roster_spots.count
    render :update
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