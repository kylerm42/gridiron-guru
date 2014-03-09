module PlayersHelper
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

  def self.seed_player_stats
    Player.all.each do |player|
      if player.position == "qb"
        player.position = player.position.upcase
        player.pass_yards = rand(5000)
        player.pass_tds = rand(45)
        player.pass_ints = rand(20)
        player.rush_yards = rand(200)
        player.rush_tds = rand(2)
        player.fumbles = rand(7)
        player.two_pt_conv = rand(3)

      elsif player.position == "rb"
        player.position = player.position.upcase
        player.rush_yards = rand(2000)
        player.rush_tds = rand(15)
        player.rec_yards = rand(800)
        player.rec_tds = rand(7)
        player.fumbles = rand(6)
        player.two_pt_conv = rand(3)

      elsif player.position == "wr"
        player.position = player.position.upcase
        player.rush_yards = rand(50)
        player.rec_yards = rand(1800)
        player.rec_tds = rand(18)
        player.fumbles = rand(3)
        player.two_pt_conv = rand(2)

      elsif player.position == "te"
        player.position = player.position.upcase
        player.rec_yards = rand(1200)
        player.rec_tds = rand(11)
        player.fumbles = rand(3)
        player.two_pt_conv = rand(2)

      elsif player.position == "k"
        player.position = player.position.upcase
        player.made_pat = rand(50)
        player.miss_pat = rand(2)
        player.made_20 = rand(3)
        player.made_30 = rand(13)
        player.miss_30 = rand(2)
        player.made_40 = rand(13)
        player.miss_40 = rand(4)
        player.made_50 = rand(14)
        player.miss_50 = rand(5)
        player.made_50_plus = rand(7)
        player.miss_50_plus = rand(4)

      elsif player.position == "def"
        player.position = player.position.upcase
        player.sacks = 30 + rand(30)
        player.interceptions = 10 + rand(16)
        player.fum_rec = 6 + rand(9)
        player.safeties = rand(3)
        player.def_tds = rand(7)
        player.ret_tds = rand(4)
        player.pts_allowed = 225 + rand(250)
      end

      player.save!
    end
  end
end
