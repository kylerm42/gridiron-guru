# == Schema Information
#
# Table name: trade_players
#
#  id         :integer          not null, primary key
#  trade_id   :integer          not null
#  player_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class TradePlayer < ActiveRecord::Base
  validates :trade_id, :player_id, presence: true
  validates :trade_id, uniqueness: { scope: :player_id }

  belongs_to :trade
  belongs_to :player
end