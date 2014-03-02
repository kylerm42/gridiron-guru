# == Schema Information
#
# Table name: team_players
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  player_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class TeamPlayer < ActiveRecord::Base
  validates :team_id, presence: true, uniqueness: { scope: :player_id }
  validates :player_id, presence: true

  belongs_to :team
  belongs_to :player
end