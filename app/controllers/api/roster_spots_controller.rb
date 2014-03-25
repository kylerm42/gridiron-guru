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

  private

    def roster_spot_params
      params.require(:roster_spot).permit(:position, :player_id)
    end
end
