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

ActiveRecord::Schema[7.0].define(version: 2023_02_24_194010) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "placements", force: :cascade do |t|
    t.integer "position", null: false
    t.bigint "racer_id"
    t.bigint "race_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["position", "race_id"], name: "index_placements_on_position_and_race_id", unique: true
    t.index ["position", "racer_id"], name: "index_placements_on_position_and_racer_id", unique: true
    t.index ["race_id"], name: "index_placements_on_race_id"
    t.index ["racer_id", "race_id"], name: "index_placements_on_racer_id_and_race_id", unique: true
    t.index ["racer_id"], name: "index_placements_on_racer_id"
  end

  create_table "racers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.date "born_at", null: false
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.date "date", null: false
    t.string "place", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tournament_id"
    t.index ["tournament_id"], name: "index_races_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
