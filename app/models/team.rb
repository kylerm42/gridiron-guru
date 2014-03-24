# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  league_id  :integer          not null
#  wins       :integer          default(0), not null
#  losses     :integer          default(0), not null
#  ties       :integer          default(0), not null
#  waiver     :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  validates :league, presence: true
  validates :name, :user_id, presence: true, uniqueness: { scope: :league_id }


  belongs_to :owner,
             foreign_key: :user_id,
             class_name: "User"
  belongs_to :league,
             inverse_of: :teams
  has_many :roster_spots,
           foreign_key: :team_id,
           class_name: "RosterSpot"
  has_many :players,
           through: :roster_spots,
           source: :player
  has_many :add_drops
  has_many :sent_trades,
           foreign_key: :sender_id,
           class_name: "Trade"
  has_many :received_trades,
           foreign_key: :receiver_id,
           class_name: "Trade"
  has_many :watched_player_joins,
           foreign_key: :team_id,
           class_name: "WatchedPlayer",
           inverse_of: :team
  has_many :watched_players,
           through: :watched_player_joins,
           source: :player
end
