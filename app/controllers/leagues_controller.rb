class LeaguesController < ApplicationController
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
      flash[:success] ||= []
      flash[:success] << "League successfully created!"
      redirect_to league_url(@league)
    else

    end
  end

  private

    def league_params
      params.require(:league).permit(:name, :private, :password)
    end
end
