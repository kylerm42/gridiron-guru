# == Schema Information
#
# Table name: watched_players
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  player_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :watched_player do
    team_id 1
    player_id 1
  end
end
