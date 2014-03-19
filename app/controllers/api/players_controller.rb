class Api::PlayersController < ApplicationController
  def index
    @players = Player.includes(team: :id).all.sample(50)
    render :index
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end
end


# SELECT
#   p.first_name, p.last_name, j.tid, j.tname
# FROM
#   players p LEFT OUTER JOIN
#   (SELECT
#     t.id tid, t.name tname, tp.player_id player_id
#   FROM
#     teams t JOIN team_players tp
#       ON t.id = tp.team_id
#     WHERE
#       t.league_id = 1) j
#   ON p.id = j.player_id;