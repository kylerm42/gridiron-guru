class TeamsController < ApplicationController
  def new
    @team = Team.new

    render :new
  end

  def create
    @team = current_user.teams.new(team_params)
    @team.league_id = params[:league_id]

    if @team.save
      flash[:success] ||= []
      flash[:success] << "Created your team successfully!"

      redirect_to league_url(@team.league_id)
    else
      flash.now[:error] ||= []
      flash.now[:error] += @team.errors.full_messages

      render :new
    end
  end

  def show
    @team = Team.find(params[:id])

    render :show
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
