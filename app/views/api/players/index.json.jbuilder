json.players @players do |player|
  json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
  json.team do
    json.id player.attributes['team_id']
    json.name player.attributes['team_name']
    json.current_team @current_team.id == player.attributes['team_id']
  end
end

json.current_team do
  json.(@current_team, :id, :name, :league_id)
  json.players @current_team.players do |player|
    json.(player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
  end
end