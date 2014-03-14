require 'csv'

module PlayersHelper

  def seed_players
    qb_list = CSV.open('lib/stats-qb.csv', headers: true)
    qb_list.each do |qb|
      name = qb['Name'].split(" ")
      team = self.set_team(qb['Team'])
      player = Player.create!(
        position: 'QB',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team,
        pass_yards: qb['PYds'],
        pass_tds: qb['PTD'],
        pass_ints: qb['Int'],
        rush_yards: qb['RuYds'],
        rush_tds: qb['RuTD'],
        fumbles: qb['FumL'],
      )
    end

    rb_list = CSV.open('lib/stats-rb.csv', headers: true)
    rb_list.each do |rb|
      name = rb['Name'].split(" ")
      team = self.set_team(rb['Team'])
      player = Player.create!(
        position: 'RB',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team,
        rush_yards: rb['RuYds'],
        rush_tds: rb['RuTD'],
        rec_yards: rb['RecYds'],
        rec_tds: rb['RecTD'],
        fumbles: rb['FumL'],
      )
    end

    wr_list = CSV.open('lib/stats-wr.csv', headers: true)
    wr_list.each do |wr|
      name = wr['Name'].split(" ")
      team = self.set_team(wr['Team'])
      player = Player.create!(
        position: 'WR',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team,
        rec_yards: wr['RecYds'],
        rec_tds: wr['RecTD'],
        ret_tds: wr['PRTD'].to_i + wr['KRTD'].to_i,
        fumbles: wr['FumL'],
      )
    end

    te_list = CSV.open('lib/stats-te.csv', headers: true)
    te_list.each do |te|
      name = te['Name'].split(" ")
      team = self.set_team(te['Team'])
      player = Player.create!(
        position: 'TE',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team,
        rec_yards: te['RecYds'],
        rec_tds: te['RecTD'],
        rush_yards: te['RuYds'],
        rush_tds: te['RuTD'],
        fumbles: te['FumL'],
      )
    end

    k_list = CSV.open('lib/stats-k.csv', headers: true)
    k_list.each do |k|
      name = k['Name'].split(" ")
      team = self.set_team(k['Team'])
      att_20 = k['0-19'].split("-")
      att_30 = k['20-29'].split("-")
      att_40 = k['30-39'].split("-")
      att_50 = k['40-49'].split("-")
      att_50_plus = k['50+'].split("-")
      player = Player.create!(
        position: 'K',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team,
        made_pat: k['XPM'],
        miss_pat: k['XPA'].to_i - k['XPM'].to_i,
        made_20: att_20.first,
        miss_20: att_20.last.to_i - att_20.first.to_i,
        made_30: att_30.first,
        miss_30: att_30.last.to_i - att_30.first.to_i,
        made_40: att_40.first,
        miss_40: att_40.last.to_i - att_40.first.to_i,
        made_50: att_50.first,
        miss_50: att_50.last.to_i - att_50.first.to_i,
        made_50_plus: att_50_plus.first,
        miss_50_plus: att_50_plus.last.to_i - att_50_plus.first.to_i,
      )
    end

    df_list = CSV.open('lib/stats-def.csv', headers: true)
    df_list.each do |df|
      player = Player.create!(
        position: 'DEF',
        first_name: Player::TEAMS[df['Tm']].first,
        last_name: Player::TEAMS[df['Tm']].last,
        nfl_team: df['Tm'],
        interceptions: df['Int'],
        fum_rec: df['FumRec'],
        sacks: df['Sack'],
      )
    end
    df_score_list = CSV.open('lib/stats-def-tds.csv', headers: true)
    df_score_list.each do |df|
      player = Player.find_by_position_and_nfl_team('DEF', df['Tm'])
      player.ret_tds = df['PR TD'].to_i + df['KR TD'].to_i
      player.safeties = df['Sfty']
      player.def_tds = df['FblTD'].to_i + df['IntTD'].to_i
      player.pts_allowed = df['Pts']
      player.save!
    end
  end

  def set_team(team)
    case team
    when "TAM"
      team = "TB"
    when "NOR"
      team = "NO"
    when "GNB"
      team = "GB"
    when "SFO"
      team = "SF"
    when "NWE"
      team = "NE"
    when "SDG"
      team = "SD"
    when "KAN"
      team = "KC"
    when "JAC"
      team = "JAX"
    end
    team
  end
end
