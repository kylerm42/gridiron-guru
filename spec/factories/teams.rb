# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  league_id  :integer          not null
#  wins       :integer          default(0), not null
#  losses     :integer          default(0), not null
#  ties       :integer          default(0), not null
#  waiver     :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "MyString"
    user_id 1
    league_id 1
  end
end
