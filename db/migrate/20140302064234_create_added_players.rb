class CreateAddedPlayers < ActiveRecord::Migration
  def change
    create_table :added_players do |t|
      t.integer :add_drop_id, null: false
      t.integer :player_id, null: false

      t.timestamps
    end

    add_index :added_players, [:add_drop_id, :player_id], unique: true
  end
end
