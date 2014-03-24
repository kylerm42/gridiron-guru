# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140323002512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_drops", force: true do |t|
    t.integer  "team_id",                null: false
    t.integer  "status",     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "add_drops", ["team_id"], name: "index_add_drops_on_team_id", using: :btree

  create_table "added_players", force: true do |t|
    t.integer  "add_drop_id", null: false
    t.integer  "player_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "added_players", ["add_drop_id", "player_id"], name: "index_added_players_on_add_drop_id_and_player_id", unique: true, using: :btree

  create_table "dropped_players", force: true do |t|
    t.integer  "add_drop_id", null: false
    t.integer  "player_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dropped_players", ["add_drop_id", "player_id"], name: "index_dropped_players_on_add_drop_id_and_player_id", unique: true, using: :btree

  create_table "leagues", force: true do |t|
    t.string   "name",                            null: false
    t.integer  "manager_id",                      null: false
    t.string   "password_digest"
    t.boolean  "private",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leagues", ["manager_id"], name: "index_leagues_on_manager_id", using: :btree
  add_index "leagues", ["name"], name: "index_leagues_on_name", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body"
    t.integer  "poster_id"
    t.integer  "messageable_id"
    t.string   "messageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["messageable_id", "messageable_type"], name: "index_messages_on_messageable_id_and_messageable_type", using: :btree

  create_table "players", force: true do |t|
    t.string   "first_name",                   null: false
    t.string   "last_name",                    null: false
    t.string   "position",                     null: false
    t.string   "nfl_team",      default: "FA", null: false
    t.integer  "pass_yards",    default: 0
    t.integer  "pass_tds",      default: 0
    t.integer  "pass_ints",     default: 0
    t.integer  "rush_yards",    default: 0
    t.integer  "rush_tds",      default: 0
    t.integer  "receptions",    default: 0
    t.integer  "rec_yards",     default: 0
    t.integer  "rec_tds",       default: 0
    t.integer  "fumbles",       default: 0
    t.integer  "two_pt_conv",   default: 0
    t.integer  "made_pat",      default: 0
    t.integer  "miss_pat",      default: 0
    t.integer  "made_20",       default: 0
    t.integer  "miss_20",       default: 0
    t.integer  "made_30",       default: 0
    t.integer  "miss_30",       default: 0
    t.integer  "made_40",       default: 0
    t.integer  "miss_40",       default: 0
    t.integer  "made_50",       default: 0
    t.integer  "miss_50",       default: 0
    t.integer  "made_50_plus",  default: 0
    t.integer  "miss_50_plus",  default: 0
    t.integer  "sacks",         default: 0
    t.integer  "interceptions", default: 0
    t.integer  "fum_rec",       default: 0
    t.integer  "safeties",      default: 0
    t.integer  "def_tds",       default: 0
    t.integer  "ret_tds",       default: 0
    t.integer  "pts_allowed",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["last_name", "first_name"], name: "index_players_on_last_name_and_first_name", using: :btree
  add_index "players", ["nfl_team"], name: "index_players_on_nfl_team", using: :btree
  add_index "players", ["position"], name: "index_players_on_position", using: :btree

  create_table "roster_spots", force: true do |t|
    t.integer  "team_id",                   null: false
    t.integer  "player_id"
    t.string   "position",   default: "BN", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roster_spots", ["team_id", "player_id"], name: "index_roster_spots_on_team_id_and_player_id", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.string   "token",      null: false
    t.integer  "user_id",    null: false
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string   "name",                   null: false
    t.integer  "user_id",                null: false
    t.integer  "league_id",              null: false
    t.integer  "wins",       default: 0, null: false
    t.integer  "losses",     default: 0, null: false
    t.integer  "ties",       default: 0, null: false
    t.integer  "waiver",     default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["league_id"], name: "index_teams_on_league_id", using: :btree
  add_index "teams", ["name", "league_id"], name: "index_teams_on_name_and_league_id", unique: true, using: :btree
  add_index "teams", ["user_id", "league_id"], name: "index_teams_on_user_id_and_league_id", unique: true, using: :btree

  create_table "trade_receive_players", force: true do |t|
    t.integer  "trade_id",   null: false
    t.integer  "player_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_receive_players", ["trade_id", "player_id"], name: "index_trade_receive_players_on_trade_id_and_player_id", unique: true, using: :btree

  create_table "trade_send_players", force: true do |t|
    t.integer  "trade_id",   null: false
    t.integer  "player_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trade_send_players", ["trade_id", "player_id"], name: "index_trade_send_players_on_trade_id_and_player_id", unique: true, using: :btree

  create_table "trades", force: true do |t|
    t.integer  "sender_id",                    null: false
    t.integer  "receiver_id",                  null: false
    t.string   "status",      default: "sent", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trades", ["receiver_id"], name: "index_trades_on_receiver_id", using: :btree
  add_index "trades", ["sender_id"], name: "index_trades_on_sender_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "watched_players", force: true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
