# == Schema Information
#
# Table name: trade_receive_players
#
#  id         :integer          not null, primary key
#  trade_id   :integer          not null
#  player_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class TradeReceivePlayer < ActiveRecord::Base
  validates :trade, :player_id, presence: true
  validates :trade_id, uniqueness: { scope: :player_id }

  belongs_to :trade,
             inverse_of: :trade_receive_players
  belongs_to :player
end
