# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_05_000542) do
  create_table "clubs", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.bigint "owner_id", null: false
    t.integer "players_count", default: 0, null: false
    t.string "cover_image_url"
    t.index ["owner_id"], name: "index_clubs_on_owner_id"
  end

  create_table "games", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "winner_id", null: false
    t.bigint "loser_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loser_id"], name: "index_games_on_loser_id"
    t.index ["winner_id"], name: "index_games_on_winner_id"
  end

  create_table "jwt_denylist", charset: "utf8mb4", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "memberships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "club_id", null: false
    t.integer "rating", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["club_id"], name: "fk_rails_2410b5d7e1"
    t.index ["player_id"], name: "fk_rails_99f428b8c5"
  end

  create_table "players", charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 1
    t.string "description"
    t.index ["email"], name: "index_players_on_email", unique: true
  end

  add_foreign_key "clubs", "players", column: "owner_id"
  add_foreign_key "games", "memberships", column: "loser_id", on_delete: :cascade
  add_foreign_key "games", "memberships", column: "winner_id", on_delete: :cascade
  add_foreign_key "memberships", "clubs", on_delete: :cascade
  add_foreign_key "memberships", "players"
end
