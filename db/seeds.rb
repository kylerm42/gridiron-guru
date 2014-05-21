# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# seeding player data
players = JSON.parse(File.read('lib/players.json'))
players.each do |player|
  if player.last['status'] == 'ACT' &&
     Player::POSITIONS.include?(player.last['position'])
    Player.create(
      first_name: player.last['first_name'],
      last_name: player.last['last_name'],
      position: player.last['position'],
      nfl_team: player.last['team'],
      birthdate: Date.strptime(player.last['birthdate'], "%m/%d/%Y"),
      college: player.last['college'],
      height: player.last['height'],
      weight: player.last['weight'],
      years_pro: player.last['years_pro'],
      profile_id: player.last['profile_id'],
      gsis_id: player.first
    )
  end
end

# seeding player stats
players = CSV.open('lib/stats_2013.csv', headers: true)
players.each do |player|
  if Player::POSITIONS.include?(player['pos'])
    db_player = Player.find_by_gsis_id(player['id'])
    if db_player
      db_player.update(
        pass_yards: player['passing_yds'],
        pass_tds: player['passing_tds'],
        pass_ints: player['passing_ints'],
        rush_att: player['rushing_att'],
        rush_yards: player['rushing_yds'],
        rush_tds: player['rushing_tds'],
        receptions: player['receiving_rec'],
        rec_yards: player['receiving_yds'],
        rec_tds: player['receiving_tds'],
        fumbles: player['fumbles_lost'],
        two_pt_conv: player['passing_twoptm'].to_i +
                     player['rushing_twoptm'].to_i +
                     player['receiving_twoptm'].to_i,
        made_pat: player['kicking_xpmade'],
        miss_pat: player['kicking_xpmissed']
      )
    else
      p "#{player['name']}, #{player['team']} #{player['pos']}"
    end
  end
end

# seeding kickers
kickers = CSV.open('lib/stats-k.csv', headers: true)
kickers.each do |k|
  name = k['Name'].split(" ")
  player = Player.find_by_first_name_and_last_name(name.first, name.last)
  if player
    att_20 = k['0-19'].split("-")
    att_30 = k['20-29'].split("-")
    att_40 = k['30-39'].split("-")
    att_50 = k['40-49'].split("-")
    att_50_plus = k['50+'].split("-")
    player.update(
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
end

# seeding defense players
defenses = CSV.open('lib/stats_def.csv', headers: true)
defenses.each do |defense|
  Player.create(
    position: 'DEF',
    nfl_team: defense['Tm'],
    first_name: Player::TEAMS[defense['Tm']].first,
    last_name: Player::TEAMS[defense['Tm']].last,
    pts_allowed: defense['Pts'],
    fum_rec: defense['FumRec'],
    interceptions: defense['Int'],
    sacks: defense['Sack'],
    ret_tds: defense['Ret TD'],
    def_tds: defense['Def TD'],
    safeties: defense['Sfty']
  )
end

# seeding users
User.create(username: "test",
            first_name: "Charizard",
            last_name: "Charmander",
            email: "test@test.com",
            password: "123456")

User.create(username: "test2",
            first_name: "Xerxes",
            last_name: "Doe",
            email: "test2@test.com",
            password: "123456")

User.create(username: "test3",
            first_name: "Caesar",
            last_name: "Doe",
            email: "test3@test.com",
            password: "123456")

User.create(username: "test4",
            first_name: "Cleopatra",
            last_name: "Doe",
            email: "test4@test.com",
            password: "123456")

User.create(username: "test5",
            first_name: "John",
            last_name: "Doe",
            email: "test5@test.com",
            password: "123456")

User.create(username: "test6",
            first_name: "John",
            last_name: "Doe",
            email: "test6@test.com",
            password: "123456")

User.create(username: "test7",
            first_name: "John",
            last_name: "Doe",
            email: "test7@test.com",
            password: "123456")

User.create(username: "test8",
            first_name: "John",
            last_name: "Doe",
            email: "test8@test.com",
            password: "123456")

User.create(username: "test9",
            first_name: "John",
            last_name: "Doe",
            email: "test9@test.com",
            password: "123456")

User.create(username: "test0",
            first_name: "John",
            last_name: "Doe",
            email: "test0@test.com",
            password: "123456")

# seeding league
League.create(name: "Arkham Knights", manager_id: 1)

# seeding teams
Team.create(name: "MewTwoChains", user_id: 1, league_id: 1)
Team.create(name: "Every Day I'm Russellin'", user_id: 2, league_id: 1)
Team.create(name: "Blake Snortles", user_id: 3, league_id: 1)
Team.create(name: "There's An AP For That", user_id: 4, league_id: 1)
Team.create(name: "Welker Texas Ranger", user_id: 5, league_id: 1)
Team.create(name: "What Would Jones-Drew?", user_id: 6, league_id: 1)
Team.create(name: "Vick In A Box", user_id: 7, league_id: 1)
Team.create(name: "The Real McCoy", user_id: 8, league_id: 1)
Team.create(name: "Aaron Hernandcuffs", user_id: 9, league_id: 1)
Team.create(name: "Harvin A Bad Time", user_id: 10, league_id: 1)


# players = []

# players << RosterSpot.where(team_id: 1, position: 'QB').first
# players.last.player_id = 8
# players << RosterSpot.where(team_id: 1, position: 'RB').first
# players.last.player_id = 75
# players << RosterSpot.where(team_id: 1, position: 'RB').last
# players.last.player_id = 70
# players << RosterSpot.where(team_id: 1, position: 'WR').first
# players.last.player_id = 233
# players << RosterSpot.where(team_id: 1, position: 'WR').last
# players.last.player_id = 237
# players << RosterSpot.where(team_id: 1, position: 'TE').first
# players.last.player_id = 436
# players << RosterSpot.where(team_id: 1, position: 'R/W/T').first
# players.last.player_id = 238
# players << RosterSpot.where(team_id: 1, position: 'K').first
# players.last.player_id = 550
# players << RosterSpot.where(team_id: 1, position: 'DEF').first
# players.last.player_id = 584
# RosterSpot.create(team_id: 1, player_id: 9, position: 'BN')
# RosterSpot.create(team_id: 1, player_id: 77, position: 'BN')
# RosterSpot.create(team_id: 1, player_id: 88, position: 'BN')
# RosterSpot.create(team_id: 1, player_id: 253, position: 'BN')
# RosterSpot.create(team_id: 1, player_id: 248, position: 'BN')
# RosterSpot.create(team_id: 1, player_id: 451, position: 'BN')

# players << RosterSpot.where(team_id: 2, position: 'QB').first
# players.last.player_id = 4
# players << RosterSpot.where(team_id: 2, position: 'RB').first
# players.last.player_id = 68
# players << RosterSpot.where(team_id: 2, position: 'RB').last
# players.last.player_id = 69
# players << RosterSpot.where(team_id: 2, position: 'WR').first
# players.last.player_id = 236
# players << RosterSpot.where(team_id: 2, position: 'WR').last
# players.last.player_id = 245
# players << RosterSpot.where(team_id: 2, position: 'TE').first
# players.last.player_id = 441
# players << RosterSpot.where(team_id: 2, position: 'R/W/T').first
# players.last.player_id = 246
# players << RosterSpot.where(team_id: 2, position: 'K').first
# players.last.player_id = 551
# players << RosterSpot.where(team_id: 2, position: 'DEF').first
# players.last.player_id = 585
# RosterSpot.create(team_id: 2, player_id: 10, position: 'BN')
# RosterSpot.create(team_id: 2, player_id: 79, position: 'BN')
# RosterSpot.create(team_id: 2, player_id: 81, position: 'BN')
# RosterSpot.create(team_id: 2, player_id: 249, position: 'BN')
# RosterSpot.create(team_id: 2, player_id: 257, position: 'BN')
# RosterSpot.create(team_id: 2, player_id: 457, position: 'BN')

# players << RosterSpot.where(team_id: 3, position: 'QB').first
# players.last.player_id = 2
# players << RosterSpot.where(team_id: 3, position: 'RB').first
# players.last.player_id = 82
# players << RosterSpot.where(team_id: 3, position: 'RB').last
# players.last.player_id = 83
# players << RosterSpot.where(team_id: 3, position: 'WR').first
# players.last.player_id = 244
# players << RosterSpot.where(team_id: 3, position: 'WR').last
# players.last.player_id = 252
# players << RosterSpot.where(team_id: 3, position: 'TE').first
# players.last.player_id = 437
# players << RosterSpot.where(team_id: 3, position: 'R/W/T').first
# players.last.player_id = 262
# players << RosterSpot.where(team_id: 3, position: 'K').first
# players.last.player_id = 552
# players << RosterSpot.where(team_id: 3, position: 'DEF').first
# players.last.player_id = 586
# RosterSpot.create(team_id: 3, player_id: 15, position: 'BN')
# RosterSpot.create(team_id: 3, player_id: 116, position: 'BN')
# RosterSpot.create(team_id: 3, player_id: 110, position: 'BN')
# RosterSpot.create(team_id: 3, player_id: 255, position: 'BN')
# RosterSpot.create(team_id: 3, player_id: 251, position: 'BN')
# RosterSpot.create(team_id: 3, player_id: 449, position: 'BN')

# players << RosterSpot.where(team_id: 4, position: 'QB').first
# players.last.player_id = 11
# players << RosterSpot.where(team_id: 4, position: 'RB').first
# players.last.player_id = 73
# players << RosterSpot.where(team_id: 4, position: 'RB').last
# players.last.player_id = 80
# players << RosterSpot.where(team_id: 4, position: 'WR').first
# players.last.player_id = 243
# players << RosterSpot.where(team_id: 4, position: 'WR').last
# players.last.player_id = 235
# players << RosterSpot.where(team_id: 4, position: 'TE').first
# players.last.player_id = 438
# players << RosterSpot.where(team_id: 4, position: 'R/W/T').first
# players.last.player_id = 264
# players << RosterSpot.where(team_id: 4, position: 'K').first
# players.last.player_id = 553
# players << RosterSpot.where(team_id: 4, position: 'DEF').first
# players.last.player_id = 588
# RosterSpot.create(team_id: 4, player_id: 22, position: 'BN')
# RosterSpot.create(team_id: 4, player_id: 89, position: 'BN')
# RosterSpot.create(team_id: 4, player_id: 107, position: 'BN')
# RosterSpot.create(team_id: 4, player_id: 256, position: 'BN')
# RosterSpot.create(team_id: 4, player_id: 254, position: 'BN')
# RosterSpot.create(team_id: 4, player_id: 450, position: 'BN')

# players << RosterSpot.where(team_id: 5, position: 'QB').first
# players.last.player_id = 7
# players << RosterSpot.where(team_id: 5, position: 'RB').first
# players.last.player_id = 72
# players << RosterSpot.where(team_id: 5, position: 'RB').last
# players.last.player_id = 84
# players << RosterSpot.where(team_id: 5, position: 'WR').first
# players.last.player_id = 250
# players << RosterSpot.where(team_id: 5, position: 'WR').last
# players.last.player_id = 286
# players << RosterSpot.where(team_id: 5, position: 'TE').first
# players.last.player_id = 439
# players << RosterSpot.where(team_id: 5, position: 'R/W/T').first
# players.last.player_id = 294
# players << RosterSpot.where(team_id: 5, position: 'K').first
# players.last.player_id = 554
# players << RosterSpot.where(team_id: 5, position: 'DEF').first
# players.last.player_id = 589
# RosterSpot.create(team_id: 5, player_id: 34, position: 'BN')
# RosterSpot.create(team_id: 5, player_id: 91, position: 'BN')
# RosterSpot.create(team_id: 5, player_id: 100, position: 'BN')
# RosterSpot.create(team_id: 5, player_id: 270, position: 'BN')
# RosterSpot.create(team_id: 5, player_id: 292, position: 'BN')
# RosterSpot.create(team_id: 5, player_id: 453, position: 'BN')

# players << RosterSpot.where(team_id: 6, position: 'QB').first
# players.last.player_id = 18
# players << RosterSpot.where(team_id: 6, position: 'RB').first
# players.last.player_id = 97
# players << RosterSpot.where(team_id: 6, position: 'RB').last
# players.last.player_id = 95
# players << RosterSpot.where(team_id: 6, position: 'WR').first
# players.last.player_id = 258
# players << RosterSpot.where(team_id: 6, position: 'WR').last
# players.last.player_id = 234
# players << RosterSpot.where(team_id: 6, position: 'TE').first
# players.last.player_id = 440
# players << RosterSpot.where(team_id: 6, position: 'R/W/T').first
# players.last.player_id = 265
# players << RosterSpot.where(team_id: 6, position: 'K').first
# players.last.player_id = 555
# players << RosterSpot.where(team_id: 6, position: 'DEF').first
# players.last.player_id = 590
# RosterSpot.create(team_id: 6, player_id: 40, position: 'BN')
# RosterSpot.create(team_id: 6, player_id: 93, position: 'BN')
# RosterSpot.create(team_id: 6, player_id: 99, position: 'BN')
# RosterSpot.create(team_id: 6, player_id: 281, position: 'BN')
# RosterSpot.create(team_id: 6, player_id: 285, position: 'BN')
# RosterSpot.create(team_id: 6, player_id: 605, position: 'BN')

# players << RosterSpot.where(team_id: 7, position: 'QB').first
# players.last.player_id = 20
# players << RosterSpot.where(team_id: 7, position: 'RB').first
# players.last.player_id = 109
# players << RosterSpot.where(team_id: 7, position: 'RB').last
# players.last.player_id = 114
# players << RosterSpot.where(team_id: 7, position: 'WR').first
# players.last.player_id = 291
# players << RosterSpot.where(team_id: 7, position: 'WR').last
# players.last.player_id = 247
# players << RosterSpot.where(team_id: 7, position: 'TE').first
# players.last.player_id = 442
# players << RosterSpot.where(team_id: 7, position: 'R/W/T').first
# players.last.player_id = 302
# players << RosterSpot.where(team_id: 7, position: 'K').first
# players.last.player_id = 556
# players << RosterSpot.where(team_id: 7, position: 'DEF').first
# players.last.player_id = 591
# RosterSpot.create(team_id: 7, player_id: 19, position: 'BN')
# RosterSpot.create(team_id: 7, player_id: 112, position: 'BN')
# RosterSpot.create(team_id: 7, player_id: 92, position: 'BN')
# RosterSpot.create(team_id: 7, player_id: 261, position: 'BN')
# RosterSpot.create(team_id: 7, player_id: 275, position: 'BN')
# RosterSpot.create(team_id: 7, player_id: 606, position: 'BN')

# players << RosterSpot.where(team_id: 8, position: 'QB').first
# players.last.player_id = 14
# players << RosterSpot.where(team_id: 8, position: 'RB').first
# players.last.player_id = 85
# players << RosterSpot.where(team_id: 8, position: 'RB').last
# players.last.player_id = 78
# players << RosterSpot.where(team_id: 8, position: 'WR').first
# players.last.player_id = 242
# players << RosterSpot.where(team_id: 8, position: 'WR').last
# players.last.player_id = 276
# players << RosterSpot.where(team_id: 8, position: 'TE').first
# players.last.player_id = 444
# players << RosterSpot.where(team_id: 8, position: 'R/W/T').first
# players.last.player_id = 106
# players << RosterSpot.where(team_id: 8, position: 'K').first
# players.last.player_id = 557
# players << RosterSpot.where(team_id: 8, position: 'DEF').first
# players.last.player_id = 293
# RosterSpot.create(team_id: 8, player_id: 28, position: 'BN')
# RosterSpot.create(team_id: 8, player_id: 87, position: 'BN')
# RosterSpot.create(team_id: 8, player_id: 94, position: 'BN')
# RosterSpot.create(team_id: 8, player_id: 279, position: 'BN')
# RosterSpot.create(team_id: 8, player_id: 272, position: 'BN')
# RosterSpot.create(team_id: 8, player_id: 301, position: 'BN')

# players << RosterSpot.where(team_id: 9, position: 'QB').first
# players.last.player_id = 6
# players << RosterSpot.where(team_id: 9, position: 'RB').first
# players.last.player_id = 71
# players << RosterSpot.where(team_id: 9, position: 'RB').last
# players.last.player_id = 74
# players << RosterSpot.where(team_id: 9, position: 'WR').first
# players.last.player_id = 295
# players << RosterSpot.where(team_id: 9, position: 'WR').last
# players.last.player_id = 293
# players << RosterSpot.where(team_id: 9, position: 'TE').first
# players.last.player_id = 445
# players << RosterSpot.where(team_id: 9, position: 'R/W/T').first
# players.last.player_id = 133
# players << RosterSpot.where(team_id: 9, position: 'K').first
# players.last.player_id = 558
# players << RosterSpot.where(team_id: 9, position: 'DEF').first
# players.last.player_id = 595
# RosterSpot.create(team_id: 9, player_id: 44, position: 'BN')
# RosterSpot.create(team_id: 9, player_id: 103, position: 'BN')
# RosterSpot.create(team_id: 9, player_id: 104, position: 'BN')
# RosterSpot.create(team_id: 9, player_id: 290, position: 'BN')
# RosterSpot.create(team_id: 9, player_id: 273, position: 'BN')
# RosterSpot.create(team_id: 9, player_id: 578, position: 'BN')

# players << RosterSpot.where(team_id: 10, position: 'QB').first
# players.last.player_id = 48
# players << RosterSpot.where(team_id: 10, position: 'RB').first
# players.last.player_id = 86
# players << RosterSpot.where(team_id: 10, position: 'RB').last
# players.last.player_id = 101
# players << RosterSpot.where(team_id: 10, position: 'WR').first
# players.last.player_id = 239
# players << RosterSpot.where(team_id: 10, position: 'WR').last
# players.last.player_id = 271
# players << RosterSpot.where(team_id: 10, position: 'TE').first
# players.last.player_id = 447
# players << RosterSpot.where(team_id: 10, position: 'R/W/T').first
# players.last.player_id = 111
# players << RosterSpot.where(team_id: 10, position: 'K').first
# players.last.player_id = 561
# players << RosterSpot.where(team_id: 10, position: 'DEF').first
# players.last.player_id = 609
# RosterSpot.create(team_id: 10, player_id: 47, position: 'BN')
# RosterSpot.create(team_id: 10, player_id: 90, position: 'BN')
# RosterSpot.create(team_id: 10, player_id: 105, position: 'BN')
# RosterSpot.create(team_id: 10, player_id: 300, position: 'BN')
# RosterSpot.create(team_id: 10, player_id: 282, position: 'BN')
# RosterSpot.create(team_id: 10, player_id: 577, position: 'BN')

# players.each { |player| player.save }

# trade1 = Trade.create(sender_id: 1, receiver_id: 2, status: 'sent')
# trade1.trade_send_players.create(player_id: 77)
# trade1.trade_send_players.create(player_id: 238)
# trade1.trade_receive_players.create(player_id: 79)
# trade1.trade_receive_players.create(player_id: 257)

# trade2 = Trade.create(sender_id: 2, receiver_id: 1, status: 'sent')
# trade2.trade_send_players.create(player_id: 10)
# trade2.trade_send_players.create(player_id: 69)
# trade2.trade_receive_players.create(player_id: 9)
# trade2.trade_receive_players.create(player_id: 248)

# League.first.update({ current_week: 9 })