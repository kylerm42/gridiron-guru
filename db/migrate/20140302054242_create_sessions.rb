class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :token, null: false
      t.integer :user_id, null: false
      t.string :device

      t.timestamps
    end

    add_index :sessions, :token, unique: true
  end
end
