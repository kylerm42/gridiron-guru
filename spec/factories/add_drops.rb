# == Schema Information
#
# Table name: add_drops
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  status     :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :add_drop do
    team_id 1
    status 1
  end
end
