class PlayersController < ApplicationController
  def index
    @players = Player.all
  end
end
