# == Schema Information
#
# Table name: added_players
#
#  id          :integer          not null, primary key
#  add_drop_id :integer          not null
#  player_id   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :added_player do
    add_drop_id 1
    player_id 1
  end
end
