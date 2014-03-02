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
  validates :team_id, :player_id, presence: true

  belongs_to :team
  belongs_to :player
end