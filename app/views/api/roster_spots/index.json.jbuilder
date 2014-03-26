json.roster_spots @roster_spots do |roster_spot|
  json.(roster_spot, :id, :position)
  json.player do
    if @week == 'all'
      json.(roster_spot.player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
    else
      json.(roster_spot.player, :id, :first_name, :last_name, :position, :nfl_team)
      @stats = roster_spot.player.weekly_stats.find{ |stat| stat.week == @week.to_i }
      if @stats
        json.(@stats, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.bye true
      end
    end

    json.team do
      json.id @team.id
      json.name @team.name
      json.current_team @team.owner.id == @user.id
    end
  end
end