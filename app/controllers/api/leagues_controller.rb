class Api::LeaguesController < ApplicationController
  before_action :find_league, only: [:show, :edit, :update]
  before_action :unauthorized_redirect, only: [:edit, :update, :destroy]
  before_action :private_league_redirect, only: :show
  before_action :require_sign_in

  def index
    @leagues = League.where(private: false)
    render json: @leagues
  end

  def for_user
    @leagues = current_user.leagues
    render json: @leagues
  end

  def new
    if logged_in?
      @league = League.new

      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @league = current_user.managed_leagues.new(league_params)

    if @league.save
      set_flash(:success, "League successfully created!")

      redirect_to new_league_team_url(@league)
    else
      set_flash_now(:error, @league.errors.full_messages)

      render :new
    end
  end

  def show
    @league = League.find(params[:id])
    render json: @league
  end

  def edit
    render :edit
  end

  def update
    if @league.update_attributes(league_params)
      set_flash(:success, "League updated successfully")

      redirect_to league_url(@league)
    else
      set_flash_now(:error, @league.errors.full_messages)

      render :edit
    end
  end

  private

    def league_params
      params.require(:league).permit(:name, :private, :password)
    end

    def find_league
      @league = League.find(params[:id])
    end

    def unauthorized_redirect
      unless @league.manager_id == current_user.id
        set_flash(:warning, "You are not authroized to do that")
        redirect_to league_url(@league)
      end
    end

    def private_league_redirect
      unless current_user && current_user.leagues.include?(@league)
        set_flash(:warning, "You must be a member to view this private league")
        redirect_to new_session_url
      end
    end
end
