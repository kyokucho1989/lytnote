# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_12_202333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "done_lists", force: :cascade do |t|
    t.integer "daily_comment_id"
    t.integer "type_id"
    t.string "name"
    t.float "work_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plan_lists", force: :cascade do |t|
    t.integer "user_id"
    t.string "plan_name"
    t.integer "type_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "deadline"
    t.integer "status_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plan_review_lists", force: :cascade do |t|
    t.integer "plan_id"
    t.integer "review_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_daily_comments", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_comment_on"
    t.string "daily_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_review_comments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
