json.(@team, :id, :name, :wins, :losses, :ties, :waiver, :league_id)

json.owner do
  json.(@team.owner, :id, :username, :first_name, :last_name)
end
json.league do
  json.(@team.league, :id, :name)
  json.teams @team.league.teams do |team|
    json.(team, :id, :name)
  end
end
json.roster_spots @team.team_players do |player|
json.players @team.players do |player|
  json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)

  json.team do
    json.id @team.id
    json.name @team.name
    json.current_team @team.owner.id == @user.id
  end
end

if @team == @current_user_team
  json.sent_trades @team.sent_trades.where(status: 'sent') do |trade|
    json.(trade, :id)
    json.sender do
      json.(trade.sender, :id, :name)
    end
    json.receiver do
      json.(trade.receiver, :id, :name)
    end
    json.send_players trade.send_players do |player|
      json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
    end
    json.receive_players trade.receive_players do |player|
      json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
    end
  end

  json.received_trades @team.received_trades.where(status: 'sent') do |trade|
    json.(trade, :id, :status)
    json.sender do
      json.(trade.sender, :id, :name)
    end
    json.receiver do
      json.(trade.receiver, :id, :name)
    end
    json.send_players trade.send_players do |player|
      json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
    end
    json.receive_players trade.receive_players do |player|
      json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
    end
  end
end