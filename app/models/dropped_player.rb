# == Schema Information
#
# Table name: dropped_players
#
#  id          :integer          not null, primary key
#  add_drop_id :integer          not null
#  player_id   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class DroppedPlayer < ActiveRecord::Base
  validates :add_drop_id, :player_id, presence: true
  validates :player_id, uniqueness: { scope: :add_drop_id }

  belongs_to :add_drop,
             inverse_of: :dropped_players
  belongs_to :player
  has_one :team,
          through: :add_drop,
          source: :team
end