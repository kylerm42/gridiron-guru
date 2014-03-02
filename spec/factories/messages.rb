# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body "MyText"
    poster_id 1
    messageable nil
  end
end
