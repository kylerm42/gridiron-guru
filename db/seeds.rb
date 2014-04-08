# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Player.seed_players
Player.create(first_name: 'Ted', last_name: 'Ginn', nfl_team: 'CAR', position: 'WR')
Player.create(first_name: 'Denard', last_name: 'Robinson', nfl_team: 'JAX', position: 'RB')
Player.create(first_name: 'Cecil', last_name: 'Shorts', nfl_team: 'JAX', position: 'WR')
Player.create(first_name: 'Roy', last_name: 'Helu', nfl_team: 'WAS', position: 'RB')
Player.create(first_name: 'Chris', last_name: 'Thompson', nfl_team: 'WAS', position: 'RB')
Player.create(first_name: 'Demarcus', last_name: 'Dobbs', nfl_team: 'SF', position: 'TE')
Player.create(first_name: 'Louis', last_name: 'Murphy', nfl_team: 'NYG', position: 'WR')
Player.create(first_name: 'Michael', last_name: 'Ford', nfl_team: 'CHI', position: 'RB')
Player.create(first_name: 'Chase', last_name: 'Reynolds', nfl_team: 'STL', position: 'RB')

Player.seed_stats!


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

League.create(name: "Arkham Knights", manager_id: 1)

Team.create(name: "MewTwoChains", user_id: 1, league_id: 1)
Team.create(name: "Every Day I'm Russellin'", user_id: 2, league_id: 1)
Team.create(name: "Zac Stacy's Mom", user_id: 3, league_id: 1)
Team.create(name: "There's An AP For That", user_id: 4, league_id: 1)
Team.create(name: "Welker Texas Ranger", user_id: 5, league_id: 1)
Team.create(name: "What Would Jones-Drew?", user_id: 6, league_id: 1)
Team.create(name: "Vick In A Box", user_id: 7, league_id: 1)
Team.create(name: "The Real McCoy", user_id: 8, league_id: 1)
Team.create(name: "Aaron Hernandcuffs", user_id: 9, league_id: 1)
Team.create(name: "Harvin A Bad Time", user_id: 10, league_id: 1)

RosterSpot.create(team_id: 1, player_id: 8, position: 'QB')
RosterSpot.create(team_id: 1, player_id: 75, position: 'RB')
RosterSpot.create(team_id: 1, player_id: 70, position: 'RB')
RosterSpot.create(team_id: 1, player_id: 233, position: 'WR')
RosterSpot.create(team_id: 1, player_id: 237, position: 'WR')
RosterSpot.create(team_id: 1, player_id: 436, position: 'TE')
RosterSpot.create(team_id: 1, player_id: 238, position: 'R/W/T')
RosterSpot.create(team_id: 1, player_id: 550, position: 'K')
RosterSpot.create(team_id: 1, player_id: 584, position: 'DEF')
RosterSpot.create(team_id: 1, player_id: 9, position: 'BN')
RosterSpot.create(team_id: 1, player_id: 77, position: 'BN')
RosterSpot.create(team_id: 1, player_id: 88, position: 'BN')
RosterSpot.create(team_id: 1, player_id: 253, position: 'BN')
RosterSpot.create(team_id: 1, player_id: 248, position: 'BN')
RosterSpot.create(team_id: 1, player_id: 451, position: 'BN')

RosterSpot.create(team_id: 2, player_id: 4, position: 'QB')
RosterSpot.create(team_id: 2, player_id: 68, position: 'RB')
RosterSpot.create(team_id: 2, player_id: 69, position: 'RB')
RosterSpot.create(team_id: 2, player_id: 236, position: 'WR')
RosterSpot.create(team_id: 2, player_id: 245, position: 'WR')
RosterSpot.create(team_id: 2, player_id: 441, position: 'TE')
RosterSpot.create(team_id: 2, player_id: 246, position: 'R/W/T')
RosterSpot.create(team_id: 2, player_id: 551, position: 'K')
RosterSpot.create(team_id: 2, player_id: 585, position: 'DEF')
RosterSpot.create(team_id: 2, player_id: 10, position: 'BN')
RosterSpot.create(team_id: 2, player_id: 79, position: 'BN')
RosterSpot.create(team_id: 2, player_id: 81, position: 'BN')
RosterSpot.create(team_id: 2, player_id: 249, position: 'BN')
RosterSpot.create(team_id: 2, player_id: 257, position: 'BN')
RosterSpot.create(team_id: 2, player_id: 457, position: 'BN')

RosterSpot.create(team_id: 3, player_id: 2, position: 'QB')
RosterSpot.create(team_id: 3, player_id: 82, position: 'RB')
RosterSpot.create(team_id: 3, player_id: 83, position: 'RB')
RosterSpot.create(team_id: 3, player_id: 244, position: 'WR')
RosterSpot.create(team_id: 3, player_id: 252, position: 'WR')
RosterSpot.create(team_id: 3, player_id: 437, position: 'TE')
RosterSpot.create(team_id: 3, player_id: 262, position: 'R/W/T')
RosterSpot.create(team_id: 3, player_id: 552, position: 'K')
RosterSpot.create(team_id: 3, player_id: 586, position: 'DEF')
RosterSpot.create(team_id: 3, player_id: 15, position: 'BN')
RosterSpot.create(team_id: 3, player_id: 116, position: 'BN')
RosterSpot.create(team_id: 3, player_id: 110, position: 'BN')
RosterSpot.create(team_id: 3, player_id: 255, position: 'BN')
RosterSpot.create(team_id: 3, player_id: 251, position: 'BN')
RosterSpot.create(team_id: 3, player_id: 449, position: 'BN')

RosterSpot.create(team_id: 4, player_id: 11, position: 'QB')
RosterSpot.create(team_id: 4, player_id: 73, position: 'RB')
RosterSpot.create(team_id: 4, player_id: 80, position: 'RB')
RosterSpot.create(team_id: 4, player_id: 243, position: 'WR')
RosterSpot.create(team_id: 4, player_id: 235, position: 'WR')
RosterSpot.create(team_id: 4, player_id: 438, position: 'TE')
RosterSpot.create(team_id: 4, player_id: 264, position: 'R/W/T')
RosterSpot.create(team_id: 4, player_id: 553, position: 'K')
RosterSpot.create(team_id: 4, player_id: 588, position: 'DEF')
RosterSpot.create(team_id: 4, player_id: 22, position: 'BN')
RosterSpot.create(team_id: 4, player_id: 89, position: 'BN')
RosterSpot.create(team_id: 4, player_id: 107, position: 'BN')
RosterSpot.create(team_id: 4, player_id: 256, position: 'BN')
RosterSpot.create(team_id: 4, player_id: 254, position: 'BN')
RosterSpot.create(team_id: 4, player_id: 450, position: 'BN')

RosterSpot.create(team_id: 5, player_id: 7, position: 'QB')
RosterSpot.create(team_id: 5, player_id: 72, position: 'RB')
RosterSpot.create(team_id: 5, player_id: 84, position: 'RB')
RosterSpot.create(team_id: 5, player_id: 250, position: 'WR')
RosterSpot.create(team_id: 5, player_id: 286, position: 'WR')
RosterSpot.create(team_id: 5, player_id: 439, position: 'TE')
RosterSpot.create(team_id: 5, player_id: 294, position: 'R/W/T')
RosterSpot.create(team_id: 5, player_id: 554, position: 'K')
RosterSpot.create(team_id: 5, player_id: 589, position: 'DEF')
RosterSpot.create(team_id: 5, player_id: 34, position: 'BN')
RosterSpot.create(team_id: 5, player_id: 91, position: 'BN')
RosterSpot.create(team_id: 5, player_id: 100, position: 'BN')
RosterSpot.create(team_id: 5, player_id: 270, position: 'BN')
RosterSpot.create(team_id: 5, player_id: 292, position: 'BN')
RosterSpot.create(team_id: 5, player_id: 453, position: 'BN')

RosterSpot.create(team_id: 6, player_id: 18, position: 'QB')
RosterSpot.create(team_id: 6, player_id: 97, position: 'RB')
RosterSpot.create(team_id: 6, player_id: 95, position: 'RB')
RosterSpot.create(team_id: 6, player_id: 258, position: 'WR')
RosterSpot.create(team_id: 6, player_id: 234, position: 'WR')
RosterSpot.create(team_id: 6, player_id: 440, position: 'TE')
RosterSpot.create(team_id: 6, player_id: 265, position: 'R/W/T')
RosterSpot.create(team_id: 6, player_id: 555, position: 'K')
RosterSpot.create(team_id: 6, player_id: 590, position: 'DEF')
RosterSpot.create(team_id: 6, player_id: 40, position: 'BN')
RosterSpot.create(team_id: 6, player_id: 93, position: 'BN')
RosterSpot.create(team_id: 6, player_id: 99, position: 'BN')
RosterSpot.create(team_id: 6, player_id: 281, position: 'BN')
RosterSpot.create(team_id: 6, player_id: 285, position: 'BN')
RosterSpot.create(team_id: 6, player_id: 605, position: 'BN')

RosterSpot.create(team_id: 7, player_id: 20, position: 'QB')
RosterSpot.create(team_id: 7, player_id: 109, position: 'RB')
RosterSpot.create(team_id: 7, player_id: 114, position: 'RB')
RosterSpot.create(team_id: 7, player_id: 291, position: 'WR')
RosterSpot.create(team_id: 7, player_id: 247, position: 'WR')
RosterSpot.create(team_id: 7, player_id: 442, position: 'TE')
RosterSpot.create(team_id: 7, player_id: 302, position: 'R/W/T')
RosterSpot.create(team_id: 7, player_id: 556, position: 'K')
RosterSpot.create(team_id: 7, player_id: 591, position: 'DEF')
RosterSpot.create(team_id: 7, player_id: 19, position: 'BN')
RosterSpot.create(team_id: 7, player_id: 112, position: 'BN')
RosterSpot.create(team_id: 7, player_id: 92, position: 'BN')
RosterSpot.create(team_id: 7, player_id: 261, position: 'BN')
RosterSpot.create(team_id: 7, player_id: 275, position: 'BN')
RosterSpot.create(team_id: 7, player_id: 606, position: 'BN')

RosterSpot.create(team_id: 8, player_id: 14, position: 'QB')
RosterSpot.create(team_id: 8, player_id: 85, position: 'RB')
RosterSpot.create(team_id: 8, player_id: 78, position: 'RB')
RosterSpot.create(team_id: 8, player_id: 242, position: 'WR')
RosterSpot.create(team_id: 8, player_id: 276, position: 'WR')
RosterSpot.create(team_id: 8, player_id: 444, position: 'TE')
RosterSpot.create(team_id: 8, player_id: 106, position: 'R/W/T')
RosterSpot.create(team_id: 8, player_id: 557, position: 'K')
RosterSpot.create(team_id: 8, player_id: 593, position: 'DEF')
RosterSpot.create(team_id: 8, player_id: 28, position: 'BN')
RosterSpot.create(team_id: 8, player_id: 87, position: 'BN')
RosterSpot.create(team_id: 8, player_id: 94, position: 'BN')
RosterSpot.create(team_id: 8, player_id: 279, position: 'BN')
RosterSpot.create(team_id: 8, player_id: 272, position: 'BN')
RosterSpot.create(team_id: 8, player_id: 301, position: 'BN')

RosterSpot.create(team_id: 9, player_id: 6, position: 'QB')
RosterSpot.create(team_id: 9, player_id: 71, position: 'RB')
RosterSpot.create(team_id: 9, player_id: 74, position: 'RB')
RosterSpot.create(team_id: 9, player_id: 295, position: 'WR')
RosterSpot.create(team_id: 9, player_id: 293, position: 'WR')
RosterSpot.create(team_id: 9, player_id: 445, position: 'TE')
RosterSpot.create(team_id: 9, player_id: 133, position: 'R/W/T')
RosterSpot.create(team_id: 9, player_id: 558, position: 'K')
RosterSpot.create(team_id: 9, player_id: 595, position: 'DEF')
RosterSpot.create(team_id: 9, player_id: 44, position: 'BN')
RosterSpot.create(team_id: 9, player_id: 103, position: 'BN')
RosterSpot.create(team_id: 9, player_id: 104, position: 'BN')
RosterSpot.create(team_id: 9, player_id: 290, position: 'BN')
RosterSpot.create(team_id: 9, player_id: 273, position: 'BN')
RosterSpot.create(team_id: 9, player_id: 578, position: 'BN')

RosterSpot.create(team_id: 10, player_id: 48, position: 'QB')
RosterSpot.create(team_id: 10, player_id: 86, position: 'RB')
RosterSpot.create(team_id: 10, player_id: 101, position: 'RB')
RosterSpot.create(team_id: 10, player_id: 239, position: 'WR')
RosterSpot.create(team_id: 10, player_id: 271, position: 'WR')
RosterSpot.create(team_id: 10, player_id: 447, position: 'TE')
RosterSpot.create(team_id: 10, player_id: 111, position: 'R/W/T')
RosterSpot.create(team_id: 10, player_id: 561, position: 'K')
RosterSpot.create(team_id: 10, player_id: 609, position: 'DEF')
RosterSpot.create(team_id: 10, player_id: 47, position: 'BN')
RosterSpot.create(team_id: 10, player_id: 90, position: 'BN')
RosterSpot.create(team_id: 10, player_id: 105, position: 'BN')
RosterSpot.create(team_id: 10, player_id: 300, position: 'BN')
RosterSpot.create(team_id: 10, player_id: 282, position: 'BN')
RosterSpot.create(team_id: 10, player_id: 577, position: 'BN')

trade1 = Trade.create(sender_id: 1, receiver_id: 2, status: 'sent')
trade1.trade_send_players.create(player_id: 77)
trade1.trade_send_players.create(player_id: 238)
trade1.trade_receive_players.create(player_id: 79)
trade1.trade_receive_players.create(player_id: 257)

trade2 = Trade.create(sender_id: 2, receiver_id: 1, status: 'sent')
trade2.trade_send_players.create(player_id: 10)
trade2.trade_send_players.create(player_id: 69)
trade2.trade_receive_players.create(player_id: 9)
trade2.trade_receive_players.create(player_id: 248)

League.first.update({ current_week: 9 })