# == Schema Information
#
# Table name: leagues
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  manager_id      :integer          not null
#  password_digest :string(255)
#  private         :boolean          default(FALSE)
#  current_week    :integer          default(0)
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :league do
    name "MyString"
    manager_id 1
  end
end
