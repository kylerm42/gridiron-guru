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
end
