class Api::MatchupsController < ApplicationController
  def show
    @matchup = Matchup.includes(home_team: [:owner,
                                            roster_spots: [player: [:weekly_stats]]],
                                away_team: [:owner,
                                            roster_spots: [player: [:weekly_stats]]],)
                      .find(params[:id])
    @week = @matchup.week
    render :show
  end
end
