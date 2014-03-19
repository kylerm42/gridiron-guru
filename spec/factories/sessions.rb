# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  user_id    :integer          not null
#  device     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    token "MyString"
    user_id 1
  end
end
