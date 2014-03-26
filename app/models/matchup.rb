# == Schema Information
#
# Table name: matchups
#
#  id              :integer          not null, primary key
#  week            :integer          not null
#  home_team_id    :integer          not null
#  home_team_score :float
#  away_team_id    :integer          not null
#  away_team_score :float
#  created_at      :datetime
#  updated_at      :datetime
#

class Matchup < ActiveRecord::Base
  validates :week, :home_team_id, :away_team_id, presence: true

  belongs_to :home_team,
             foreign_key: :home_team_id,
             class_name: 'Team'
  belongs_to :away_team,
             foreign_key: :away_team_id,
             class_name: 'Team'
end
