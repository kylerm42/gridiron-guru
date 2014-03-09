# == Schema Information
#
# Table name: add_drops
#
#  id         :integer          not null, primary key
#  team_id    :integer          not null
#  status     :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

class AddDrop < ActiveRecord::Base
  validates :team_id, presence: true
  validates :status, presence: true, inclusion: { in: 1..4 }

  belongs_to :team
  has_many :added_players,
           dependent: :destroy,
           inverse_of: :add_drop
  has_many :dropped_players,
           dependent: :destroy,
           inverse_of: :add_drop
end
