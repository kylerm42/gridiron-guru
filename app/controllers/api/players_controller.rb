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
    @positions = params[:positions]
    @positions = ['QB', 'RB', 'WR', 'TE'] if @positions == 'all' || !@positions
    @positions = ['RB', 'WR', 'TE'] if @positions == 'R/W/T'

    @page = params[:page].to_i || 1
    @offset = (@page) * 35 || 0

    @current_team = current_user.teams.includes(:players)
                                      .find_by_league_id(params[:league_id])
    @all_players = Player.find_by_sql([query, params[:league_id], @positions])
                         .sort_by { |player| -player.points }
    @players = @all_players[@offset...@offset + 35]
    p @offset
    render :index
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end
end


