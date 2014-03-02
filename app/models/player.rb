# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  first_name  :string(255)      not null
#  last_name   :string(255)      not null
#  position    :string(255)      not null
#  nfl_team_id :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Player < ActiveRecord::Base
  POSITIONS = %w{ QB RB WR TE K DEF }

  validates :name, presence: true
  validates :position, presence: true, inclusion: { in: POSITIONS }
  validates :nfl_team_id, inclusion: { in: 0..32 }

  has_many :team_players,
           dependent: :destroy
  has_many :teams,
           through: :team_players,
           source: :team
  has_many :leagues,
           through: :teams,
           source: :league
end
