send_count = 0
receive_count = 0

json.sender do
  json.(@sender, :id, :name, :user_id, :wins, :losses, :ties, :waiver)
  json.roster_spots @sender.roster_spots do |roster_spot|
    send_count += 1
    json.(roster_spot, :id, :position)
    json.player do
      if roster_spot.player_id
        json.(roster_spot.player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.id nil
      end
    end
  end
end

json.receiver do
  json.(@receiver, :id, :name, :user_id, :wins, :losses, :ties, :waiver)
  json.roster_spots @receiver.roster_spots do |roster_spot|
    receive_count += 1
    json.(roster_spot, :id, :position)
    json.player do
      if roster_spot.player_id
        json.(roster_spot.player, :id, :first_name, :last_name, :position, :nfl_team, :pass_yards, :pass_tds, :pass_ints, :rush_yards, :rush_tds, :receptions, :rec_yards, :rec_tds, :fumbles, :two_pt_conv, :made_pat, :miss_pat, :made_20, :miss_20, :made_30, :miss_30, :made_40, :miss_40, :made_50, :miss_50, :made_50_plus, :miss_50_plus, :sacks, :interceptions, :fum_rec, :safeties, :def_tds, :ret_tds, :pts_allowed)
      else
        json.id nil
      end
    end
  end
end

json.number_of_senders_players @sender.roster_spots.count
json.number_of_receivers_players @receiver.roster_spots.count
json.number_of_times_looped_through_senders_players send_count
json.number_of_times_looped_through_receivers_players receive_count