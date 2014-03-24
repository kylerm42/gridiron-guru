class Api::PlayersController < ApplicationController
  def index
    query = <<-SQL
    SELECT
      p.*, j.team_id, j.team_name
    FROM
      players p LEFT OUTER JOIN
      (SELECT
        t.id team_id, t.name team_name, rs.player_id player_id
      FROM
        teams t JOIN roster_spots rs
          ON t.id = rs.team_id
        WHERE
          t.league_id = ?) j
      ON p.id = j.player_id
    WHERE p.position IN (?)
    SQL
    @current_team = current_user.teams.includes(:players)
                                      .find_by_league_id(params[:league_id])
    @players = Player.find_by_sql([query, params[:league_id], ['QB']])
    render :index
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end
end


