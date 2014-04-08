json.(@league, :id, :name, :current_week)
member = false

json.teams @league.teams do |team|
  json.(team, :id, :name, :user_id, :wins, :losses, :ties, :waiver)
  json.owner do
    json.(team.owner, :id, :username, :first_name, :last_name)
  end

  json.roster_spots team.roster_spots do |roster_spot|
    json.(roster_spot, :id, :position)
    json.player do
      if roster_spot.player_id
        json.(roster_spot.player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.id nil
      end
    end
  end

  json.owned team.owner.id == @user.id
  if team.owner.id == @user.id
    member = true

    json.sent_trades team.sent_trades
                         .select { |trade| trade.status == 'sent' } do |trade|
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

    json.received_trades team.received_trades
                             .select { |trade| trade.status == 'sent' } do |trade|
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
end

json.member member