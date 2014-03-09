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

  POSITIONS = [:qb, :rb, :wr, :te, :k, :def]

  TEAMS = {
    0: ["Free Agent", ""],
    1: ["Dallas", "Cowboys"],
    2: ["Philadelphia", "Eagles"],
    3: ["New York", "Giants"],
    4: ["Washington", "Redskins"],
    5: ["Tampa Bay", "Buccaneers"],
    6: ["Atlanta", "Falcons"],
    7: ["Carolina", "Panthers"],
    8: ["New Orleans", "Saints"],
    9: ["Chicago", "Bears"],
    10: ["Detroit", "Lions"],
    11: ["Green Bay", "Packers"],
    12: ["Minnesota", "Vikings"],
    13: ["San Francisco", "49ers"],
    14: ["Arizona", "Cardinals"],
    15: ["St. Louis", "Rams"],
    16: ["Seattle", "Seahawks"],
    17: ["Buffalo", "Bills"],
    18: ["Miami", "Dolphins"],
    19: ["New York", "Jets"],
    20: ["New England", "Patriots"],
    21: ["Indianapolis", "Colts"],
    22: ["Jacksonville", "Jaguars"],
    23: ["Houston", "Texans"],
    24: ["Tennessee", "Titans"],
    25: ["Cincinnati", "Bengals"],
    26: ["Cleveland", "Browns"],
    27: ["Baltimore", "Ravens"],
    28: ["Pittsburgh", "Steelers"],
    29: ["Denver", "Broncos"],
    30: ["San Diego", "Chargers"],
    31: ["Kansas City", "Chiefs"],
    32: ["Oakland", "Raiders"]
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

  def self.seed_players
    offset = 0

    until offset > 1000
      url = Addressable::URI.new(
        :scheme => "http",
        :host => "api.espn.com",
        :path => "v1/sports/football/nfl/athletes",
        :query_values => {
          :apikey => "v2tytku2pcn92zhduzx7a3gp",
          :offset => offset
        }
      ).to_s
      res = JSON.parse(RestClient.get(url))
      res["sports"][0]["leagues"][0]["athletes"].each do |athlete|
        player = Player.new(
          first_name: athlete["firstName"],
          last_name: athlete["lastName"],
          position: POSITIONS[0..-2].sample,
          nfl_team_id: (0..32).to_a.sample,
        )
        player.save!
      end
      offset += 50
      sleep(1)
    end

    TEAMS.each do |id, team|
      player = Player.new(
        first_name: team[0],
        last_name: team[1],
        position: POSITIONS.last,
        nfl_team_id: id,
      )
      player.save!
    end
  end

  def self.results
    Player.all.each do |player|
      url = Addressable::URI.new(
        :scheme => "http",
        :host => "api.espn.com",
        :path => "v1/sports/football/nfl/athletes/" + player.espn_id.to_s,
        :query_values => {
          :apikey => "v2tytku2pcn92zhduzx7a3gp"
        }
      ).to_s
      res = JSON.parse(RestClient.get(url))
      p res
    end
  end

  def self.seed_player_stats
    Player.all.each do |player|
      if player.position == "QB"
        player.position = :qb
        player.pass_yards = random(5000)
        player.pass_tds = random(45)
        player.pass_ints = random(20)
        player.rush_yds = random(200)
        player.rush_tds = random(2)
        player.fumbles = random(7)
        player.two_pt_conv = random(3)

      elsif player.position == "RB"
        player.position = :rb
        player.rush_yards = random(2000)
        player.rush_tds = random(15)
        player.rec_yards = random(800)
        player.rec_tds = random(7)
        player.fumbles = random(6)
        player.two_pt_conv = random(3)

      elsif player.position == "WR"
        player.position = :wr
        player.rush_yards = random(50)
        player.rec_yards = random(1800)
        player.rec_tds = random(18)
        player.fumbles = random(3)
        player.two_pt_conv = random(2)

      elsif player.position == "TE"
        player.position = :te
        player.rec_yards = random(1200)
        player.rec_tds = random(11)
        player.fumbles = random(3)
        player.two_pt_conv = random(2)

      elsif player.position == "K"
        player.position = :k
        player.made_pat = random(50)
        player.miss_pat = random(2)
        player.made_20 = random(3)
        player.made_30 = random(13)
        player.miss_30 = random(2)
        player.made_40 = random(13)
        player.miss_40 = random(4)
        player.made_50 = random(14)
        player.miss_50 = random(5)
        player.made_50_plus = random(7)
        player.miss_50_plus = random(4)

      elsif player.position == "DEF"
        player.position = :def
        player.sacks = 30 + random(30)
        player.interceptions = 10 + random(16)
        player.fum_recs = 6 + random(9)
        player.safeties = random(3)
        player.def_tds = random(7)
        player.ret_tds = random(4)
        player.pts_allowed = 225 + random(250)
      end
    end
  end
end
