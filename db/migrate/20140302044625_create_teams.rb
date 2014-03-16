class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :league_id, null: false
      t.integer :wins, null: false, default: 0
      t.integer :losses, null: false, default: 0
      t.integer :ties, null: false, default: 0
      t.integer :waiver, null: false, default: 1

      t.timestamps
    end

    add_index :teams, [:user_id, :league_id], unique: true
    add_index :teams, [:name, :league_id], unique: true
    add_index :teams, :league_id
  end
end
