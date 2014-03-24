# == Schema Information
#
# Table name: trades
#
#  id          :integer          not null, primary key
#  sender_id   :integer          not null
#  receiver_id :integer          not null
#  status      :string(255)      default("sent"), not null
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade do
    sender_id 1
    receiver_id 1
    status 1
  end
end
