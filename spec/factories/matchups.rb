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
