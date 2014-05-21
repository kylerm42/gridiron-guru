class DraftPick < ActiveRecord::Base
  validates :team_id, :player_id, presence: true
  validates :team_id, uniqueness: { scope: :league_id }
  
  belongs_to :player
  belongs_to :team
end
