class CreateRosterSpots < ActiveRecord::Migration
  def change
    create_table :roster_spots do |t|
      t.integer :team_id, null: false
      t.integer :player_id
      t.string :position, null: false, default: 'BN'

      t.timestamps
    end

    add_index :roster_spots, :team_id
    add_index :roster_spots, :player_id
  end
end
