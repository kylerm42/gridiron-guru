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

class Player < ActiveRecord::Base
  extend   PlayersHelper

  POSITIONS = ["QB", "RB", "WR", "TE", "K", "DEF"]

  TEAMS = {
    "FA" => ["Free", "Agent"],
    "DAL" => ["Dallas", "Cowboys"],
    "PHI" => ["Philadelphia", "Eagles"],
    "NYG" => ["New York", "Giants"],
    "WAS" => ["Washington", "Redskins"],
    "TB" => ["Tampa Bay", "Buccaneers"],
    "ATL" => ["Atlanta", "Falcons"],
    "CAR" => ["Carolina", "Panthers"],
    "NO" => ["New Orleans", "Saints"],
    "CHI" => ["Chicago", "Bears"],
    "DET" => ["Detroit", "Lions"],
    "GB" => ["Green Bay", "Packers"],
    "MIN" => ["Minnesota", "Vikings"],
    "SF" => ["San Francisco", "49ers"],
    "ARI" => ["Arizona", "Cardinals"],
    "STL" => ["St. Louis", "Rams"],
    "SEA" => ["Seattle", "Seahawks"],
    "BUF" => ["Buffalo", "Bills"],
    "MIA" => ["Miami", "Dolphins"],
    "NYJ" => ["New York", "Jets"],
    "NE" => ["New England", "Patriots"],
    "IND" => ["Indianapolis", "Colts"],
    "JAX" => ["Jacksonville", "Jaguars"],
    "HOU" => ["Houston", "Texans"],
    "TEN" => ["Tennessee", "Titans"],
    "CIN" => ["Cincinnati", "Bengals"],
    "CLE" => ["Cleveland", "Browns"],
    "BAL" => ["Baltimore", "Ravens"],
    "PIT" => ["Pittsburgh", "Steelers"],
    "DEN" => ["Denver", "Broncos"],
    "SD" => ["San Diego", "Chargers"],
    "KC" => ["Kansas City", "Chiefs"],
    "OAK" => ["Oakland", "Raiders"]
  }

  validates :first_name, :last_name, presence: true
  validates :position, presence: true, inclusion: { in: POSITIONS }
  validates :nfl_team, inclusion: { in: TEAMS.keys }

  has_many :roster_spots,
           foreign_key: :player_id,
           class_name: "RosterSpot",
           dependent: :destroy
  has_many :teams,
           through: :roster_spots,
           source: :team
  has_many :leagues,
           through: :teams,
           source: :league
  has_many :weekly_stats

  def name
    self.first_name + " " + self.last_name
  end

  def points
    if self.position == 'DEF'
      if self.pts_allowed == 0
        pts_allowed = 10
      elsif self.pts_allowed < 7
        pts_allowed = 7
      elsif self.pts_allowed < 14
        pts_allowed = 4
      elsif self.pts_allowed < 21
        pts_allowed = 1
      elsif self.pts_allowed < 28
        pts_allowed = 0
      elsif self.pts_allowed < 35
        pts_allowed = -1
      else
        pts_allowed = -4
      end
    else
      pts_allowed = 0
    end
    self.pass_yards / 25.0 +
    self.pass_tds * 4 +
    self.pass_ints * -2 +
    self.rush_yards / 10.0 +
    self.rush_tds * 6 +
    self.rec_yards / 10.0 +
    self.rec_tds * 6 +
    self.two_pt_conv * 2 +
    self.fumbles * -2 +
    self.made_pat * 1 +
    self.miss_pat * -1 +
    self.made_20 * 2 +
    self.miss_20 * -2 +
    self.made_30 * 2 +
    self.miss_30 * -2 +
    self.made_40 * 3 +
    self.miss_40 * -3 +
    self.made_50 * 4 +
    self.miss_50 * -4 +
    self.made_50_plus * 5 +
    self.miss_50_plus * -5 +
    self.sacks * 1 +
    self.interceptions * 2 +
    self.fum_rec * 2 +
    self.safeties * 2 +
    self.def_tds * 6 +
    self.ret_tds * 6 +
    pts_allowed
  end
end
