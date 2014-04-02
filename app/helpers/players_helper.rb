require 'csv'

module PlayersHelper

  def seed_playersjjj
    contents = File.read('lib/players.json')
    things = JSON.parse(contents)
    things.each do |player|
      next unless player['status'] == "ACT"
      Player.new({
        first_name: player['first_name'],
        last_name: player['last_name'],
        college: player['college'],
        birthdate: Date.strptime(player['birthdate'], '%m/%d/%Y'),
        gsis_id: player['gsis_id']
      })
    end
  end

  def seed_players
    qb_list = CSV.open('lib/stats-qb.csv', headers: true)
    qb_list.each do |qb|
      name = qb['Name'].split(" ")
      team = self.set_team(qb['Team'])
      player = Player.create!(
        position: 'QB',
        first_name: name.shift,
        last_name: name.join(" "),
        nfl_team: team
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
        nfl_team: team
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
        nfl_team: team
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
        nfl_team: team
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

  def create_weekly_stats(players, p, week)
    player = players.where(last_name: p['name'].split('.').last, position: p['pos'])
    if player.length > 1
      player = player.select do |single|
        single.first_name[0] == p['name'].split('.').first
      end
    end
    if player.length > 1
      player = player.select do |single|
        if p['team'] == 'JAC'
          single.nfl_team == 'JAX'
        else
          single.nfl_team == p['team']
        end
      end
    end
    if p['name'] == 'R.Griffin' && p['team'] == 'WAS' && p['pos'] == 'QB'
      player = players.where(last_name: 'Griffin III', nfl_team: 'WAS')
    end
    player = player.first

    player.weekly_stats.new(week: week,
                            pass_yards: p['passing_yds'] || 0,
                            pass_tds: p['passing_tds'] || 0,
                            pass_ints: p['passing_ints'] || 0,
                            rush_yards: p['rushing_yds'] || 0,
                            rush_tds: p['rushing_tds'] || 0,
                            receptions: p['receiving_rec'] || 0,
                            rec_yards: p['receiving_yds'] || 0,
                            rec_tds: p['receiving_tds'] || 0,
                            fumbles: p['fumbles_lost'] || 0,
                            two_pt_conv: p['passing_twoptm'].to_i +
                                         p['receiving_twoptm'].to_i +
                                         p['rushing_twoptm'].to_i,
                            )
    player.save!
  end

  def create_season_stats(players, p)
    player = players.where(last_name: p['name'].split('.').last, position: p['pos'])
    if player.length > 1
      player = player.select do |single|
        single.first_name[0] == p['name'].split('.').first
      end
    end
    if player.length > 1
      player = player.select do |single|
        if p['team'] == 'JAC'
          single.nfl_team == 'JAX'
        else
          single.nfl_team == p['team']
        end
      end
    end
    if p['name'] == 'R.Griffin' && p['team'] == 'WAS' && p['pos'] == 'QB'
      player = players.where(last_name: 'Griffin III', nfl_team: 'WAS')
    end
    player = player.first

    player.update_attributes({
      pass_yards: p['passing_yds'] || 0,
      pass_tds: p['passing_tds'] || 0,
      pass_ints: p['passing_ints'] || 0,
      rush_yards: p['rushing_yds'] || 0,
      rush_tds: p['rushing_tds'] || 0,
      receptions: p['receiving_rec'] || 0,
      rec_yards: p['receiving_yds'] || 0,
      rec_tds: p['receiving_tds'] || 0,
      fumbles: p['fumbles_lost'] || 0,
      two_pt_conv: p['passing_twoptm'].to_i +
                   p['receiving_twoptm'].to_i +
                   p['rushing_twoptm'].to_i,
      })
  end

  def seed_stats!
    players = Player.all
    8.times do |i|
      week = CSV.open("lib/week#{i + 1}.csv", headers: true)
      week.each do |p|
        next unless ['QB', 'RB', 'WR', 'TE'].include?(p['pos'])
        self.create_weekly_stats(players, p, i + 1)
      end
    end

    weeks = CSV.open("lib/weeks1_8.csv", headers: true)
    weeks.each do |p|
      next unless ['QB', 'RB', 'WR', 'TE'].include?(p['pos'])
      self.create_season_stats(players, p)
    end
  end
end
