# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  body             :text
#  poster_id        :integer
#  messageable_id   :integer
#  messageable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    body "MyText"
    poster_id 1
    messageable nil
  end
end
