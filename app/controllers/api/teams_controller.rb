class Api::TeamsController < ApplicationController
  before_action :find_team, only: [:show, :edit, :update]

  def new
    @team = Team.new

    render :new
  end

  def create
    @team = current_user.teams.new(team_params)
    @team.league_id = params[:league_id]

    @team.waiver = @team.league.teams.length

    if @team.save
      set_flash(:success, "Created your team successfully!")

      render json: @team
    else
      set_flash_now(:error, @team.errors.full_messages)

      render json: @team.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    @current_user_team = current_user.teams.where(league_id: params[:league_id])
    render :show
  end

  def edit
    render :edit
  end

  def index
    @league = League.find(params[:league_id])
    render json: @league.teams
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
      params.require(:team).permit(:name, :league_id)
    end

    def find_team
      @team = Team.includes(:players, :owner, league: :teams).find(params[:id])
    end
end
