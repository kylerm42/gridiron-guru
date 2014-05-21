class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :position, null: false
      t.string :nfl_team, null: false, default: 'FA'
      t.date :birthdate
      t.string :college
      t.integer :height
      t.integer :weight
      t.integer :years_pro
      t.integer :profile_id
      t.string :gsis_id

      t.integer :pass_yards, default: 0
      t.integer :pass_tds, default: 0
      t.integer :pass_ints, default: 0
      t.integer :rush_att, default: 0
      t.integer :rush_yards, default: 0
      t.integer :rush_tds, default: 0
      t.integer :receptions, default: 0
      t.integer :rec_yards, default: 0
      t.integer :rec_tds, default: 0
      t.integer :fumbles, default: 0
      t.integer :two_pt_conv, default: 0

      t.integer :made_pat, default: 0
      t.integer :miss_pat, default: 0
      t.integer :made_20, default: 0
      t.integer :miss_20, default: 0
      t.integer :made_30, default: 0
      t.integer :miss_30, default: 0
      t.integer :made_40, default: 0
      t.integer :miss_40, default: 0
      t.integer :made_50, default: 0
      t.integer :miss_50, default: 0
      t.integer :made_50_plus, default: 0
      t.integer :miss_50_plus, default: 0

      t.integer :sacks, default: 0
      t.integer :interceptions, default: 0
      t.integer :fum_rec, default: 0
      t.integer :safeties, default: 0
      t.integer :def_tds, default: 0
      t.integer :ret_tds, default: 0
      t.integer :sacks, default: 0
      t.integer :pts_allowed, default: 0

      t.timestamps
    end

    add_index :players, :position
    add_index :players, [:last_name, :first_name]
    add_index :players, :nfl_team
  end
end
