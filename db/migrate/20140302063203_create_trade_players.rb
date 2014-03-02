class CreateTradePlayers < ActiveRecord::Migration
  def change
    create_table :trade_players do |t|
      t.integer :trade_id, null: false
      t.integer :player_id, null: false

      t.timestamps
    end

    add_index :trade_players, [:trade_id, :player_id], unique: true
  end
end
