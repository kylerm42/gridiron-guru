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
  validates :team_id, presence: true, uniqueness: { scope: :player_id }
  validates :position, presence: true,
                              inclusion: { in: %w{QB RB WR TE R/W/T K DEF BN} }

  belongs_to :team
  belongs_to :player
end
