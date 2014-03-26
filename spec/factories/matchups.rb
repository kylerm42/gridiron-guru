# == Schema Information
#
# Table name: matchups
#
#  id              :integer          not null, primary key
#  week            :integer          not null
#  home_team_id    :integer          not null
#  home_team_score :float
#  away_team_id    :integer          not null
#  away_team_score :float
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :matchup do
    home_team_id 1
    home_team_score "MyString"
    float "MyString"
    away_team_id 1
    away_team_score "MyString"
    float "MyString"
  end
end
