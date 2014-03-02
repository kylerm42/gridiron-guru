class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :position, null: false
      t.integer :nfl_team_id

      t.timestamps
    end

    add_index :players, :position
    add_index :players, [:last_name, :first_name]
    add_index :players, :nfl_team_id
  end
end
