class Api::RosterSpotsController < ApplicationController
  def update
    @roster_spot = RosterSpot.includes(:player, team: [:owner]).find(params[:id])
    @team = @roster_spot.team
    @current_user = current_user

    if @roster_spot.update_attributes(roster_spot_params)
      render :show
    else
      render json: @roster_spot.errors
    end
  end

  def index
    @week = params[:week] || 'all'
    @user = current_user
    @team = Team.includes(:owner).find(params[:team_id])
    @roster_spots = RosterSpot.includes(player: :weekly_stats).where(player_id: params[:players])
    render :index
  end

  private

    def roster_spot_params
      params.require(:roster_spot).permit(:position, :player_id)
    end
end
