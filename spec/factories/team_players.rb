# == Schema Information
#
# Table name: team_players
#
#  id              :integer          not null, primary key
#  team_id         :integer          not null
#  player_id       :integer
#  roster_position :string(255)      default("BN"), not null
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team_player do
    team_id 1
    player_id 1
  end
end
