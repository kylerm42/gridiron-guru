class TeamsController < ApplicationController
  before_action :find_team, only: [:show, :edit, :update]

  def new
    @team = Team.new

    render :new
  end

  def create
    @team = current_user.teams.new(team_params)
    @team.league_id = params[:league_id]
    @team.waiver = @team.league.length

    if @team.save
      set_flash(:success, "Created your team successfully!")

      redirect_to league_url(@team.league_id)
    else
      set_flash_now(:error, @team.errors.full_messages)

      render :new
    end
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @team.update_attributes(team_params)
      set_flash(:success, "Team updated successfully")
      redirect_to league_team_url(@team.league, @team)
    else
      set_flash_now(:error, @team.errors.full_messages)
      render :edit
    end
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end

    def find_team
      @team = Team.find(params[:id])
    end
end
