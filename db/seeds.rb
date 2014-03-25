# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Player.seed_players

User.create(username: "test",
            first_name: "Test",
            last_name: "User",
            email: "test@test.com",
            password: "123456")

User.create(username: "test2",
            first_name: "John",
            last_name: "Doe",
            email: "test2@test.com",
            password: "123456")

User.create(username: "test3",
            first_name: "John",
            last_name: "Doe",
            email: "test3@test.com",
            password: "123456")

User.create(username: "test4",
            first_name: "John",
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

League.create(name: "Test league", manager_id: 1)

Team.create(name: "Test team", user_id: 1, league_id: 1)
Team.create(name: "Z team", user_id: 2, league_id: 1)
Team.create(name: "3 team", user_id: 3, league_id: 1)
Team.create(name: "4 team", user_id: 4, league_id: 1)
Team.create(name: "5 team", user_id: 5, league_id: 1)
Team.create(name: "6 team", user_id: 6, league_id: 1)
Team.create(name: "7 team", user_id: 7, league_id: 1)
Team.create(name: "8 team", user_id: 8, league_id: 1)
Team.create(name: "9 team", user_id: 9, league_id: 1)
Team.create(name: "0 team", user_id: 10, league_id: 1)

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

trade1 = Trade.create(sender_id: 1, receiver_id: 2, status: 'sent')
trade1.trade_send_players.create(player_id: 77)
trade1.trade_send_players.create(player_id: 238)
trade1.trade_receive_players.create(player_id: 79)
trade1.trade_receive_players.create(player_id: 257)

trade2 = Trade.create(sender_id: 2, receiver_id: 1, status: 'sent')
trade2.trade_send_players.create(player_id: 10)
trade2.trade_send_players.create(player_id: 69)
trade2.trade_receive_players.create(player_id: 9)
trade2.trade_receive_players.create(player_id: 237)