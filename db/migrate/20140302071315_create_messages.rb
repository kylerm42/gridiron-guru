class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :poster_id
      t.references :messageable, polymorphic: true

      t.timestamps
    end

    add_index :messages, :messageable
  end
end
