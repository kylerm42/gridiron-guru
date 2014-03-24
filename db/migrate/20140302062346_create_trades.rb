class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.string :status, null: false, default: 'sent'

      t.timestamps
    end

    add_index :trades, :sender_id
    add_index :trades, :receiver_id
  end
end
