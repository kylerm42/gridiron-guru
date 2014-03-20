json.(@league, :id, :name)

json.teams @league.teams do |team|
  json.(team, :id, :name, :user_id, :wins, :losses, :ties, :waiver)
  json.owner do
    json.(team.owner, :id, :username, :first_name, :last_name)
  end
end