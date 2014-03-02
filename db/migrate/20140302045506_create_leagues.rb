class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name, null: false
      t.integer :manager_id, null: false

      t.timestamps
    end

    add_index :leagues, :name
    add_index :leagues, :manager_id
  end
end
