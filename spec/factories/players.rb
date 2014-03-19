# == Schema Information
#
# Table name: players
#
#  id            :integer          not null, primary key
#  first_name    :string(255)      not null
#  last_name     :string(255)      not null
#  position      :string(255)      not null
#  nfl_team      :string(255)      default("FA"), not null
#  pass_yards    :integer          default(0)
#  pass_tds      :integer          default(0)
#  pass_ints     :integer          default(0)
#  rush_yards    :integer          default(0)
#  rush_tds      :integer          default(0)
#  receptions    :integer          default(0)
#  rec_yards     :integer          default(0)
#  rec_tds       :integer          default(0)
#  fumbles       :integer          default(0)
#  two_pt_conv   :integer          default(0)
#  made_pat      :integer          default(0)
#  miss_pat      :integer          default(0)
#  made_20       :integer          default(0)
#  miss_20       :integer          default(0)
#  made_30       :integer          default(0)
#  miss_30       :integer          default(0)
#  made_40       :integer          default(0)
#  miss_40       :integer          default(0)
#  made_50       :integer          default(0)
#  miss_50       :integer          default(0)
#  made_50_plus  :integer          default(0)
#  miss_50_plus  :integer          default(0)
#  sacks         :integer          default(0)
#  interceptions :integer          default(0)
#  fum_rec       :integer          default(0)
#  safeties      :integer          default(0)
#  def_tds       :integer          default(0)
#  ret_tds       :integer          default(0)
#  pts_allowed   :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    first_name "MyString"
    last_name "MyString"
    position "MyString"
  end
end
