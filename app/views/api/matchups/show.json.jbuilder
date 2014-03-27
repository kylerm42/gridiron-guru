json.(@matchup, :id, :home_team_id, :home_team_score, :away_team_id, :away_team_score, :week)

json.home_team do
  json.(@matchup.home_team, :id, :name, :wins, :losses, :ties)
  json.score @matchup.home_team_score
  json.roster_spots @matchup.home_team.roster_spots do |roster_spot|
    json.(roster_spot, :id, :position)
    json.player do
      @stats = roster_spot.player.weekly_stats.find { |stats| stats.week == @week }
      json.(roster_spot.player, :id, :first_name, :last_name, :nfl_team, :position)
      if @stats
        json.(roster_spot.player.weekly_stats.find { |stats| stats.week == @week }, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.bye true
      end
    end
  end
end
json.away_team do
  json.(@matchup.away_team, :id, :name, :wins, :losses, :ties)
  json.score @matchup.away_team_score
  json.roster_spots @matchup.away_team.roster_spots do |roster_spot|
    json.(roster_spot, :id, :position)
    json.player do
      @stats = roster_spot.player.weekly_stats.find { |stats| stats.week == @week }
      json.(roster_spot.player, :id, :first_name, :last_name, :nfl_team, :position)
      if @stats
        json.(roster_spot.player.weekly_stats.find { |stats| stats.week == @week }, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.bye true
      end
    end
  end
end