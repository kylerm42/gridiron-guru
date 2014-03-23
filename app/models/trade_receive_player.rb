class TradeReceivePlayer < ActiveRecord::Base
  validates :trade, :player_id, presence: true
  validates :trade_id, uniqueness: { scope: :player_id }

  belongs_to :trade,
             inverse_of: :trade_receive_players
  belongs_to :player
end
