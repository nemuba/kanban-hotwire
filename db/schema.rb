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

ActiveRecord::Schema[7.1].define(version: 2023_10_22_201752) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "workspace_id"], name: "index_boards_on_title_and_workspace_id", unique: true
    t.index ["workspace_id"], name: "index_boards_on_workspace_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_cards_on_board_id"
    t.index ["title", "board_id"], name: "index_cards_on_title_and_board_id", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_workspaces_on_title_trgm", opclass: :gin_trgm_ops, using: :gin
  end

  add_foreign_key "boards", "workspaces"
  add_foreign_key "cards", "boards"
end
