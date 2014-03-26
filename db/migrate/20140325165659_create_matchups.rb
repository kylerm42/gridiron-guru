class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :week, null: false
      t.integer :home_team_id, null: false
      t.float :home_team_score, default: 0
      t.integer :away_team_id, null: false
      t.float :away_team_score, default: 0

      t.timestamps
    end
  end
end
