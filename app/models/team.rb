# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  league_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  validates :name, :user_id, :league_id, presence: true

  belongs_to :user
  belongs_to :league
  has_many :team_players
  has_many :players,
           through: :team_players,
           source: :player
  has_many :add_drops
  has_many :trades
  has_many :watched_player_joins,
           foreign_key: :team_id,
           class_name: "WatchedPlayer"
  has_many :watched_players,
           through: :watched_player_joins,
           source: :player
end