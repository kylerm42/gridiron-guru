class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status

      t.timestamps
    end

    add_index :trades, :sender_id
    add_index :trades, :receiver_id
  end
end
