class CreateDroppedPlayers < ActiveRecord::Migration
  def change
    create_table :dropped_players do |t|
      t.integer :add_drop_id, null: false
      t.integer :player_id, null: false

      t.timestamps
    end

    add_index :dropped_players, [:add_drop_id, :player_id], unique: true
  end
end
