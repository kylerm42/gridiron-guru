# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "MyString"
    first_name "MyString"
    last_name "MyString"
    password_digest "MyString"
  end
end
