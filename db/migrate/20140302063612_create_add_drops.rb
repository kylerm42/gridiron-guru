class CreateAddDrops < ActiveRecord::Migration
  def change
    create_table :add_drops do |t|
      t.integer :team_id, null: false
      t.integer :status, null: false

      t.timestamps
    end

    add_index :add_drops, :team_id
  end
end
