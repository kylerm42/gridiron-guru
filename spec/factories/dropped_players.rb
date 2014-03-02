# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dropped_player do
    add_drop_id 1
    player_id 1
  end
end
