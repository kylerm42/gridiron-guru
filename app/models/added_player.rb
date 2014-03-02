# == Schema Information
#
# Table name: added_players
#
#  id          :integer          not null, primary key
#  add_drop_id :integer          not null
#  player_id   :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class AddedPlayer < ActiveRecord::Base
  validates :add_drop_id, :player_id, presence: true

  belongs_to :add_drop
  belongs_to :player
  has_one :team,
          through: :add_drop,
          source: :team
end