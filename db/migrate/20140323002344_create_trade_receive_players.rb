class CreateTradeReceivePlayers < ActiveRecord::Migration
  def change
    create_table :trade_receive_players do |t|
      t.integer :trade_id, null: false
      t.integer :player_id, null: false

      t.timestamps
    end
    add_index :trade_receive_players, [:trade_id, :player_id], unique: true
  end
end
