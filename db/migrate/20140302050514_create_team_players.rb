class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.integer :team_id, null: false
      t.integer :player_id, null: false

      t.timestamps
    end

    add_index :team_players, [:team_id, :player_id], unique: true
  end
end
