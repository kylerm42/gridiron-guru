# == Schema Information
#
# Table name: roster_spots
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  player_id  :integer
#  position   :string(255)      default("BN"), not null
#  created_at :datetime
#  updated_at :datetime
#

class RosterSpot < ActiveRecord::Base
  ROSTER_POSITIONS = {
    "QB" => 1,
    "RB" => 2,
    "WR" => 3,
    "TE" => 4,
    "W/R/T" => 5,
    "K" => 6,
    "DEF" => 7,
    "BN" => 8
  }

  validates :team_id, presence: true
  validates :position, presence: true,
                              inclusion: { in: %w{QB RB WR TE R/W/T K DEF BN} }

  belongs_to :team
  belongs_to :player
end
