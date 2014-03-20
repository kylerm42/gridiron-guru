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

League.create(name: "Test league", manager_id: 1)

Team.create(name: "Test team", user_id: 1, league_id: 1)
Team.create(name: "Z team", user_id: 2, league_id: 1)

TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 1, player_id: rand(Player.all.length))

TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))
TeamPlayer.create(team_id: 2, player_id: rand(Player.all.length))