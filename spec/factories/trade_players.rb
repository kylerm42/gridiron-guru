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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade_player do
    trade_id 1
    player_id 1
  end
end
