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

ActiveRecord::Schema.define(version: 20140716135958) do

  create_table "game_scores", force: true do |t|
    t.integer  "points"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_scores", ["game_id"], name: "index_game_scores_on_game_id"
  add_index "game_scores", ["user_id"], name: "index_game_scores_on_user_id"

  create_table "games", force: true do |t|
    t.integer  "webservice_id"
    t.integer  "vippredictor_id"
    t.string   "status"
    t.boolean  "complete"
    t.integer  "weight"
    t.date     "date"
    t.integer  "away_team_id"
    t.integer  "home_team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["away_team_id"], name: "index_games_on_away_team_id"
  add_index "games", ["home_team_id"], name: "index_games_on_home_team_id"

  create_table "predictions", force: true do |t|
    t.integer  "home_team_goal"
    t.integer  "away_team_goal"
    t.integer  "game_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "predictions", ["game_id"], name: "index_predictions_on_game_id"
  add_index "predictions", ["user_id"], name: "index_predictions_on_user_id"

  create_table "results", force: true do |t|
    t.integer  "home_team_goal"
    t.integer  "away_team_goal"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["game_id"], name: "index_results_on_game_id"

  create_table "scores", force: true do |t|
    t.integer  "points"
    t.integer  "position"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["user_id"], name: "index_scores_on_user_id"

  create_table "teams", force: true do |t|
    t.string   "code_fifa"
    t.string   "code_vippredictor"
    t.string   "name"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "image"
    t.string   "name"
    t.integer  "vippredictor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
