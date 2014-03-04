# == Schema Information
#
# Table name: players
#
#  id          :integer          not null, primary key
#  first_name  :string(255)      not null
#  last_name   :string(255)      not null
#  position    :string(255)      not null
#  nfl_team_id :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Player < ActiveRecord::Base
  require 'addressable/uri'

  POSITIONS = %w{ QB RB WR TE K DEF }

  validates :first_name, :last_name, presence: true
  validates :position, presence: true, inclusion: { in: POSITIONS }
  validates :nfl_team_id, inclusion: { in: 0..32 }

  has_many :team_players,
           dependent: :destroy
  has_many :teams,
           through: :team_players,
           source: :team
  has_many :leagues,
           through: :teams,
           source: :league

  def self.get_espn_players(offset)
    url = Addressable::URI.new(
      :scheme => "http",
      :host => "api.espn.com",
      :path => "v1/sports/football/nfl/athletes",
      :query_values => {
        :apikey => "v2tytku2pcn92zhduzx7a3gp",
        :offset => offset
      }
    ).to_s
    res = JSON.parse(RestClient.get(url))
    res["sports"][0]["leagues"][0]["athletes"].each do |athlete|
      player = Player.new(first_name: athlete["firstName"],
                 last_name: athlete["lastName"],
                 position: POSITIONS.sample,
                 nfl_team_id: (0..32).to_a.sample)
      player.save!
    end
  end
end
