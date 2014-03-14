# == Schema Information
#
# Table name: watched_players
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  player_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class WatchedPlayer < ActiveRecord::Base
  validates :team, :player_id, presence: true
  validates :player_id, uniqueness: { scope: :team_id }

  belongs_to :team, inverse_of: :watched_player_joins
  belongs_to :player
end