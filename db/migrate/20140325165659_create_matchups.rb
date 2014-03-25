class CreateMatchups < ActiveRecord::Migration
  def change
    create_table :matchups do |t|
      t.integer :home_team_id
      t.float :home_team_score
      t.integer :away_team_id
      t.float :away_team_score

      t.timestamps
    end
  end
end
