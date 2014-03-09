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
  require 'addressable/uri'
  extend PlayersHelper

  POSITIONS = ["QB", "RB", "WR", "TE", "K", "DEF"]

  TEAMS = {
    0 =>  ["Free", "Agent"],
    1 =>  ["Dallas", "Cowboys"],
    2 => ["Philadelphia", "Eagles"],
    3 => ["New York", "Giants"],
    4 => ["Washington", "Redskins"],
    5 => ["Tampa Bay", "Buccaneers"],
    6 => ["Atlanta", "Falcons"],
    7 => ["Carolina", "Panthers"],
    8 => ["New Orleans", "Saints"],
    9 => ["Chicago", "Bears"],
    10 => ["Detroit", "Lions"],
    11 => ["Green Bay", "Packers"],
    12 => ["Minnesota", "Vikings"],
    13 => ["San Francisco", "49ers"],
    14 => ["Arizona", "Cardinals"],
    15 => ["St. Louis", "Rams"],
    16 => ["Seattle", "Seahawks"],
    17 => ["Buffalo", "Bills"],
    18 => ["Miami", "Dolphins"],
    19 => ["New York", "Jets"],
    20 => ["New England", "Patriots"],
    21 => ["Indianapolis", "Colts"],
    22 => ["Jacksonville", "Jaguars"],
    23 => ["Houston", "Texans"],
    24 => ["Tennessee", "Titans"],
    25 => ["Cincinnati", "Bengals"],
    26 => ["Cleveland", "Browns"],
    27 => ["Baltimore", "Ravens"],
    28 => ["Pittsburgh", "Steelers"],
    29 => ["Denver", "Broncos"],
    30 => ["San Diego", "Chargers"],
    31 => ["Kansas City", "Chiefs"],
    32 => ["Oakland", "Raiders"]
  }

  validates :first_name, :last_name, presence: true
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

  def name
    self.first_name + " " + self.last_name
  end
end
