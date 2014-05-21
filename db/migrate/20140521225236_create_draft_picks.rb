class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.team_id :integer
      t.player_id :integer

      t.timestamps
    end
    
    add_index :draft_picks, [:team_id, :player_id], unique: true
  end
end
