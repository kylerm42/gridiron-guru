class WeeklyStat < ActiveRecord::Base
  validates :player_id, :week_id, presence: true

  belongs_to :player
end
